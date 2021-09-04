
SIMG=/cbica/projects/GURLAB/projects/aslpipeline/scripts/aslprep.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/pncdata
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/pncdata

subjlist=$( cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/pncdata/subjlist.csv)


for i in $subjlist; do 


echo 'start=`date +%s` ' >> aslprepPN${i}.sh  

anatdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/pncdata/aslprep/sub-${i}/anat/

#echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation  --basil --scorescrub >>  aslprepPN${i}.sh 

echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation --anat-derivatives  ${anatdir}  --basil --scorescrub >> aslprepPN${i}.sh  

echo 'end=`date +%s` ' >> aslprepPN${i}.sh

echo 'echo  Execution time was `expr $end - $start` seconds.'>> aslprepPN${i}.sh
 


qsub -l  h_vmem=30.5G,s_vmem=30G  aslprepPN${i}.sh  


done




