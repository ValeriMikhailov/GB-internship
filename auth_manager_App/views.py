from django.shortcuts import render
from django.shortcuts import redirect

import import_bd
import requests
from requests.auth import HTTPBasicAuth
import datetime
from django.utils.dateparse import parse_datetime

# Create your views here.



def get_token(user, password):
    auth_request = requests.post(import_bd.basic_url + "signin",
                                 auth=HTTPBasicAuth(user, password)
                                 )
    return auth_request.text

def show_auth_page(request, redirect_to=''):
    title = 'страница Авторизация'
    print(redirect_to)
    #print(request.COOKIES['user_token'])

    if request.method == "POST":
        user = request.POST["user"]
        password = request.POST["password"]
    else:
        return render(request, 'auth_page/auth.html', {'title': title})

    token = get_token(user, password)
    d_token = datetime.datetime.now()


    if not redirect_to:
        response = redirect('/common/')
    else:
        response = redirect(redirect_to)

    response.set_cookie(key='user_token', value=token)
    response.set_cookie(key='date_token', value=d_token)

    return response




def get_user_token_cookie(request):
    if "user_token" in request.COOKIES and 'date_token' in request.COOKIES:

        stop_token_time = parse_datetime(request.COOKIES['date_token']) + datetime.timedelta(days=1)

        now_date = datetime.datetime.now()



        #print(stop_token_time >= now_date, "---")

        if now_date <= stop_token_time:
            return request.COOKIES['user_token']
        else:
            return ''


    else:
        return ''
