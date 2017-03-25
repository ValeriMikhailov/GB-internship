from django.shortcuts import render
from fake_bd import *
import import_bd
import requests
import datetime
import calendar

from general_stat.views import get_token


import general_stat.views

from django.contrib import auth

# Create your views here.

def get_persons():

    request = requests.get(import_bd.persons_url,
                           headers={'Authorization': get_token()})

    persons = request.json()
    return persons


def get_daily_stat(site_id, person_id, start='2004-12-12', end='2017-03-16'):

    if site_id ==1:
        site_id += 1


    request = requests.get( import_bd.daily_stat_url + str(site_id) + '/' + str(person_id) + '/between?start=' + start + '&end=' + end,
                            headers={'Authorization': get_token()})

    daily_stat = [x for x in request.json()] # if (x["siteId"] == site_id and x["personId"] == person_id)]



    return daily_stat

def show_daily_page(request):
    title = 'Ежедневная статистика'

    sites = general_stat.views.get_sites()
    persons = get_persons()

    dn = datetime.date.today()
    dn = dn.replace(month=dn.month - 1)  # !!!! ломается если month <=1

    if request.method == "POST":
        site_id = int(request.POST["site_id"][0])
        person_id = int(request.POST["person_id"][0])

        start = datetime.date(int(request.POST["start"][0:4]),
                              int(request.POST["start"][5:7]),
                              int(request.POST["start"][8:10]))

        end = datetime.date(int(request.POST["end"][0:4]),
                            int(request.POST["end"][5:7]),
                            int(request.POST["end"][8:10]))



    else:
        site_id = sites[0]["id"]
        person_id = persons[0]["id"]

        start = dn
        end = datetime.datetime.now()


    f_start = str(start)
    f_end = str(end)

    daily_stat = get_daily_stat(site_id, person_id, f_start,f_end)

    chart_data = []
    for day_stat in daily_stat:
        date_object=[int(x) for x in day_stat["date"].split("-")]
        print(date_object)
        chart_data.append([calendar.timegm(datetime.date(date_object[0],date_object[1],date_object[2]).timetuple()) * 1000, day_stat["countNewPages"]])

    return render(request, 'daily_stat/everyday.html', {'persons': persons,
                                             'title': title,
                                             'sites': sites,
                                             'daily_stat': daily_stat,
                                             'site_id': site_id,
                                             'person_id': person_id,
                                             'start': start,
                                             'end': end,
                                             'chart_data': chart_data
                                             #'username': auth.get_user(request).is_authenticated

                                             })
