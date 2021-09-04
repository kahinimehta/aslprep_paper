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

    perfdir= subjdir + '/*/perf'
    #os.mkdir(perfdir)
    perfjson=glob(dirz+'/*/perf/*json')
    pld={"LabelingDuration": 1.517,"PostLabelingDelay": 1,"LabelingType": "PCASL"}

    for i in  perfjson:
        dataj=readjson(i)
        dataj.update(pld)
        writejson(dataj,i)


subjl=pd.read_csv('/cbica/projects/GURLAB/projects/aslpipeline/scripts/nkidata/test.csv',header=None)
subjlist=subjl[0].to_list()
for kk in subjlist:
    editfiledir(bidsdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/NKIdata',
      newdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/NKIdata',subid=str(kk))
    print(kk)

