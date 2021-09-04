SIMG=/cbica/projects/GURLAB/projects/aslpipeline/aslprepv2.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/PNCtest
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir1

singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir}  participant  \
--skip_bids_validation --participant_label 993394555  -w ${wkdir}    --skip_bids_validation --force-bbr \
 --fs-license-file /cbica/home/adebimpa/license.txt  --output-spaces   MNI152NLin2009cAsym --nprocs 8 --basil --scorescrub 
