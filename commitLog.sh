cwd=`pwd`
for url in `cat $cwd/openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/openeuler\/\(.*\).git/\1/"`
    if [ ! -f /data/repos/openeuler_log/$repo.log.gz ]; then
        cd /data/repos/openeuler/$repo
        git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:$repo%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" > /data/repos/openeuler_log/$repo.log
        cat /data/repos/openeuler_log/$repo.log | perl $cwd/extrgitPLog.pl > /data/repos/openeuler_delta/$repo.delta
        echo $repo done >> $cwd/delta.log
    fi
done
cat /data/repos/openeuler_log/* > /data/repos/openeuler.log
cat /data/repos/openeuler_delta/* > /data/repos/openeuler.delta
echo openeuler Finished!
for url in `cat $cwd/src-openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/src-openeuler\/\(.*\).git/\1/"`
    if [ ! -f /data/repos/src-openeuler_log/$repo.log.gz ]; then
        cd /data/repos/src-openeuler/$repo
        git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:$repo%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" > /data/repos/src-openeuler_log/$repo.log
        cat /data/repos/src-openeuler_log/$repo.log | perl $cwd/extrgitPLog.pl > /data/repos/src-openeuler_delta/$repo.delta
        echo $repo done >> $cwd/delta.log
    fi
done
cat /data/repos/src-openeuler_log/* > /data/repos/src-openeuler.log
cat /data/repos/src-openeuler_delta/* > /data/repos/src-openeuler.delta
echo openeuler Finished!
