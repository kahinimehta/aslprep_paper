SIMG=/cbica/projects/GURLAB/projects/aslpipeline/aslprep_test.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/grmpydata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/grympytest
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir

singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir}  participant  \
--skip_bids_validation --participant_label 20940  -w ${wkdir}    --skip_bids_validation --force-bbr \
 --fs-license-file /cbica/home/adebimpa/license.txt  --output-spaces   MNI152NLin2009cAsym --nprocs 8 --basil --scorescrub 
