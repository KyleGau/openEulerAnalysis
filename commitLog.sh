cwd=`pwd`
for url in `cat $cwd/openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/openeuler\/\(.*\).git/\1/"`
    if [ ! -f /data/repos/openeuler_log/$repo.log.gz ]; then
        cd /data/repos/openeuler/$repo
        git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:$repo%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" | gzip > /data/repos/openeuler_log/$repo.log.gz
        zcat /data/repos/openeuler_log/$repo.log.gz | perl $cwd/extrgitPLog.pl > /data/repos/openeuler_delta/$repo.delta
        echo $repo done >> $cwd/delta.log
    fi
done
echo openeuler Finished!
for url in `cat $cwd/src-openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/src-openeuler\/\(.*\).git/\1/"`
    if [ ! -f /data/repos/src-openeuler_log/$repo.log.gz ]; then
        cd /data/repos/src-openeuler/$repo
        git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:$repo%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" | gzip > /data/repos/src-openeuler_log/$repo.log.gz
        zcat /data/repos/src-openeuler_log/$repo.log.gz | perl $cwd/extrgitPLog.pl > /data/repos/src-openeuler_delta/$repo.delta
        echo $repo done >> $cwd/delta.log
    fi
done
echo openeuler Finished!
