from django.shortcuts import render
from import_bd import *

# Create your views here.


def show_general_page(request):
    title = 'Общая статистика'
    return render(request, 'common.html',{'sites': sites,
                                          'list_sites': list_sites,
                                          'title': title
                                          })