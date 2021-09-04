

subjlist=$( cat  /cbica/projects/GURLAB/projects/aslpipeline/scripts/ageingdata/subjlist_63.csv)

MNIref=/cbica/projects/GURLAB/projects/cpactesting/cpacdata/tpl-MNI152NLin2009cAsym_res-02_T1w.nii.gz
wkdir=/cbica/projects/GURLAB/projects/aslpipeline/aslwkdir/ageingdata/aslprep_wf
outputdir=/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/ageingdata/workdir/

for k in ${subjlist}; do 


cont=$( ls -f ${wkdir}/*${k}*/asl_preproc_task_restEyesOpen_wf/compt_cbf_wf/extractcbf/*asl_avg_control.nii.gz)
asl2t1=$(ls -f ${wkdir}/*${k}*/asl_preproc_task_restEyesOpen_wf/asl_reg_wf/fsl_bbr_wf/fsl2itk_fwd/affine.txt)
t12std=$(ls -f ${wkdir}/*${k}*/anat_preproc_wf/anat_norm_wf/_template_MNI152NLin2009cAsym/registration/ants_t1_to_mniComposite.h5)


antsApplyTransforms -d 3 -e 0 -i ${cont} -r ${MNIref} -t ${t12std} -t ${asl2t1} -o ${outputdir}/${k}_control_MNI.nii.gz  --interpolation LanczosWindowedSinc

done 

