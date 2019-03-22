#!/bin/bash

for file in `ls ./source/_posts`
do
    if [ -d "./source/_posts/$file" ]
    then  
        echo "【 $file 】 " 
    fi
done

echo "\n输入分类:"
read type
echo "输入页面名称:"
read pageName

hexo new $pageName

mv "source/_posts/$pageName.md" "source/_posts/$type/$pageName.md"