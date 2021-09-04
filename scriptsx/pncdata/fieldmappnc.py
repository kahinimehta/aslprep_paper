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
    dirz=bidsdir +'/'+subid+ '/ses-PNC1/'
    perfdir= dirz + '/perf/'
    fmapdir= dirz + '/fmap/'
    fmapjson=glob(fmapdir+'/*json')
 
    # get nifti list 
    seseq=glob(perfdir + '/*acq-se_asl.nii.gz')
    geseq=glob(perfdir + '/*acq-gre_asl.nii.gz')
    print(seseq)

    for i in  fmapjson:
        dataj=readjson(i)
        if seseq and geseq:
            dataj.update({"IntendedFor":["ses-PNC1/perf/"+subid+"_ses-PNC1_task-rest_acq-se_asl.nii.gz",
            "ses-PNC1/perf/"+subid+"_ses-PNC1_task-rest_acq-gre_asl.nii.gz"]})
            writejson(dataj,i)
        elif seseq and not geseq:
            dataj.update({"IntendedFor":"ses-PNC1/perf/"+subid+"_ses-PNC1_task-rest_acq-se_asl.nii.gz"})
            writejson(dataj,i)
        elif geseq and not seseq:
            dataj.update({"IntendedFor":"ses-PNC1/perf/"+subid+"_ses-PNC1_task-rest_acq-gre_asl.nii.gz"})
            writejson(dataj,i)

subjl=pd.read_csv('/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata/subjlist.csv',header=None)
subjlist=subjl[0].to_list()
for kk in subjlist:
    editfiledir(bidsdir='/cbica/projects/GURLAB/projects/aslpipeline/bids_data/PNCdata',subid=str(kk))
    print(kk)

