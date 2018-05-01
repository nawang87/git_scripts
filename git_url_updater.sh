#!/bin/bash

TMP_REPO_DIR_LIST=$(mktemp /tmp/file.XXXX)
NEW_URL="new.url.local"


#search for .git folder and list it to temp file
find / -name ".git" > $TMP_REPO_DIR_LIST

for i in `cat $TMP_REPO_DIR_LIST | sed -e 's/.git$//'`; 
	do 
		echo "Moving to Path:" $i; 

		cd $i; 

		echo "Old git URL:"
		sudo git remote -v
		OLD_URL=$(sudo git remote -v | grep fetch | awk -F "/" '{print $3}' | awk -F "@" '{print $2}' | awk -F ":" '{print $1}')

		if [ "$OLD_URL" != "old.url.local" ];then
			continue
		fi

		#origin	ssh://git@new.url.local:7999/mc/config.git (fetch)
		#fetch mc from above line
		project_tag=$(sudo git remote -v | grep fetch | awk -F "/" '{print $4}')

		#origin	ssh://git@new.url.local:7999/mc/config.git (fetch)
		#fetch config.git from above line
		rep_git_name=$(sudo git remote -v | grep fetch | awk -F "/" '{print $5}' | awk '{print $1}')

		#Setting new url
		sudo git remote set-url origin ssh://git@"$NEW_URL":7999/${project_tag}/${rep_git_name};

		echo "New git URL:"
		sudo git remote -v

done
