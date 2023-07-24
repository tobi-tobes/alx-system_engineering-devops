#!/usr/bin/python3
"""
2-export_to_JSON.py
A Python script that extends 0-gather_data_from_an_API.py
to export data in the JSON format
"""

import collections
import json
import requests
import sys


if __name__ == "__main__":
    employee_id = sys.argv[1]
    resp = requests.get("https://jsonplaceholder.typicode.com/users/{}/todos".
                        format(employee_id))
    todos = resp.json()

    resp = requests.get("https://jsonplaceholder.typicode.com/users/{}".
                        format(employee_id))
    employee_info = resp.json()
    username = employee_info["username"]
    dict_to_save = {}
    tasks_info = []

    for todo in todos:
        task_info = collections.OrderedDict()
        task_info["task"] = todo["title"]
        task_info["completed"] = todo["completed"]
        task_info["username"] = username
        tasks_info.append(task_info)

    dict_to_save[employee_id] = tasks_info

    json_filename = f"{employee_id}.json"

    with open(json_filename, "w", encoding="utf-8") as f:
        json_dict = json.dumps(dict_to_save)
        f.write(json_dict)
