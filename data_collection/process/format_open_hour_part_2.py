import json
with open('open_hour_huyen_nguyen.json') as f:
	data = json.load(f)
# biz_id = []
# for i in data.keys():
# 	if data[i]['hours'] != []:
# 		biz_id.append(i)
# print(len(biz_id))

# with open('data_huyen.json', 'w') as f:
# 	data = json.dump(biz_id, f, indent=2)

open_hour = []
for i in data.keys():
	hours = data[i]['hours']
	open_hour.extend(hours)


with open('data_huyen_2.json', 'w') as f:
	data = json.dump(open_hour, f, indent=2)