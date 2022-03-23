/**
 * 查询知微数据的 mongo 数据库中的 rss-article-similarity 数据库，判断是否存在没有匹配到相似文章的原始文章
 *
 * @author aszswaz
 * @date 2022-03-11 09:37:43
 */

function main() {
    let table = db.application
    let cursor = table.find({})
    const applications = []
    while (cursor.hasNext()) {
        applications.push(cursor.next())
    }
    cursor.close()

    const currentTime = new Date()
    const today = `${currentTime.getFullYear()}-${currentTime.getMonth() + 1}-${currentTime.getDate()} 00:00:00`
    const endTime = new Date(today).getTime()
    const startTime = endTime - 7 * 24 * 60 * 60 * 1000
    const doubt = []

    for (let application of applications) {
        let oarticles = []
        cursor = db.original_article.find({
            appid: application._id,
            save_time: {
                "$gte": startTime,
                "$lte": endTime
            }
        })
        while (cursor.hasNext()) {
            oarticles.push(cursor.next())
            if (oarticles.length) {
                doubt.push(...checked(application, oarticles))
                oarticles = []
            }
        }
        cursor.close()

        if (oarticles.length > 0) {
            doubt.push(...checked(application, oarticles))
        }
    }

    print(JSON.stringify(doubt))
}

function checked(application, oarticles) {
    const result = []
    for (let oa of oarticles) {
        let count = db.duplicate_article.count({
            foreign_key: oa._id
        })

        if (count == 0) {
            result.push({
                appid: application._id.toString(),
                oaid: oa._id,
                scount: count,
                oastime: oa.save_time.valueOf(),
                oatitle: oa.title,
                oacontent: oa.content
            })
        }
    }
    return result
}

main()
