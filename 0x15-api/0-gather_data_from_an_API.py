#!/usr/bin/python3
"""
0-gather_data_from_an_API.py
A Python script that, using this REST API, for a given employee ID,
returns information about his/her TODO list progress.
"""

import requests
import sys


if __name__ == "__main__":
    employee_id = sys.argv[1]
    resp = requests.get("https://jsonplaceholder.typicode.com/users/{}/todos".
                        format(employee_id))
    todos = resp.json()

    tasks_num = len(todos)
    tasks_done = 0

    for todo in todos:
        if todo["completed"]:
            tasks_done += 1
        else:
            continue

    resp = requests.get("https://jsonplaceholder.typicode.com/users/{}".
                        format(employee_id))
    employee_info = resp.json()
    name = employee_info["name"]

    print(f"Employee {name} is done with tasks({tasks_done}/{tasks_num}):")
    for todo in todos:
        if todo["completed"]:
            print("\t {}".format(todo["title"]))
        else:
            continue
