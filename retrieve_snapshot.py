from datetime import datetime, tzinfo, timezone
from pymongo import MongoClient

client = MongoClient(host='127.0.0.1', port=27017)
result = client['openeuler']['commits'].aggregate([
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
                '$gte': datetime(2010, 12, 31, 0, 0, 0, tzinfo=timezone.utc), 
                '$lt': datetime(2011, 1, 1, 0, 0, 0, tzinfo=timezone.utc)
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
with open('data/2011-12-31.csv', 'w') as outf:
    for doc in result:
        outf.write(','.join([doc['_id'], doc['commit'], str(doc['author_time'])]))
        outf.write('\n')

result = client['openeuler']['commits'].aggregate([
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
                '$lt': datetime(2021, 11, 1, 0, 0, 0, tzinfo=timezone.utc)
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
with open('data/2021-10-31.csv', 'w') as outf:
    for doc in result:
        outf.write(','.join([doc['_id'], doc['commit'], str(doc['author_time'])]))
        outf.write('\n')
