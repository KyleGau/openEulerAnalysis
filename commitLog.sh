cwd=`pwd`
for url in `cat $cwd/openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/openeuler\/\(.*\).git/\1/"`
    if [ ! -f /data/gitee_repos/openeuler_log/$repo.log.gz ]; then
        cd /data/gitee_repos/openeuler/$repo
        git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:$repo%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" | gzip > /data/gitee_repos/openeuler_log/$repo.log.gz
        zcat /data/gitee_repos/openeuler_log/$repo.log.gz | perl $cwd/extrgitPLog.pl > /data/gitee_repos/openeuler_delta/$repo.delta
        echo $repo done >> $cwd/delta.log
    fi
done
echo openeuler Finished!
for url in `cat $cwd/src-openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/src-openeuler\/\(.*\).git/\1/"`
    if [ ! -f /data/gitee_repos/src-openeuler_log/$repo.log.gz ]; then
        cd /data/gitee_repos/src-openeuler/$repo
        git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:$repo%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" | gzip > /data/gitee_repos/src-openeuler_log/$repo.log.gz
        zcat /data/gitee_repos/src-openeuler_log/$repo.log.gz | perl $cwd/extrgitPLog.pl > /data/gitee_repos/src-openeuler_delta/$repo.delta
        echo $repo done >> $cwd/delta.log
    fi
done
echo openeuler Finished!
