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
python get_commit_history.py openeuler
python get_commit_history.py linux
```
5. Count openeuler's LOC at 2010-12-31, 2019-9-30, 2019-12-31, and 2021-10-31
```shell
python retrieve_snapshot.py openeuler 2010 12 31
./cal_loc.sh openeuler 2010 12 31
python retrieve_snapshot.py openeuler 2019 9 30
./cal_loc.sh openeuler 2019 9 30
python retrieve_snapshot.py openeuler 2019 12 31
./cal_loc.sh openeuler 2019 12 31
python retrieve_snapshot.py openeuler 2021 10 31
./cal_loc.sh openeuler 2021 10 31
```
6. Count Linux's LOC at the first commit of git log, 2019-9-30, 2021-10-31
```shell
first_commit=`tail -1 linux.delta | cut -d\; -f 2`
first_at=`tail -1 linux.delta | cut -d\; -f 10`
dt=`date -d @$first_at +"%Y-%m-%d %H:%M:%S"`
echo "linux,$first_commit,$dt" > data/linux-2005-4-17.csv
./cal_loc.sh linux 2005 4 17
python retrieve_snapshot.py linux 2019 9 30
./cal_loc.sh linux 2019 9 30
python retrieve_snapshot.py linux 2021 10 31
./cal_loc.sh linux 2021 10 31
```