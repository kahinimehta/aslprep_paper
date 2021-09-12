directz=/cbica/projects/GURLAB/projects/aslpipeline/subjectsDICOM/
subjlist=$( cat /cbica/projects/GURLAB/projects/aslpipeline/subjectsDICOM/subjectlist.csv)
 for i in $subjlist; do 

 mkdir ${directz}/bids_data/sub-${i}
 mkdir -p ${directz}/bids_data/sub-${i}/anat
 mkdir -p ${directz}/bids_data/sub-${i}/perf 

 immv ${directz}/*${i}/*Sagittal_MP-Rage*nii  ${directz}/bids_data/sub-${i}/anat/sub-${i}_T1w.nii.gz 
 mv ${directz}/*${i}/*Sagittal_MP-Rage*json ${directz}/bids_data/sub-${i}/anat/sub-${i}_T1w.json

 immv ${directz}/*${i}/*real.nii   ${directz}/bids_data/sub-${i}/perf/sub-${i}_task-rest_m0scan.nii.gz 
 mv ${directz}/*${i}/*real.json ${directz}/bids_data/sub-${i}/perf/sub-${i}_task-rest_m0scan.json

 immv ${directz}/*${i}/*reala.nii   ${directz}/bids_data/sub-${i}/perf/sub-${i}_task-rest_asl.nii.gz 
 mv ${directz}/*${i}/*reala.json ${directz}/bids_data/sub-${i}/perf/sub-${i}_task-rest_asl.json

 done

