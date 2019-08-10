#-*- coding:utf-8 -*-

import urllib.request
from urllib.parse import quote
import httplib2
import json
import requests

KEY = "" # 取得したAPI Key
ENGINE_ID = "" # 取得した検索エンジンID

keywords = ["寺", "神社"]
start_num = 0

def get_urls(keyword, number):
    urls = []
    count = 0

    while count < number:
        if number - count <= 10:
            num_param = str(number - count)
        else:
            num_param = "10"

        query = "https://www.googleapis.com/customsearch/v1?key=" + KEY + \
            "&cx=" + ENGINE_ID + \
            "&num=" + num_param + \
            "&start=" + str(count + 1) + \
            "&q=" + quote(keyword) + \
            "&searchType=image"  # &dateRestrict=y1"

        res = urllib.request.urlopen(query)
        data = json.loads(res.read().decode('utf-8'))

        for i in range(len(data["items"])):
            urls.append(data["items"][i]["link"])
        
        count += 10

    return urls

def get_images(keyword, number):
    urls = get_urls(keyword, number)

    for i in range(len(urls)):
        res = requests.get(urls[i], verify=False)
        image = res.content

        if keyword == keywords[0]:
            filename = "temple" + str(i + start_num) + ".jpg"
        else:
            filename = "shrine" + str(i + start_num) + ".jpg"

        with open(filename, 'wb') as f:
            f.write(image)

# メイン
for keyword in keywords:
    # キーワードごとに取得したい枚数を指定(今回は100)
    get_images(keyword, 100)