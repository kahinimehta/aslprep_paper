




subid=$(cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/pncdata/subjlist.csv)
dir1=/cbica/projects/GURLAB/projects/aslpipeline/scripts/pncdata/
rm -rf computingtimecpac.csv
for i in $subid	
do


#a=$(echo $(tail -n 1 $(ls -f  ${dir1}/cpacxcpx_${i}.sh.o*)) | awk '{print $4}')
b=$(echo $(tail -n 1 $(ls -f  ${dir1}/aslprepPN${i}.sh.o*)) | awk '{print $4}')



echo ${i},$b >> computingtimecpac.csv





done 
