from django.contrib import admin
from . import models


class PersonAdmin(admin.ModelAdmin):
    fields = ['name']


admin.site.register(models.Persons, PersonAdmin)
admin.site.register(models.Keywords)

admin.site.register(models.Sites)
admin.site.register(models.Pages)
