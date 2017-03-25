# -*- coding: utf-8 -*-

from django.shortcuts import render
import MySQLdb
import db_settings

# Create your views here.

def show_landing_page(request):
    return render(request, "landing_page/landing_page.html")

def show_about_page(request):
    title = "О компании"
    return render(request, "landing_page/about.html", {"title": title})

def show_contacts_page(request):
    title = "Контакты"
    message = {}
    if request.method == "POST":
        try:
            db = MySQLdb.connect(host=db_settings.host, user=db_settings.user, passwd=db_settings.password, db=db_settings.db, port=int(db_settings.port), use_unicode=True, charset="utf8")
            db.autocommit(True)
            c=db.cursor()
            c.execute(
                  """INSERT INTO messages (type, sender_name, sender_email, message)
                  VALUES ('{0}', '{1}', '{2}', '{3}')""".format("feedback", request.POST["name"], request.POST["email"], request.POST["message"]))

            c.close()
            message = {"success": "Спасибо, за обратную связь! Мы свяжемся с вами в ближайшее время!"}
        except Exception as e:
            print(e)
            message = {"error": "Что-то пошло не так, попробуйте позже"}

    return render(request, "landing_page/contacts.html", {"message": message})
