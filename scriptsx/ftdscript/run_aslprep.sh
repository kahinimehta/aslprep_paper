
SIMG=/cbica/projects/aslprep/scripts/aslprep.simg
bidsdir=/cbica/projects/aslprep/bids_dataset/subjectsDICOM/bids_data
outdir=/cbica/projects/aslprep/aslout/ftddata
wkdir=/cbica/projects/aslprep/aslout/wkdirft

subjlist=/cbica/projects/aslprep/scripts/corescript/baselist.csv



cat $subjlist   while IFS="," read -r a b; do

echo 'start=`date +%s` ' >> aslprepCDS${i}.sh  

echo singularity run -e  -B /cbica:/cbica/projects/aslprep/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label ${i} --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation  --basil --scorescrub --m0_scale 118.3542 >> aslprepCD${i}.sh

echo 'end=`date +%s` ' >> aslprepCD${i}.sh

echo 'echo  Execution time was `expr $end - $start` seconds.'>> aslprepCD${i}.sh
 
qsub -l  h_vmem=30.5G,s_vmem=30G  aslprepCD${i}.sh  


done



