from django.shortcuts import render
from fake_bd import *
import import_bd
import requests
import general_stat.views

# Create your views here.

def get_persons():
    request = requests.get(import_bd.persons_url)
    persons = request.json()
    return persons


def get_daily_stat(site_id, person_id, start='2004-12-12', end='2017-03-16'):

    request = requests.get( import_bd.daily_stat_url + str(site_id) + '/' + str(person_id) + '/between?start=' + start + '&end=' + end)

    daily_stat = [x for x in request.json()] # if (x["siteId"] == site_id and x["personId"] == person_id)]



    return daily_stat

def show_daily_page(request):
    title = 'Ежедневная статистика'

    sites = general_stat.views.get_sites()
    persons = get_persons()

    if request.method == "POST":
        site_id = int(request.POST["site_id"][0])
        person_id = int(request.POST["person_id"][0])

    else:
        site_id = sites[0]["id"]
        person_id = persons[0]["id"]

    daily_stat = get_daily_stat(site_id, person_id, '2004-12-12', '2017-03-16')


    return render(request, 'everyday.html', {'persons': persons,
                                             'title': title,
                                             'sites': sites,
                                             'daily_stat': daily_stat,
                                             'site_id': site_id,
                                             'person_id': person_id
                                             })