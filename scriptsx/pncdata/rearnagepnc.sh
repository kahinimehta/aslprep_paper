

b=$(cat /cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata/subjlist.csv)

dirname=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata


for i in $b;
do 
acqgreT=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_acq-gre_aslcontext.tsv)
acqgreJ=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_acq-gre_asl.json)
acqgreN=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_acq-gre_asl.nii.gz)
acqseT=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_acq-se_aslcontext.tsv)
acqseJ=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_acq-se_asl.json)
acqseN=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_acq-se_asl.nii.gz)
acqgreMJ=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_m0scan.json)
acqgreMN=$(ls -f ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_m0scan.nii.gz)

if [[ -f ${acqgreT} ]]; then 
 mv ${acqgreT} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-gre_aslcontext.tsv
fi 

if [[ -f ${acqgreJ} ]]; then 
 mv ${acqgreJ} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-gre_asl.json
fi

if [[ -f ${acqgreN} ]]; then 
 mv ${acqgreN} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-gre_asl.nii.gz
fi

if [[ -f ${acqseT} ]]; then 
 mv ${acqseT} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-se_aslcontext.tsv
fi

if [[ -f ${acqseJ} ]]; then 
 mv ${acqseJ} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-se_asl.json
fi

if [[ -f ${acqseN} ]]; then 
 mv ${acqseN} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-se_asl.nii.gz
fi

if [[ -f ${acqgreMJ} ]]; then 
 mv ${acqgreMJ} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-gre_m0scan.json
fi

if [[ -f ${acqgreMN} ]]; then 
 mv ${acqgreMN} ${dirname}/${i}/ses-PNC1/perf/${i}_ses-PNC1_task-rest_acq-gre_m0scan.nii.gz
fi

done
