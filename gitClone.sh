#!/bin/bash
for url in `cat openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/openeuler\/\(.*\).git/\1/"`
    if [ ! -d //data/gitee_repos/openeuler/$repo ]; then
        git clone $url /data/gitee_repos/openeuler/$repo
        echo "+++++++++++++++++++++++++++++++++++++++++++"
        echo $url
    fi
    
done
echo Finished openeuler

for url in `cat src-openeuler`
do
    repo=`echo $url | sed "s/https\:\/\/gitee.com\/src-openeuler\/\(.*\).git/\1/"`
    if [ ! -d //data/gitee_repos/src-openeuler/$repo ]; then
        git clone $url /data/gitee_repos/src-openeuler/$repo
        echo "+++++++++++++++++++++++++++++++++++++++++++"
        echo $url
    fi
done
echo Finished src-openeuler