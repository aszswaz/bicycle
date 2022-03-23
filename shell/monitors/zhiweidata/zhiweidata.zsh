#!/bin/zsh

# zhiweidata 服务器监控脚本

source "${HOME}/.config/bicycle-config/zhiwedata.zsh"

alias mongo="mongo --quiet"
alias curl="curl --disable -s"
alias jq="jq -r"

# 文章相似度匹配
rssArticleSimilarity() {
    local mongouri="mongodb://${MONGO_ACCOUNT01}:${MONGO_PASSWORD01}@${DATABASES_IPV4}:${MONGODB_PORT}/rss_article_similarity?authSource=admin"
    # 获取相似度匹配存在问题的原文
    local doubts=$(mongo $mongouri ./rss-article-similarity.js)
    local doubtsLength=$(echo $doubts | jq 'length')

    if [[ $doubtsLength -gt 10 ]]; then
        message --mtype error --title "rss 文章相似度匹配" --content "没有相似文章的原始文章总数：${doubtsLength}，超过 10 篇文章。"
        exit 1
    fi

    for ((i = 0; i < $doubtsLength; i++)); do
        local doubt=$(echo $doubts | jq ".[${i}]")
        local title=$(echo "$doubt" | jq ".oatitle")
        # 把所有的标点都替换为空格
        export local crawlerWord=$(echo "$title" | sed "s/[[:punct:]]/ /g")
        [[ $crawlerWord == "" ]] && exit 1

        # 生成快搜接口查询条件
        export local taskName=$title
        local qsquery=$(./rss-article-similarity.py)

        # 创建数据搜索任务
        local taskInfo=$(curl "${QUICK_TASK_API}" -H "Content-Type: application/json" -d "${qsquery}")
        local taskId=$(echo $taskInfo | jq ".data.id")
        [[ $taskId == "" ]] && echo "Get task id failed." && exit 1
        sleep 60

        # 请求任务查询到的数据
        local data=$(curl "${QUICK_DATA_API}" -G --data-urlencode "appId=${QUICK_SEARCH_APPID01}" --data-urlencode "taskId=${taskId}")
        if [[ $(echo $data | jq '.data.task.crawlerFinish') != 1 ]]; then
            message --mtype error --title "rss 文章相似度匹配" --content "快搜接口查询超时"
            exit 1
        fi
        local dataLength=$(echo $data | jq ".data.data | length")
        [[ $dataLength != 0 ]] && message --mtype warn --title "rss 文章相似度匹配" --content "ID 为 $(echo $doubt | jq '.oaid') 的原始文章，相似度匹配存在。"
    done
}

rssArticleSimilarity
