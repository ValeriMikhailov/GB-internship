# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from __future__ import unicode_literals

from django.db import models


class Keywords(models.Model):
    name = models.CharField(unique=True, max_length=255)
    personid = models.ForeignKey('Persons', models.DO_NOTHING, db_column='personId')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'keywords'


class Pages(models.Model):
    url = models.CharField(unique=True, max_length=255)
    founddatetime = models.DateTimeField(db_column='foundDateTime', blank=True, null=True)  # Field name made lowercase.
    lastscandate = models.DateTimeField(db_column='lastScanDate', blank=True, null=True)  # Field name made lowercase.
    siteid = models.ForeignKey('Sites', models.DO_NOTHING, db_column='siteId')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'pages'


class PersonPageRank(models.Model):
    personid = models.ForeignKey('Persons', models.DO_NOTHING, db_column='personId', primary_key=True)  # Field name made lowercase.
    pageid = models.ForeignKey(Pages, models.DO_NOTHING, db_column='pageId', primary_key=True)  # Field name made lowercase.
    rank = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'person_page_rank'
        unique_together = (('personid', 'pageid'),)


class Persons(models.Model):
    name = models.CharField(unique=True, max_length=45)

    class Meta:
        managed = False
        db_table = 'persons'

    def __str__(self):
        return self.name


class Sites(models.Model):
    name = models.CharField(unique=True, max_length=255)

    class Meta:
        managed = False
        db_table = 'sites'

    def __str__(self):
        return self.name
