#!/usr/bin/python3
"""
0-subs.py
This module contains a function `def number_of_subscribers(subreddit)`
which queries the Reddit API and returns the number of subscribers
(not active users, total subscribers) for a given subreddit.
"""

import requests


def number_of_subscribers(subreddit):
    """
    Queries the Reddit API and returns the number of subscribers
    (not active users, total subscribers) for a given subreddit.
    """
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    resp = requests.get(url, headers={'User-agent': '0-subs.py'},
                        allow_redirects=False)

    if resp.status_code != 200:
        return 0

    about = resp.json()
    about_data = about["data"]
    return about_data["subscribers"]
