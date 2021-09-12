# ASL to BIDS 

## Conversion of data to BIDS
The ASL is not in offical BIDS yet, so [heudiconv](https://heudiconv.readthedocs.io/en/latest/) wont work properly as expected. 

The first step is to convert dicom files to Nifti with [dcm2niiX](https://github.com/rordenlab/dcm2niix) that generate sidecar. This [script](reorganizbids.sh)  was used to reorganized the data in form of BIDS.


## ASL Parameters 
These data have mixture of PCASL and PASL. The  ASL types were identified by the dicom header. The deltam and MO scan of PCASL were differentiated by `ImageType`. The former is `DERIVED` and the latter is `ORIGINAL`.  

The following parameters were added to PCASL data: 

```json 
  "LabelingDuration": 1.450,
  "PostLabelingDelay": 2.025,
  "LabelingType": "PCASL"
```
Note. The scale (and number of average) are not inlcuded in the sidecar. For aslprep, this will be in the command line as [m0_scale](https://aslprep.readthedocs.io/en/latest/usage.html?highlight=m0_scale#command-line-arguments)



The following parameters were added to PASL data:

```json
"LabelingDuration": 0,
"PostLabelingDelay": [0.7,1.9],
"LabelingType": "PASL",
"M0":1
```
`M0` was set to 1 to avoid aslprep using control image for CBF computation because control image has background suppressed.

This [python script](checkthedata.py) was used to correct data name and add all the paremeters. 



subject list for:
- [GE Scans](gelist.csv): 132 
- [Siemens Scans](siemenslist.csv): 299
- BIDS [sub-{siteID}{patientID},ses-{date}](baselist.csv): 431
