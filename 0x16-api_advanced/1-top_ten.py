#!/usr/bin/python3
"""
1-top_ten.py
This module contains a function `def top_ten(subreddit)`
queries the Reddit API and prints the titles of the first
10 hot posts listed for a given subreddit.
"""

import requests


def top_ten(subreddit):
    """
    Queries the Reddit API and prints the titles of the first
    10 hot posts listed for a given subreddit.
    """
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    resp = requests.get(url, headers={'User-agent': '1-top_ten.py'},
                        allow_redirects=False)

    if resp.status_code != 200:
        print(None)
        return

    data = resp.json()
    posts = data["data"]["children"]

    for post in posts:
        print(post["data"]["title"])
