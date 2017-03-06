from django.shortcuts import render

# Create your views here.


def show_general_page(request):
    return render(request, 'common.html')