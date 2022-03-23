#!/bin/python

# 生成快搜接口查询条件

import os
import json
import time

endTime = int(time.time() * 1000)
startTime = endTime - 7 * 24 * 60 * 60 * 1000

# 快搜接口查询条件
qsquery = {
    "taskType": "",
    "appId": os.environ["QUICK_SEARCH_APPID01"],
    "taskDescription": "文章相似度匹配服务",
    "taskName": os.environ["taskName"],
    "userName": os.environ["QUICK_ACCOUNT01"],
    "searchParams": {
        "wtype": None,
        "matchFields": None,
        "excludeDomainList": None,
        "crawlerWord": None,
        "pageSize": 100,
        "crawlerTime": None,
        "crawlerWord": os.environ["crawlerWord"],
        "sortOf": "stime+asc",
        "filterWord": None,
        "startTime": startTime,
        "endTime": endTime,
        "page": 1,
        "platforms": "新闻,论坛,博客,新浪微博,平媒,微信,视频,APP,短视频"
    }
}

print(json.dumps(qsquery, ensure_ascii=False))
