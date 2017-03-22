"""mysite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin

from general_stat.views import *
from daily_stat.views import *
from landing_page.views import *

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', show_landing_page),
    url(r'^about/$', show_about_page),
    url(r'^common/$', show_general_page),
    url(r'^everyday/$', show_daily_page)
]
