# openEulerAnalysis

Exploratory analysis of openEuler Community

--------------------------------
1. Retrieve repository list under openEuler and src-openEuler organizations.

```shell
python getOrgRepos.py openeuler
python getOrgRepos.py src-openeuler
```
2. Clone all retrieved repositories to local /data/repos folder.

```
./gitClone.sh
```
3. Get commit logs and deltas

```shell
./commitLog.sh
```
4. Save commit content and file change history to MongoDB
```shell
python get_commit_history.py
```
5. Count LOC at 2010-12-31, 2019-9-30, 2019-12-31, and 2021-10-31
```shell
python retrieve_snapshot.py 2010 12 31
./cal_loc 2010 12 31
python retrieve_snapshot.py 2019 9 30
./cal_loc 2019 9 30
python retrieve_snapshot.py 2019 12 31
./cal_loc 2019 12 31
python retrieve_snapshot.py 2021 10 31
./cal_loc.sh 2021 10 31
```