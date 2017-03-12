from django.shortcuts import render

# Create your views here.

def show_landing_page(request):
    return render(request, "landing_page/landing_page.html")
