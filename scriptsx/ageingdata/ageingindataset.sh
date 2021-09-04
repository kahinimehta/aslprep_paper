SIMG=/cbica/projects/GURLAB/projects/aslpipeline/aslprep.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/ageingdata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/ageiningtest 
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir

singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir}  participant  \
--skip_bids_validation --participant_label 03  -w ${wkdir}    --skip_bids_validation --force-bbr \
 --fs-license-file /cbica/home/adebimpa/license.txt  --output-spaces   MNI152NLin2009cAsym --nprocs 8 --basil --scorescrub 
