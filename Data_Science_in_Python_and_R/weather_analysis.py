import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import requests
import datetime


""" Exercise 2.1: Read the data for 2019 as a DataFrame and print it. """
# if ";" is used as seperator, add "sep=';'" after 'file.csv')
weather_humidity_2019 = pd.read_csv('data/weather_berlin_2019_humidity.csv')
weather_temp_2019 = pd.read_csv('data/weather_berlin_2019_temp.csv')

# print(weather_humidity_2019)
# print(weather_temp_2019)


""" Exercise 2.2: Check .shape, .columns, .head(), .tail(), and .describe() methods. """
# print(weather_humidity_2019.shape) # number of rows & cols
# print(weather_temp_2019.columns) # name of cols
# print(weather_temp_2019.head())
# print(weather_humidity_2019.tail())
# print(weather_temp_2019.describe()) # show statistics of dataframe


""" Exercise 2.3.1: Compute the average temperature per month. """
# grouped_temp_2019 = weather_temp_2019.groupby('month')
# avg_temp = grouped_temp_2019.aggregate({'temp': 'mean'})
# print(avg_temp.reset_index)
# print(grouped_temp_2019.aggregate(avg_temp = ('temp', 'mean'))) # assign a new name


""" Exercise 2.3.2: What is the average temp in June 2019? """
# print(weather_temp_2019.query('month == 6').aggregate({'temp': 'mean'}))


""" Exercise 2.4.1: Find min and max temp in May 2019 Berlin. """
# print((weather_temp_2019
#  .query('month == 5')
#  .aggregate({'temp': ['min', 'max']})
# ))


""" Exercise 2.4.2: How many days in 2019 had a daily high temp above 25 degrees Celsius in Berlin? """
# print((weather_temp_2019
#        .query('temp > 25')
#        .groupby('month')
#        .aggregate({'temp': 'max'})
#        .shape
# ))


""" Exercise 3.2.1: What kind of variable is avg. temperature? """
# numeric variable


""" Exercise 3.2.2: What kind of variable is month? """
# categorical variable


""" Exercise 3.2.3: What kind of plot would be best to visualize the avg. temperature per month? """
# month is categorical and has continuous nature


""" Exercise 3.3: Plot the average temperature per month in 2019 with catplot(). """
# sns.catplot(data = avg_temp, x = 'month', y = 'temp')
# plt.show() # open window for catplot


""" Exercise 3.4.1: Recreate the plot as a lineplot. """
# sns.catplot(data = avg_temp, x = 'month', y = 'temp', kind = 'point')
# plt.show()


""" Exercise 3.4.2: How to change it as a barplot. """
# sns.catplot(data = avg_temp, x = 'month', y = 'temp', kind = 'bar')
# plt.show()


""" Exercise 4.1: Concatenate the data - temp data in 1980, 1990, 2000, 2010 and 2019. """
df_temp1 = pd.read_csv('data/weather_berlin_1980_temp.csv')
df_temp2 = pd.read_csv('data/weather_berlin_1990_temp.csv')
df_temp3 = pd.read_csv('data/weather_berlin_2000_temp.csv')
df_temp4 = pd.read_csv('data/weather_berlin_2010_temp.csv')
df_temp5 = pd.read_csv('data/weather_berlin_2019_temp.csv')
df_temp = pd.concat([df_temp1, df_temp2, df_temp3, df_temp4, df_temp5])
# print(df_temp)


""" Exercise 4.2: Calculate the average temperature per month and year. """
avg_temp_by_year_month = (df_temp
                          .groupby(by = ['year', 'month'])
                          .aggregate({'temp': 'mean'})
                          .reset_index()
                          )
# print(avg_temp_by_year_month)


""" Exercise 4.3.1: Load humidity data in 1980, 1990, 2000, 2010, 2019 and concatenate the data. """
df_hum1 = pd.read_csv('data/weather_berlin_1980_humidity.csv')
df_hum2 = pd.read_csv('data/weather_berlin_1990_humidity.csv')
df_hum3 = pd.read_csv('data/weather_berlin_2000_humidity.csv')
df_hum4 = pd.read_csv('data/weather_berlin_2010_humidity.csv')
df_hum5 = pd.read_csv('data/weather_berlin_2019_humidity.csv')
df_hum = pd.concat([df_hum1, df_hum2, df_hum3, df_hum4, df_hum5])
# print(df_hum)


""" Exercise 4.3.2: Merge humidity and temperature data. """
df_merge = pd.merge(df_temp, df_hum)
# print(df_merge.head())
# print(df_merge.tail())
# print(df_merge.describe())


""" Exercise 4.3.3: Summarize and calculate the mean temp and humidity per month and year. """
avg_temp_hum_by_year_month = (df_merge
                              .groupby(by = ['year', 'month'])
                              .aggregate({'temp':'mean'})
                              .reset_index()
                              )
# print(avg_temp_hum_by_year_month)


""" Exercise 4.3.4: Compute the avg temp and hum of 2010-12 """
avg_temp_hum_2010 = (df_merge
                     .query('year == 2010 & month == 12')
                     .aggregate({'temp':'mean', 'humidity': 'mean'})
                     )
# print(avg_temp_hum_2010)


""" Exercise 5.2: Make HTTP request. """
url = "https://api.openweathermap.org/data/2.5/weather?q=Berlin&units=metric&appid={key}}"
r = requests.get(url)
output = r.json()

# print(output.keys())
# print(output['main'])
# print(output['main']['temp'])


""" Exercise 5.3: Convert json output to DataFrame. """
df_output = pd.DataFrame({
    'year': [2026],
    'month': [5],
    'temp': [output['main']['temp']]
})
# print(df_output)


""" Exercise 5.4: Use datetime.now() to create a dataframe. """
now = datetime.datetime.now()

df_output2 = pd.DataFrame({
    'year': [now.year],
    'month': [now.month],
    'temp': [output['main']['temp']]
})
# print(df_output2)


""" Exercise 6: Compare the current temp and hum of Berlin to temp and hum in 1980, 1990, 2000, 2010 and 2019 """
temp_hum_may = df_merge.query('month == 5')

avg_by_year = (temp_hum_may
           .groupby('year')
           .aggregate({'temp':'mean'})
           .reset_index()
           )

df_output3 = pd.DataFrame({
    'year': [now.year],
    'temp': [output['main']['temp']]
})

df_all = pd.concat([avg_by_year, df_output3])

sns.catplot(data = df_all, x = 'year', y = 'temp', kind = 'point')
plt.show()