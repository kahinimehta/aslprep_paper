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
    dirz=bidsdir + '/'+ subid +'/ses-PNC1/'
    perfdir= dirz + '/perf'
    perfjson=glob(dirz+'/perf/*m0scan.json')
    if perfjson:
        dataj=readjson(perfjson[0])
        dataj.update({"IntendedFor":"ses-PNC1/perf/"+subid+"_ses-PNC1_task-rest_acq-gre_asl.nii.gz"})
        writejson(dataj,perfdir+'/'+subid+"_ses-PNC1_task-rest_acq-gre_m0scan.json")
    aslj=glob(dirz+'/perf/*task-rest_acq-gre_asl.json')
    if aslj:
        datakk=readjson(aslj[0])
        datakk.update({"M0":"ses-PNC1/perf/"+subid+"_ses-PNC1_task-rest_acq-gre_m0scan.nii.gz"})
        writejson(datakk,perfdir+'/'+subid+"_ses-PNC1_task-rest_acq-gre_asl.json")
    aslk=glob(dirz+'/perf/*task-rest_acq-se_asl.json')
    if aslk:
        datakl=readjson(aslk[0])
        datakl.update({"M0":"False"})
        writejson(datakl,perfdir+'/'+subid+"_ses-PNC1_task-rest_acq-se_asl.json")
      

   
    

subjl=pd.read_csv('/cbica/projects/GURLAB/projects/aslpipeline/scripts/pncdata/subjlist.csv',header=None)
subjlist=subjl[0].to_list()
for kk in subjlist:
    editfiledir(bidsdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata',subid='sub-'+str(kk))
    print(kk)

