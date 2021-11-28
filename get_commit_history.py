import re
import sys
from tqdm import tqdm
from datetime import datetime
from pymongo import MongoClient

project = sys.argv[1]
log_path = '/data/repos/{}.log'.format(project)
log_file = open(log_path, errors='ignore')
content = log_file.read()
log_file.close()

client = MongoClient(host='127.0.0.1', port=27017)
db = client['os_log']
commits_collection = db['{}_commits'.format(project)]
commits_collection.drop()
commits_collection = db['{}_commits'.format(project)]
file_history_collection = db['{}_file_history'.format(project)]
file_history_collection.drop()
file_history_collection = db['{}_file_history'.format(project)]

records = list(content.split('STARTOFTHECOMMIT:')[1:])
docs = []
file_history = []
for record in tqdm(records):
    try:
        info, modifies = record.rsplit('NOTES\n', 1)
        repo, ctp, body = info.split('\n', 2)
        commit, tree, parent_commits, author_name, author_email, author_time, committer_name, committer_email, committer_time, title = ctp.split(';', 9)
        parent_commits = parent_commits.split(' ')
        doc = {
            "repository": repo,
            "commit": commit,
            "tree": tree,
            "parant_commits": parent_commits,
            "author_name": author_name,
            "author_email": author_email,
            "author_time": datetime.utcfromtimestamp(int(author_time)),
            "committer_name": committer_name,
            "committer_email": committer_email,
            "committer_time": datetime.utcfromtimestamp(int(committer_time)),
            "message": title + '\n' + body
        }
        modifies = modifies.split('\n')[1:-1]
        if modifies != ['']: 
            pattern = re.compile('(?P<addition>(\d+|-))\s*(?P<deletion>(\d+|-))\s*(?P<file_name>.*)')
            for item in modifies:
                tmp = pattern.search(item).groupdict()
                addtion, deletion, file_name = tmp['addition'], tmp['deletion'], tmp['file_name']
                if addtion == '-':
                    addtion = 0
                if deletion == '-':
                    deletion = 0
                file_change = {
                    "repository": repo,
                    "file_name": file_name,
                    "commit": commit,
                    "addition": int(addtion),
                    "deletion": int(deletion)
                }
                file_history.append(file_change)
    except:
        print(record)
        print(item)
        break
    docs.append(doc)
print("commits: {}, file changes: {}".format(len(docs), len(file_history)))
commits_collection.insert_many(docs)
file_history_collection.insert_many(file_history)
