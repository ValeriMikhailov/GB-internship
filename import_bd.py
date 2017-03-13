import requests


sites = requests.get('http://52.89.213.205:8080/rest/admin/sites')
sites = sites.json()

id_sites = []

for i in sites:
	id_sites.append(i['id'])


list_sites = []

for i in id_sites:
	general = requests.get('http://52.89.213.205:8080/rest/user/' + str(i))
	general = general.json()
	list_sites.append(general)


print(sites)