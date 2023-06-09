#!/bin/sh
# 根据视频信息，重命名视频文件名
#/bin/bash ~/zixie/github/PhotoManager/shell/video.sh /Volumes/Document/Documents/temp/2/3/201802
function renameVideo(){
	echo "============ zixe check video start $photsName ======================"
	photsName=$1
	echo $photsName
	# sourceTime=`~/zixie/lib/ffprobe -v quiet -show_format ./$photsName | grep creation_time`
	sourceTime=`~/zixie/lib/ffprobe -v quiet -show_format ./$photsName | grep date`
	# echo $sourceTime
	realTime=${sourceTime##*=}
	# echo $realTime
	# realTimeWithoutExt=${realTime%%.*}
	realTimeWithoutExt=${realTime%%+*}
	# echo $realTimeWithoutExt
	realTimeFormatTime=${realTimeWithoutExt//:/-} 
	finalTime=${realTimeFormatTime//T/_} 
	echo $finalTime
	finalTimeWithExt=$finalTime.${photsName##*.}
	# finalTimeWithExt=$finalTime.MOV
	if [ "$finalTime"x != x ]; then
		if [ -f $finalTimeWithExt ]; then
			echo "$finalTimeWithExt from $photsName has exist"
		else
			echo "rename $photsName  to $finalTimeWithExt"
			mv ./$photsName ./$finalTimeWithExt
		fi
	fi
	echo "============ zixe check video finished $photsName ======================"
}

cd $1
pwd
for photsName in *.MP4;
do 
	renameVideo $photsName
done
for photsName in *.MOV;
do 
	renameVideo $photsName
done
for photsName in *.M4V;
do 
	renameVideo $photsName
done
for photsName in *.MPG;
do 
	renameVideo $photsName
done
for photsName in *.AVI;
do 
	renameVideo $photsName
done
echo "----------- delete DS_Store-----------"
find $1 -name .DS_Store -delete
