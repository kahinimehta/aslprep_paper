import numpy as np
import json 
import os
import pandas as pd


def readjson(jsonfile):
    import json
    with open(jsonfile) as f:
        data = json.load(f)
    return data

def writejson(data,outfile):
    import json
    with open(outfile, 'w') as outfile:
        json.dump(data, outfile,sort_keys=True,indent=2)
    outfile.close()


import os
from glob import glob
import shutil

def editfiledir(bidsdir,newdir,subid,ses):
    # get directorory subjlist
    dirz=bidsdir + '/'+subid +'/'+ses
    subjdir=newdir + '/'+subid +'/'+ses
    os.makedirs(subjdir)
    anatdir=dirz+'/anat'
    os.makedirs(subjdir+'/anat/')
    if glob(anatdir+'/'+subid+'_'+ses+'_T1w.nii.gz'):
       shutil.copyfile(anatdir+'/'+subid+'_'+ses+'_T1w.nii.gz',subjdir+'/anat/'+subid+'_'+ses+'_T1w.nii.gz')
       shutil.copyfile(anatdir+'/'+subid+'_'+ses+'_T1w.json',subjdir+'/anat/'+subid+'_'+ses+'_T1w.json')

    perfdir= subjdir + '/perf'
    os.makedirs(perfdir)
    perfjson=glob(dirz+'/perf/*json')
    pldpcasl={"LabelingDuration": 1.450,"PostLabelingDelay": 2.025,"LabelingType": "PCASL"}
    pldasl={"LabelingDuration": 0,"PostLabelingDelay": [0.7,1.9],"LabelingType": "PASL","M0":1}

    for i in  perfjson:
        dataj=readjson(i)
        if "DERIVED" in dataj["ImageType"] and "CASL" in dataj["SeriesDescription"]:
            dataj.update(pldpcasl)
            dataj.update({"M0":ses+"/perf/"+subid+"_"+ses+"_task-rest_m0scan.nii.gz"})
            writejson(dataj,perfdir+'/'+subid+"_"+ses+"_task-rest_asl.json")
            aslnii = i.replace('json', 'nii.gz')
            shutil.copyfile(aslnii,perfdir+'/'+subid+"_"+ses+"_task-rest_asl.nii.gz")

        elif "ORIGINAL" in dataj["ImageType"] and "CASL" in dataj["SeriesDescription"]:
            dataj.update({"IntendedFor": ses+"/perf/"+subid+"_"+ses+"_task-rest_asl.nii.gz"})
            writejson(dataj,perfdir+'/'+subid+"_"+ses+"_task-rest_m0scan.json")
            aslnii = i.replace('json', 'nii.gz')
            shutil.copyfile(aslnii,perfdir+'/'+subid+"_"+ses+"_task-rest_m0scan.nii.gz")
            df=pd.DataFrame(["deltam"],columns=['volume_type'])
            df.to_csv(perfdir+'/'+subid+"_"+ses+"_task-rest_aslcontext.tsv",index=None)
        elif "MOSAIC" in dataj["ImageType"] and "ASL" in dataj["SeriesDescription"]:
            dataj.update(pldasl)
            writejson(dataj,perfdir+'/'+subid+"_"+ses+"_task-rest_asl.json")
            aslnii = i.replace('json', 'nii.gz')
            shutil.copyfile(aslnii,perfdir+'/'+subid+"_"+ses+"_task-rest_asl.nii.gz")
            df=pd.DataFrame(["label","control"],columns=['volume_type'])
            df.to_csv(perfdir+'/'+subid+"_"+ses+"_task-rest_aslcontext.tsv",index=None)



subjl=pd.read_csv('/cbica/projects/aslprep/scripts/corescript/baselist.csv',header=None)

for kk in range(0,len(subjl)):
    subid=subjl.iloc[kk][0]
    sesid=subjl.iloc[kk][1]

    editfiledir(bidsdir='/cbica/projects/aslprep/bids_dataset/subjectsDICOM/subbids/',
      newdir='/cbica/projects/aslprep/bids_dataset/subjectsDICOM/bids_data/',subid=subid,ses=sesid)
    print(kk)


