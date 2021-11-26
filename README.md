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
gunzip -c data/linux.log.gz | perl bin/extrgitPlog.perl | gzip > data/linux.delta.gz
```
4. Save commit content and file change history to MongoDB
```shell
python get_commit_history.py
```