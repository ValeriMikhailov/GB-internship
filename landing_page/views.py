from django.shortcuts import render

# Create your views here.

def show_landing_page(request):
    return render(request, "landing_page/landing_page.html")

def show_about_page(request):
    title = "О компании"
    return render(request, "landing_page/about.html", {"title": title})
