#!/bin/bash
wd=`pwd`

proj=$1
folder=/data/repos/$proj/
year=$2
month=$3
day=$4
echo $proj $year $month $day

if [ -f $wd/data/$proj-$year-$month-$day.loc ]; then rm $wd/data/$proj-$year-$month-$day.loc; fi
cut -d\, -f1,2 --output-delimiter=" " $wd/data/$proj-$year-$month-$day.csv | while read repo commit; do
    echo $repo $commit
    if [ "$proj" != linux ]; then cd $folder$repo; else cd $folder; fi
    git checkout --quiet -
    git checkout --quiet $commit
    loc=`cloc --quiet . | grep '^SUM:' | tr -s ' ' | cut -d ' ' -f5`
    git checkout --quiet -
    echo $repo,$commit,$loc
    echo $repo,$commit,$loc>>$wd/data/$proj-$year-$month-$day.loc
done
paste -d , $wd/data/$proj-$year-$month-$day.csv <(cut -d\, -f3 $wd/data/$proj-$year-$month-$day.loc) > $wd/data/$proj-$year-$month-$day
cut -d\, -f4 $wd/data/$proj-$year-$month-$day | awk '{a += $1} END {print a}'
