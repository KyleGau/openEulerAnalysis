import requests
import json
import sys
import os

project = sys.argv[1]

url = "https://gitee.com/api/v5/orgs/{}/repos".format(project)
playload = {
    "type": "all",
    "page": 1,
    "per_page": 100,
    "access_token": "319cf70a2aee7f8791427d0a8044890d"
}

outf = open(os.path.join('.', 'data', project), 'w')
currentPage = 1
response = requests.get(url=url, params=playload)
headers = response.headers
totalPage = int(headers['Total_page'])
totalCount = int(headers['Total_count'])
print('Total page: {}, Total count: {}'.format(totalPage, totalCount))
currentCount = 0
for repo in response.json():
    if 'html_url' in repo and repo['html_url'] != '':
        outf.write(repo['html_url'] + '\n')
        currentCount += 1
print('Current page: {}, Current count: {}'.format(currentPage, currentCount))

while (currentPage != totalPage):
    currentPage += 1
    playload["page"] = currentPage
    response = requests.get(url=url, params=playload)
    for repo in response.json():
        if 'html_url' in repo and repo['html_url'] != '':
            outf.write(repo['html_url'] + '\n')
            currentCount += 1
    print('Current page: {}, Current count: {}'.format(currentPage, currentCount))
print('Finished!')
outf.close()
