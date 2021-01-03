SIMG=/cbica/projects/GURLAB/projects/aslpipeline/scripts/aslprep026.simg
bidsdir=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata
outdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/pncdata
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/pncdata




singularity run -e  -B /cbica:/cbica/home/adebimpa/cbica ${SIMG} ${bidsdir}  ${outdir} participant --participant_label sub-139181 --nprocs 8  -w ${wkdir} --fs-license-file /cbica/software/external/freesurfer/centos7/6.0.0/license.txt --skip_bids_validation  --basil --scorescrub 

