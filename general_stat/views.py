from django.shortcuts import render
import import_bd
import requests

# Create your views here.

def get_sites():
    request = requests.get(import_bd.sites_url)
    sites = request.json()
    return sites

def get_general_stat(site_id):
    request = requests.get(import_bd.general_stat_url + str(site_id))
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

    return render(request, 'common.html',{'title': title,
                                          'sites': sites,
                                          'general_stat': general_stat,
                                          'site_id': site_id,
                                          })