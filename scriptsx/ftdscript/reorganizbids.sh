

directz=/cbica/projects/aslprep/bids_dataset/subjectsDICOM
outdir=${directz}/subbids
subjlist=/cbica/projects/aslprep/scripts/corescript/gelist.csv
 
 cat ${subjlist} | while IFS="," read -r a b c; 
 
 do
 

 mkdir -p ${outdir}/sub-${a}${b}/ses-${c}
 mkdir -p ${outdir}/sub-${a}${b}/ses-${c}/anat
 mkdir -p ${outdir}/sub-${a}${b}/ses-${c}/perf 

 imcp $(ls -f ${directz}/${a}_${b}/${c}/*Sagittal*/*nii)  ${outdir}/sub-${a}${b}/ses-${c}/anat/sub-${a}${b}_ses-${c}_T1w.nii.gz 
cp $(ls -f ${directz}/${a}_${b}/${c}/*Sagittal*/*json ) ${outdir}/sub-${a}${b}/ses-${c}/anat/sub-${a}${b}_ses-${c}_T1w.json

imcp $(ls -f ${directz}/${a}_${b}/${c}/*3D*/*reala.nii)   ${outdir}/sub-${a}${b}/ses-${c}/perf/sub-${a}${b}_ses-${c}_task-rest_asl.nii.gz 
cp $(ls -f ${directz}/${a}_${b}/${c}/*3D*/*reala.json) ${outdir}/sub-${a}${b}/ses-${c}/perf/sub-${a}${b}_ses-${c}_task-rest_asl.json


 imcp $(ls -f ${directz}/${a}_${b}/${c}/3D*/*real.nii)   ${outdir}/sub-${a}${b}/ses-${c}/perf/sub-${a}${b}_ses-${c}_task-rest_m0scan.nii.gz 
 cp $( ls -f ${directz}/${a}_${b}/${c}/3D*/*real.json) ${outdir}/sub-${a}${b}/ses-${c}/perf/sub-${a}${b}_ses-${c}_task-rest_m0scan.json

 done



 subjlist=/cbica/projects/aslprep/scripts/corescript/siemenslist.csv
 
 cat ${subjlist} | while IFS="," read -r a b c; 
 
 do
 

 mkdir -p ${outdir}/sub-${a}${b}/ses-${c}
 mkdir -p ${outdir}/sub-${a}${b}/ses-${c}/anat
 mkdir -p ${outdir}/sub-${a}${b}/ses-${c}/perf 

 imcp $( ls -f ${directz}/${a}_${b}/${c}/Sagittal*/*nii)  ${outdir}/sub-${a}${b}/ses-${c}/anat/sub-${a}${b}_ses-${c}_T1w.nii.gz 
 cp $(ls -f ${directz}/${a}_${b}/${c}/Sagittal*/*json) ${outdir}/sub-${a}${b}/ses-${c}/anat/sub-${a}${b}_ses-${c}_T1w.json

immv $(ls -f ${directz}/${a}_${b}/${c}/3D*/*.nii)   ${outdir}/sub-${a}${b}/ses-${c}/perf/sub-${a}${b}_ses-${c}_task-rest_asl.nii.gz 
cp $(ls -f ${directz}/${a}_${b}/${c}/3D*/*.json)  ${outdir}/sub-${a}${b}/ses-${c}/perf/sub-${a}${b}_ses-${c}_task-rest_asl.json

 done

