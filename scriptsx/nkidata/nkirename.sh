
b=$(cat /cbica/projects/GURLAB/projects/aslpipeline/scripts/nkidata/test.csv)

dirname=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/NKIdata
aslcontext=/cbica/projects/GURLAB/projects/aslpipeline/bids_data/NKIdata/context.tsv

for i in $b;
do 
F1T=$(ls -f ${dirname}/${i}/ses-FLU1/perf/${i}_ses-FLU1_task-rest_aslcontext.tsv)


F2T=$(ls -f ${dirname}/${i}/ses-FLU2/perf/${i}_ses-FLU2_task-rest_aslcontext.tsv)


B2T=$(ls -f ${dirname}/${i}/ses-BAS1/perf/${i}_ses-BAS1_task-rest_aslcontext.tsv)


T2T=$(ls -f ${dirname}/${i}/ses-TRT/perf/${i}_ses-TRT_task-rest_aslcontext.tsv)



if [[ -f ${F1T} ]]; then 
cp ${aslcontext} ${dirname}/${i}/ses-FLU1/perf/${i}_ses-FLU1_task-rest_aslcontext.tsv
fi

if [[ -f ${F2T} ]]; then 
cp ${aslcontext} ${dirname}/${i}/ses-FLU1/perf/${i}_ses-FLU2_task-rest_aslcontext.tsv
fi

if [[ -f ${B2T} ]]; then 

cp ${aslcontext} ${dirname}/${i}/ses-BAS1/perf/${i}_ses-BAS1_task-rest_aslcontext.tsv

fi


if [[ -f ${T2T} ]]; then 
cp ${aslcontext} ${dirname}/${i}/ses-TRT/perf/${i}_ses-TRT_task-rest_aslcontext.tsv
fi
done 
