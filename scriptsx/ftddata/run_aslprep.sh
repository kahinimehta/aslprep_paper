
SIMG=/cbica/projects/GURLAB/projects/aslpipeline/scripts/aslprep.simg*
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/coreydata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/coreydata/
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/coreydata/

subjlist=$( cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/coredata/subjectlist.csv)


for i in $subjlist; do 


echo 'start=`date +%s` ' >> aslprepCD${i}.sh  

anatdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/coreydata/aslprep/sub-${i}/anat/

#echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation  --basil --scorescrub --m0_scale 100 >>  aslprepCD${i}.sh 

echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation --anat-derivatives  ${anatdir} --basil --scorescrub --m0_scale 118.3542 >> aslprepCD${i}.sh

echo 'end=`date +%s` ' >> aslprepCD${i}.sh

echo 'echo  Execution time was `expr $end - $start` seconds.'>> aslprepCD${i}.sh
 


qsub -l  h_vmem=30.5G,s_vmem=30G  aslprepCD${i}.sh  


done




