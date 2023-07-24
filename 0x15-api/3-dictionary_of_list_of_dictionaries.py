#!/usr/bin/python3
"""
3-dictionary_of_list_of_dictionaries.py
A Python script that extends 0-gather_data_from_an_API.py
to export data in the JSON format
"""

import collections
import json
import requests
import sys


if __name__ == "__main__":
    resp = requests.get("https://jsonplaceholder.typicode.com/users")
    users = resp.json()
    dict_to_save = {}

    for user in users:
        task_list = []
        resp = requests.get("https://jsonplaceholder.typicode.com/users/{}/\
todos".format(user["id"]))
        todos = resp.json()
        for todo in todos:
            task_info = collections.OrderedDict()
            task_info["username"] = user["username"]
            task_info["task"] = todo["title"]
            task_info["completed"] = todo["completed"]
            task_list.append(task_info)
        dict_to_save[user["id"]] = task_list

    json_filename = "todo_all_employees.json"

    with open(json_filename, "w", encoding="utf-8") as f:
        json_dict = json.dumps(dict_to_save)
        f.write(json_dict)
