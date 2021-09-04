
SIMG=/cbica/projects/GURLAB/projects/aslpipeline/scripts/aslprep.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/ageingdata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/ageingdata
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/ageingdata

subjlist=$( cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/ageingdata/subjlist_63.csv)


for i in $subjlist; do 


echo 'start=`date +%s` ' >> aslprepAG${i}.sh  

anatdir=${outdir}/aslprep/sub-${i}/anat/

#echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation  --basil --scorescrub  >>  aslprepAG${i}.sh 


echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation  --anat-derivatives  ${anatdir}  --basil --scorescrub >>  aslprepAG${i}.sh

echo 'end=`date +%s` ' >> aslprepAG${i}.sh

echo 'echo  Execution time was `expr $end - $start` seconds.'>> aslprepAG${i}.sh
 


qsub -l  h_vmem=30.5G,s_vmem=30G  aslprepAG${i}.sh  


done




