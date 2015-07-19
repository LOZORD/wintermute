from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^(?P<seed>[0-9]+)/d/(?P<difficulty>[0-9]+)/$', views.index, name='index'),
]
