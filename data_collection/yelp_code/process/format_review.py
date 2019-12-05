import json
with open('review_all_data.json') as f:
	data = json.load(f)
biz_id = []
for i in data.keys():
	if data[i]['reviews'] != []:
		biz_id.append(data[i]['reviews'])
print(len(biz_id))

with open('data_rv_inside_review.json', 'w') as f:
	data = json.dump(biz_id, f, indent=2)