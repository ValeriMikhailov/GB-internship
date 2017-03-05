from django.shortcuts import render

# Create your views here.

def show_daily_page(request):
    return render(request, 'everyday.html')
