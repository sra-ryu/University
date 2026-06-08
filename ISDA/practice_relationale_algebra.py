from reframe import Relation

country = Relation("data/country.csv")
# print(country)

""" Selektion: filtering row """
# die Länder aus Asia
result = country.query('continent=="Asia"')
# print(result)

# die Länder aus Europa
result2 = country.query('continent=="Europe"')
# print(result2)

# die Länder aus Asia oder Europa
result3 = country.query('continent=="Asia" | continent=="Europe"')
# print(result3)

""" Projektion: filtering column """
# Tabelle mit code, name, und continent
result4 = country.project(['code', 'name', 'continent'])
print(result4)

# Tabelle mit code, name, und continent - aber nur von asiatischen Ländern
result5 = country.query('continent=="Asia"').project(['code', 'name', 'continent'])
print(result5)