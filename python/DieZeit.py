#!/bin/python
"""
时代周报方面的需求，从 elasticsearch 和智慧星光快搜接口获取文章，并与时代周报的文章进行相似度匹配

@author aszswaz
@date 2022-03-23
"""

import os
import sys
import pymongo
import subprocess
from subprocess import Popen
from ansilog import AnsiLog
from pymongo.message import query

# 从 SHELL 脚本加载环境变量
CONFIG = {}
with os.popen("zsh -c 'source ~/.config/bicycle-config/zhiwedata.zsh && env'") as pipe:
    for line in pipe.readlines():
        index = line.index("=")
        key = line[0: index]
        content = line[index + 1: len(line) - 1]
        CONFIG[key] = content
    pass

# 连接 MONGODB
connect_url = f'mongodb://{CONFIG["MONGO_ACCOUNT01"]}:{CONFIG["MONGO_PASSWORD01"]}@{CONFIG["DATABASES_IPV4"]}:{CONFIG["MONGODB_PORT"]}/rss_article_similarity?authSource=admin'
MONGO_CLIENT = pymongo.MongoClient(connect_url, serverSelectionTimeoutMS=5000)
db = MONGO_CLIENT['rss_article_similarity']
# 获取数据表对象
original_article = db['original_article']

for url in sys.argv[1: len(sys.argv)]:
    query = {
        "url": url
    }
    document = original_article.find_one(query)
    if document is None:
        AnsiLog.warn("url: ", url, ": Article not found.")
        continue

    # 查询星光快搜的文章
    AnsiLog.info("============================= Quick Search ==========================================")
    sub_popen: Popen = subprocess.Popen(
        ['quik-search', document["title"]], env=os.environ
    )
    sub_popen.wait()

    # 查询 elasticsearch
    AnsiLog.info("============================== Elasticsearch ========================================")
    sub_popen: Popen = subprocess.Popen(
        ['elasticsearch', document['title']], env=os.environ
    )
    sub_popen.wait()

MONGO_CLIENT.close()
