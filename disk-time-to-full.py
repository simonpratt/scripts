#!/usr/bin/env python3

import time
import os
import statistics as stats
import datetime


#statvfs.f_frsize * statvfs.f_blocks     # Size of filesystem in bytes
#statvfs.f_frsize * statvfs.f_bfree      # Actual number of free bytes
#statvfs.f_frsize * statvfs.f_bavail     # Number of free bytes that ordinary users
                                      # are allowed to use (excl. reserved space)
s = os.statvfs('/')
start_free = s.f_bavail * s.f_frsize
print("start size => ", s.f_bavail * s.f_frsize)

result_list = []


i = 0
while True:
    i += 1
    time.sleep(5)
    s = os.statvfs('/')
    current_free = (s.f_bavail * s.f_frsize)
    print(start_free, current_free, i, (start_free - current_free))
    if (start_free - current_free) <= 0:
        continue

    difference = start_free - current_free
    value = start_free

    if difference != 0:
      value = start_free / (start_free - current_free)

    value = value * (5*i)

    if value != 0:
      result_list.append(value)
      value = stats.mean(result_list)
      time_left = str(datetime.timedelta(seconds=value))
      print(time_left, "seconds until full")
    else:
      print("shrinking")