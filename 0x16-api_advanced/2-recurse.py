#!/usr/bin/python3
"""
2-recurse.py
This module contains a function `def recurse(subreddit, hot_list=[])`
which queries the Reddit API and returns a list containing the titles
of all hot articles for a given subreddit
"""

import requests


def recurse(subreddit, hot_list=[], after=""):
    """
    Queries the Reddit API and returns a list containing the titles
    of all hot articles for a given subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json?after={}".\
        format(subreddit, after)
    resp = requests.get(url, headers={'User-agent': '2-recurse.py'},
                        allow_redirects=False)

    if resp.status_code != 200:
        return None

    data = resp.json()

    if "after" not in data["data"]:
        return hot_list

    posts = data["data"]["children"]

    for post in posts:
        hot_list.append(post["data"]["title"])

    return recurse(subreddit, hot_list, data["data"]["after"])
