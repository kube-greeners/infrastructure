import datetime
import time

from django.shortcuts import render
from django.http import HttpRequest, HttpResponse


# Create your views here.
def spendCPU(request: HttpRequest) -> HttpResponse:
    start = datetime.datetime.now()
    for i in range(5000):
        time.sleep(0.001)
    end = datetime.datetime.now()
    diff = end - start

    return HttpResponse(bytes(f"Spent {diff}", 'utf-8'))
