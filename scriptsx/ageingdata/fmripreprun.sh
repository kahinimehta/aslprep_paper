



subids=$( cat  /cbica/projects/GURLAB/projects/cpactesting/cpacdata/HBN_DM/hbnlist.csv )
mkdir -p /cbica/projects/GURLAB/projects/cpactesting/cpacdata/fmriprepHBN 

SIMG=/cbica/projects/GURLAB/projects/cpactesting/fmriprep.simg
bidsdir=/cbica/projects/GURLAB/projects/cpactesting/cpacdata/HBN_DM

for i in $subids
do 

echo 'start=`date +%s` ' >>  fmriprep_runHBN${i}.sh  

echo singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  /cbica/projects/GURLAB/projects/cpactesting/cpacdata/fmriprepHBN   participant --skip_bids_validation --participant_label $i  -w /cbica/projects/GURLAB/projects/cpactesting/cpacdata/fmriprepHBN_wkdir    --skip_bids_validation --force-bbr --fs-license-file /cbica/home/adebimpa/license.txt  --output-spaces   MNI152NLin2009cAsym --nprocs 8 --omp-nthreads 1  --fs-no-reconall  >> fmriprep_runHBN${i}.s


echo 'end=`date +%s` ' >> fmriprep_runHBN${i}.sh 

echo 'echo  Execution time was `expr $end - $start` seconds.'>> fmriprep_runHBN${i}.sh 
 


qsub -l h_vmem=60.5G,s_vmem=60G fmriprep_runHBN${i}.sh 

done

