from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.
def index(request, seed, difficulty):
    # seed and difficulty are numbers
    jsonFile = "game/level1.json"
    response = ""
    if int(seed) == 0:
        with open (jsonFile, "r") as myfile:
            response=myfile.read().replace('\n', '')
    else:
        response = "seed:" + seed + "difficulty:" + difficulty
    return HttpResponse(response)
