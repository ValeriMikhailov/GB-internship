from django.shortcuts import render
import import_bd
import requests
from requests.auth import HTTPBasicAuth

# Create your views here.

def get_token():
    auth_request = requests.post(import_bd.basic_url + "signin",
                                 auth=HTTPBasicAuth('user', 'user'))
    return auth_request.text


def get_sites():

    #print(auth_request.text)
    request = requests.get(import_bd.sites_url,
                           headers={'Authorization': get_token()})
    sites = request.json()
    #print(sites)
    return sites

def get_general_stat(site_id):


    request = requests.get(import_bd.general_stat_url + str(site_id),
                           headers={'Authorization': get_token()})


    general_stat = [x for x in request.json() if x["siteId"] == site_id]
    return general_stat

def show_general_page(request):
    title = 'Общая статистика'
    sites = get_sites()

    if request.method == "POST":
        site_id = int(request.POST["site_id"][0])
    else:
        site_id = sites[0]["id"]

    general_stat = get_general_stat(site_id)
    chart_data = []
    for person_rank in general_stat:
        chart_data.append([person_rank["personName"], person_rank["rank"]])


    return render(request, 'general_stat/common.html',{'title': title,
                                                       'sites': sites,
                                                       'general_stat': general_stat,
                                                       'site_id': site_id,
                                                       'chart_data': chart_data
                                                       })
