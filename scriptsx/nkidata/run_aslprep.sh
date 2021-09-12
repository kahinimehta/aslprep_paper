
SIMG=/cbica/projects/GURLAB/projects/aslpipeline/scripts/aslprep.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/NKIdata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/nkidata
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/nkidata

subjlist=$( cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/nkidata/test.csv)


for i in $subjlist; do 


echo 'start=`date +%s` ' >> aslprepNK${i}.sh  

anatdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/nkidata/aslprep/

#echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation --basil --scorescrub   >>  aslprepNK${i}.sh 
echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation --basil --scorescrub --anat-derivatives  ${anatdir} >> aslprepNK${i}.sh 

echo 'end=`date +%s` ' >> aslprepNK${i}.sh

echo 'echo  Execution time was `expr $end - $start` seconds.'>> aslprepNK${i}.sh
 


qsub -l  h_vmem=30.5G,s_vmem=30G  aslprepNK${i}.sh  


done




