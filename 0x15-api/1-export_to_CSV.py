#!/usr/bin/python3
"""
1-export_to_CSV.py
A Python script that extends 0-gather_data_from_an_API.py
to export data in the CSV format
"""

import csv
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
    list_to_save = []

    for todo in todos:
        task_info = []
        task_info.append(employee_id)
        task_info.append(username)
        task_info.append(str(todo["completed"]))
        task_info.append(todo["title"])
        list_to_save.append(task_info)

    csv_filename = f"{employee_id}.csv"

    with open(csv_filename, "w", newline="") as f:
        writer = csv.writer(f, quoting=csv.QUOTE_ALL)
        for item in list_to_save:
            writer.writerow([item[0], item[1], item[2], item[3]])
