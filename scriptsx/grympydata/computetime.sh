




subid=$(cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/grympydata/subjlist.csv)
dir1=/cbica/projects/GURLAB/projects/aslpipeline/scripts/grympydata/
rm -rf computingtimecpac.csv
for i in $subid	
do


#a=$(echo $(tail -n 1 $(ls -f  ${dir1}/cpacxcpx_${i}.sh.o*)) | awk '{print $4}')
b=$(echo $(tail -n 1 $(ls -f  ${dir1}/aslprepGG${i}.sh.o*)) | awk '{print $4}')



echo $b >> computingtimecpac.csv





done 
