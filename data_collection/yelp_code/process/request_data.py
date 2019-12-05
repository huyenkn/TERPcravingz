import json
import os
import sys
from yelp.client import Client

MY_API_KEY = '8mGvo0Su-eiW58FpAQuTEdBCRHnKSt2oa08Uy8R_7cDU8hZYZONhesEcEZ_fnzLLlxNiYgOjavrTjylwkOlRoj684ThnQSDjoh5dT19cvJurstQPhXaVuEtdi3GzXXYx'
client = Client(MY_API_KEY)

"""
locations = ["College Park", 
             "East Riverdale",
             "Hyattsville",
             "Langley Park",
             "Mount Rainier",
             "Chillum",
             "New Carrollton",
             "Greenbelt",
             "Hillandale",
             "Takoma Park",
             "Beltsville",
             "Silver Spring",
             "White Oak",
             "Glenn Dale",
             "Fairland"
             ]
"""

ROOT_DIR = sys.argv[1]

locations = ["College Park MD", 
             "East Riverdale MD",
             "Hyattsville MD",
             "Langley Park MD",
             "Mount Rainier MD",
             "Chillum MD",
             "New Carrollton MD",
             "Greenbelt MD",
             "Hillandale MD",
             "Takoma Park MD",
             "Beltsville MD",
             "Silver Spring MD",
             "White Oak MD",
             "Glenn Dale MD",
             "Fairland MD"
             ]

limit = 50
sort_by = "distance"

MAX = 1000

for loc in locations:

	dir_name = loc.lower().replace(' ', '_')
	#dir_path_copy = os.path.join('restaurant_data_copy', dir_name)
	dir_path = os.path.join(ROOT_DIR, dir_name)
	
	if not os.path.exists(dir_path):
		os.makedirs(dir_path)

	for offset in range(0, MAX, 50):
		response = client.business.search(
			location=loc, limit=limit, offset=offset, sort_by=sort_by)
		file_name = "_".join([dir_name, "offset_" + str(offset)])
		"""
		file_path_copy = os.path.join(dir_path_copy, file_name)
		with open(file_path_copy + '.json') as f:
			response = json.load(f)
		"""
		file_path = os.path.join(dir_path, file_name)
		with open(file_path + '.json', 'w') as f:
			json.dump(response, f, indent=2)
		








