SIMG=/cbica/projects/GURLAB/projects/aslpipeline/scripts/aslprep026ge.simg*
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/grmpydata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/grympydata
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/grympydata

subjlist=$( cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/grympydata/subjlistCT.csv)


for i in $subjlist; do 


echo 'start=`date +%s` ' >> aslprepGG${i}.sh  



echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation --basil --scorescrub  >>  aslprepGG${i}.sh 

echo 'end=`date +%s` ' >> aslprepGG${i}.sh

echo 'echo  Execution time was `expr $end - $start` seconds.'>> aslprepGG${i}.sh
 


qsub -l  h_vmem=30.5G,s_vmem=30G  aslprepGG${i}.sh  


done
