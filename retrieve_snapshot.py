from datetime import timezone
from pymongo import MongoClient
import sys
import datetime

project = sys.argv[1]
year = int(sys.argv[2])
month = int(sys.argv[3])
day = int(sys.argv[4])


def retrieve_latest_commits(project, year, month, day):
    client = MongoClient(host='127.0.0.1', port=27017)
    result = client['os_log']['{}_commits'.format(project)].aggregate([
        {
            '$project': {
                '_id': 0,
                'repository': 1,
                'commit': 1,
                'author_time': 1
            }
        }, {
            '$match': {
                'author_time': {
                    '$lt': datetime.datetime(year, month, day, 0, 0, 0, tzinfo=timezone.utc) + datetime.timedelta(days=1)
                }
            }
        }, {
            '$sort': {
                'repository': 1,
                'author_time': 1
            }
        }, {
            '$group': {
                '_id': '$repository',
                'commit': {
                    '$last': '$commit'
                },
                'author_time': {
                    '$last': '$author_time'
                }
            }
        }
    ], allowDiskUse=True)
    result = list(result)
    print(len(result))
    # for doc in result:
    #     print(doc['_id'], doc['commit'], str(doc['author_time']))
    with open('data/{}-{}-{}-{}.csv'.format(project, year, month, day), 'w') as outf:
        for doc in result:
            outf.write(
                ','.join([doc['_id'], doc['commit'], str(doc['author_time'])]))
            outf.write('\n')

if __name__ == '__main__':
    retrieve_latest_commits(project, year, month, day)
