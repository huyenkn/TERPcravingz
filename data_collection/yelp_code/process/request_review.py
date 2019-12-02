import json
import os
import sys
from yelp.client import Client
import time
from yelp.errors import YelpError


MY_API_KEY = '8mGvo0Su-eiW58FpAQuTEdBCRHnKSt2oa08Uy8R_7cDU8hZYZONhesEcEZ_fnzLLlxNiYgOjavrTjylwkOlRoj684ThnQSDjoh5dT19cvJurstQPhXaVuEtdi3GzXXYx'
client = Client(MY_API_KEY)
b_id = []
all_data = {}
with open('md_all_restaurants_data.json') as f:
	data = json.load(f)
	# response = client.business.get_review_by_id('Mni5c7Ic0yb8F8OBVjDWHA')
for i in range(len(data)):
	b_id.append(data[i]['id'])
count = 0
for i, v in enumerate(b_id):
	print('(%d, %d) requesting from %s, received %d' % (i, len(b_id), v, count))
	try:
		response = client.business.get_review_by_id(v)
		all_data[v] = {}
		all_data[v]['reviews'] = response['reviews']
		all_data[v]['total_reviews'] = response['total']
		count += 1
		time.sleep(0.05)
	except YelpError:
		all_data[v] = {}
		all_data[v]['reviews'] = []
		all_data[v]['total_reviews'] = 0
		pass
print('Number of response: %d' %count)
file_name = 'review_all_data.json'
with open(file_name, 'w') as f:
	json.dump(all_data, f, indent=2)

with open('review_all_data') as f:
	data_2 = json.load(f)
print(len(data_2))

# for i, v in enumerate(b_id):
# 	response = client.business.get_review_by_id(v)
	# print('(%d, %d) received response from %s' % (i, len(b_id), v))

		# all_data.extend(response['reviews'])
		# all_data.extend(response['total'])		


# limit = 50

# for loc in locations:

# 	dir_name = loc.lower().replace(' ', '_')
# 	#dir_path_copy = os.path.join('restaurant_data_copy', dir_name)
# 	dir_path = os.path.join('restaurant_data_1', dir_name)
	
# 	if not os.path.exists(dir_path):
# 		os.makedirs(dir_path)

# 	for offset in range(0, 1000, 50):
# 		response = client.business.search(
# 			location=loc, limit=limit, offset=offset)
# 		file_name = "_".join([dir_name, "offset_" + str(offset)])
# 		"""
# 		file_path_copy = os.path.join(dir_path_copy, file_name)
# 		with open(file_path_copy + '.json') as f:
# 			response = json.load(f)
# 		"""
# 		file_path = os.path.join(dir_path, file_name)
# 		with open(file_path + '.json', 'w') as f:
# 			json.dump(response, f, indent=2)
