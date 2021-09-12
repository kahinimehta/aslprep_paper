mri_vol2surf --mov cbffile_mean.nii.gz --hemi lh --surf white --reg  \
$FREESURFER_HOME/average/mni152.register.dat --projfrac-avg 0 1 0.1 \
--o lh_cbf_surf.mgh  --regheader fsaverage5


mri_vol2surf --mov cbffile_mean.nii.gz --hemi rh --surf white --reg  \
$FREESURFER_HOME/average/mni152.register.dat --projfrac-avg 0 1 0.1 \
--o rh_cbf_surf.mgh  --regheader fsaverage5


mri_vol2surf --mov basilfile_mean.nii.gz --hemi lh --surf white --reg  \
$FREESURFER_HOME/average/mni152.register.dat --projfrac-avg 0 1 0.1 \
--o lh_basil_surf.mgh  --regheader fsaverage5


mri_vol2surf --mov basilfile_mean.nii.gz --hemi rh --surf white --reg  \
$FREESURFER_HOME/average/mni152.register.dat --projfrac-avg 0 1 0.1 \
--o rh_basil_surf.mgh  --regheader fsaverage5

mri_vol2surf --mov scrubfile_mean.nii.gz --hemi lh --surf white --reg  \
$FREESURFER_HOME/average/mni152.register.dat --projfrac-avg 0 1 0.1 \
--o lh_scrub_surf.mgh  --regheader fsaverage5


mri_vol2surf --mov scrubfile_mean.nii.gz --hemi rh --surf white --reg  \
$FREESURFER_HOME/average/mni152.register.dat --projfrac-avg 0 1 0.1 \
--o rh_scrub_surf.mgh  --regheader fsaverage5

