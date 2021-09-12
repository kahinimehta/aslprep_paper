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

def editfiledir(bidsdir,newdir,subid):
    # get directorory subjlist
    dirz=bidsdir + '/sub-'+ subid +'/'
    subjdir=newdir +'/sub-'+ subid +'/'
    #os.mkdir(subjdir)
    #anatdir=dirz+'/anat'
    #os.mkdir(subjdir+'/anat/')
    #shutil.copyfile(anatdir+'/sub-'+subid+'_T1w.nii.gz',subjdir+'/anat/sub-'+subid+'_T1w.nii.gz')
    #shutil.copyfile(anatdir+'/sub-'+subid+'_T1w.json',subjdir+'/anat/sub-'+subid+'_T1w.json')

    perfdir= subjdir + '/perf'
    #os.mkdir(perfdir)
    perfjson=glob(dirz+'/perf/*json')
    pld={"LabelingDuration": 1.450,"PostLabelingDelay": 2.025,"LabelingType": "PCASL"}

    for i in  perfjson:
        dataj=readjson(i)
        if "DERIVED" in dataj["ImageType"]:
            dataj.update(pld)
            dataj.update({"M0":"perf/sub-"+subid+"_task-rest_m0scan.nii.gz"})
            writejson(dataj,perfdir+'/sub-'+subid+'_task-rest_asl.json')
            #aslnii = i.replace('json', 'nii.gz')
            #shutil.copyfile(aslnii,perfdir+'/sub-'+subid+'_task-rest_asl.nii.gz')
        elif "ORIGINAL" in dataj["ImageType"]:
            dataj.update({"IntendedFor":"perf/sub-"+subid+"_task-rest_asl.nii.gz"})
            writejson(dataj,perfdir+'/sub-'+subid+'_task-rest_m0scan.json')
            #aslnii = i.replace('json', 'nii.gz')
            #shutil.copyfile(aslnii,perfdir+'/sub-'+subid+'_task-rest_m0scan.nii.gz')
            #df=pd.DataFrame(["deltam"],columns=['volume_type'])
            #df.to_csv(perfdir+'/sub-'+subid+'_task-rest_aslcontext.tsv',index=None)


subjl=pd.read_csv('/cbica/projects/GURLAB/projects/aslpipeline/scripts/corey_labdata/subjectlist.csv',header=None)
subjlist=subjl[0].to_list()
for kk in subjlist:
    editfiledir(bidsdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/coreydata',
      newdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/coreydata',subid='0'+ str(kk))
    print(kk)

