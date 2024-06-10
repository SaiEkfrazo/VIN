# Generated by Django 4.2.11 on 2024-06-09 09:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0005_defectnotification'),
    ]

    operations = [
        migrations.AddField(
            model_name='defects',
            name='consecutive_count',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AddField(
            model_name='defects',
            name='last_occurrence_time',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]