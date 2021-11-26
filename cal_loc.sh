#!/bin/bash
wd=`pwd`
folder='/data/repos/openeuler/'
year=$1
month=$2
day=$3
echo $year $month $day

if [ -f $wd/data/$year-$month-$day.loc ]; then rm $wd/data/$year-$month-$day.loc; fi
cut -d\, -f1,2 --output-delimiter=" " $wd/data/$year-$month-$day.csv | while read repo commit; do
    echo $repo $commit
    cd $folder$repo
    git checkout --quiet -
    git checkout --quiet $commit
    loc=`cloc --quiet . | grep '^SUM:' | tr -s ' ' | cut -d ' ' -f5 2>/dev/null`
    git checkout --quiet -
    echo $repo,$commit,$loc
    echo $repo,$commit,$loc>>$wd/data/$year-$month-$day.loc
done
paste -d , $wd/data/$year-$month-$day.csv <(cut -d\, -f3 $wd/data/$year-$month-$day.loc) > $wd/data/$year-$month-$day
cut -d\, -f4 $wd/data/$year-$month-$day | awk '{a += $1} END {print a}'
