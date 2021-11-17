#!/bin/bash
wd=`pwd`
folder='/data/gitee_repos/openeuler/'

cut -d\, -f1,2 --output-delimiter=" " $wd/data/2011-12-31.csv | while read repo commit; do
    echo $repo $commit
    cd $folder$repo
    git checkout --quiet -
    git checkout --quiet $commit
    loc=`cloc --quiet . | grep '^SUM:' | tr -s ' ' | cut -d ' ' -f5`
    git checkout --quiet -
    echo $repo,$commit,$loc
    echo $repo,$commit,$loc>>$wd/data/2011-12-31.loc
done
paste -d , $wd/data/2011-12-31.csv <(cut -d\, -f3 $wd/data/2011-12-31.loc) > $wd/data/2011-12-31

cut -d\, -f1,2 --output-delimiter=" " $wd/data/2021-10-31.csv | while read repo commit; do
    echo $repo $commit
    cd $folder$repo
    git checkout --quiet -
    git checkout --quiet $commit
    loc=`cloc --quiet . | grep '^SUM:' | tr -s ' ' | cut -d ' ' -f5`
    git checkout --quiet -
    echo $repo,$commit,$loc
    echo $repo,$commit,$loc>>$wd/data/2021-10-31.loc
done
paste -d , $wd/data/2021-10-31.csv <(cut -d\, -f3 $wd/data/2021-10-31.loc) > $wd/data/2021-10-31
