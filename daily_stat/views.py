from django.shortcuts import render
from fake_bd import *

# Create your views here.

def show_daily_page(request):
    title = 'Ежедневная статистика'
    return render(request, 'everyday.html',{'persons': persons,
                                            'title': title
                                            })
