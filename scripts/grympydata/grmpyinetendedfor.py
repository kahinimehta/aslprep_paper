import numpy as np
import json 
import os
import pandas as pd
import nibabel as nb


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

def editfiledir(bidsdir,subid):
    # get directorory subjlist
    dirz=bidsdir + '/'+ subid +'/'
    perfdir= dirz + '/perf'
    perfjson=glob(dirz+'/perf/*asl.json')
    m0json=glob(dirz+'/perf/*m0scan.json')
    pld={"LabelingDuration": 1.8,"PostLabelingDelay": 1.8,"LabelingType": "PCASL"}
    dataj=readjson(str(perfjson[0]))
    dataj.update(pld)
    dataj.update({"M0":"perf/"+subid+"_task-rest_m0scan.nii.gz"})
    writejson(dataj,perfdir+'/'+subid+'_task-rest_asl.json')
    datak=readjson(str(m0json[0]))
    datak.update({"IntendedFor":"perf/"+subid+"_task-rest_asl.nii.gz"})
    writejson(datak,perfdir+'/'+subid+'_task-rest_m0scan.json')

    fmap=glob(dirz+'/fmap/*.json')
    for k in fmap: 
        fp=readjson(k)
        fp.update({"IntendedFor":"perf/"+subid+"_task-rest_asl.nii.gz"})
        writejson(fp,k)

subjl=pd.read_csv('/cbica/projects/GURLAB/projects/aslpipeline/bids_data/grmpydata/subjlist.csv',header=None)
subjlist=subjl[0].to_list()
for kk in subjlist:
    editfiledir(bidsdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/grmpydata',subid=str(kk))
    print(kk)

