#!/bin/sh
# author zixie
# 文件夹合并，将不同文件夹的文件合并到同一个文件夹，相同文件直接删除，同名不同文件不覆盖，不删除，一并保存
#/bin/bash ~/zixie/github/PhotoManager/shell/rename.sh /Volumes/Document/Documents/temp/2/3/201802 /Volumes/Document/Documents/temp/2/Videos/2018/
function checkFile(){
	echo "----------- process photo start -----------"
	fileName=$1
	finalName=$2
	echo $fileName
	echo $finalName
	if [ "$finalName"x != x ]; then
		if [ -f $finalName ]; then
			echo "$finalName has exist"
			newMD5=`md5 $finalName | awk '{print $4}'`
			oldMD5=`md5 $fileName | awk '{print $4}'`
			echo $newMD5
			echo $oldMD5
			if [ "$newMD5"x != x ] && [ "$newMD5"x = "$oldMD5"x ]; then
				rm $fileName
				echo "same: $fileName to $finalName"
			else
				echo "not same: $fileName to $finalName"
				mv $fileName ${finalName}_bad
			fi
		else
			echo "rename $fineNameWithExt to $finalName"
			mv $file $finalName
		fi
	fi
	echo "----------- process photo end -----------"
}
export -f checkFile

# 文件夹合并
cd $1
pwd
echo "============ zixe check photos start ======================"
for file in ./*.MP4
do
	fineNameWithExt=${file##*/}
	checkFile ./$file $2/$fineNameWithExt
done

for file in ./*.MOV
do
	fineNameWithExt=${file##*/}
	checkFile ./$file $2/$fineNameWithExt
done

# for file in ./*.M4V
# do
# 	fineNameWithExt=${file##*/}
# 	checkFile ./$file /Volumes/Document/Documents/temp/2/2/$fineNameWithExt
# done


# cd $1
# pwd
# i=1; for x in *.JPG ; do mv $x "$2-$3-$4-00-00-00-($i).JPG"; let i=i+1; done
# i=1; for x in *.png ; do mv $x "$2-$3-$4-00-00-00-($i).PNG"; let i=i+1; done
# i=1; for x in *.jpg ; do mv $x "$2-$3-$4-00-00-00-($i).JPG"; let i=i+1; done
# i=1; for x in *.PNG ; do mv $x "$2-$3-$4-00-00-00-($i).PNG"; let i=i+1; done
# echo "Finished"
