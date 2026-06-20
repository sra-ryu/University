import requests
import pandas as pd
import os
from datetime import datetime
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
import time

BASE_URL = "https://v6.bvg.transport.rest"

def get_station_id(search_term):
    url = f"{BASE_URL}/locations"
    params = {
        "query": search_term,
        "results": 1
    }
    
    response = requests.get(url, params=params)
    
    if response.status_code != 200:
        print(f"API Error: HTTP {response.status_code}")
        return None
    
    data = response.json()
    if not data:
        print("No results found.")
        return None

    station = data[0]
    print(f"Found: {station['name']} -> ID: {station['id']}")
    return station['id']

def get_bus_delay(stop_id, line_name, output_csv="bus_delays.csv"):
    url = f"{BASE_URL}/stops/{stop_id}/departures"
    params = {"duration": 10}

    departures = []
    # If an error occurs, it attempts to connect for next 30 seconds.
    deadline = time.time() + 30
    attempt = 0
    
    while time.time() < deadline:
        attempt += 1
        try:
            response = requests.get(url, params=params, timeout=10)
            data = response.json()
            departures = data.get("departures", [])
            if departures:
                break
            print(f"Attempt {attempt}: no departures, retrying...")
        except Exception as e:
            print(f"Attempt {attempt}: {e}, retrying...")
        
        wait = min(10, deadline - time.time())
        if wait > 0:
            time.sleep(wait)
    else:
        print(f"Skipping stop {stop_id} after 1 minute of retries")
        return None
    
    filtered = [d for d in departures if d.get("line", {}).get("name") == line_name]
    
    if not filtered:
        print(f"No depatures found for {line_name}")
        return None

    rows = [{
        "collected_at": datetime.now().isoformat(),
        "trip_id": d.get("tripId", ""),
        "stop_id": stop_id,
        "stop_name": d.get("stop", {}).get("name", ""),
        "line": line_name,
        "direction": d.get("direction", ""),
        "planned_when": d.get("plannedWhen", ""),
        "actual_when": d.get("when", ""),
        "delay_sec": d.get("delay", 0) or 0,
    } for d in filtered]

    df = pd.DataFrame(rows)

    if os.path.exists(output_csv):
        df.to_csv(output_csv, mode="a", header=False, index=False)
    else:
        df.to_csv(output_csv, index=False)

    print(df[["line", "direction", "planned_when", "delay_sec"]])
    print(f"Saved to {output_csv}")

# sample
stops = ["S+U Rathaus Spandau", "U Ruhleben", "S Westend", "U Ernst-Reuter-Platz", "S+U Zoologischer Garten"]

stop_ids = {}
for stop_name in stops:
    stop_id = get_station_id(stop_name)
    if stop_id:
        stop_ids[stop_name] = stop_id

print(stop_ids)

BASE_DIR = "/Users/ryu/Desktop/study/0_Sose2026/Data Science in Python and R/team/data" # set path of directory
os.makedirs(BASE_DIR, exist_ok=True)

line_name = "M45"
output = os.path.join(BASE_DIR, f"bus_delays_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv")

for stop_name, stop_id in stop_ids.items():
    print(f"\n--- {stop_name} ---")
    get_bus_delay(stop_id, line_name, output_csv=output)