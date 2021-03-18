# Data and Figures for the ASLPrep manuscript

This repository contains the code and data used for the ASL paper.

### Datasets sources

Five datasets were used for this study and all the data were in [BIDS](https://bids-specification.readthedocs.io/) format :

1. PNC dataset :  publicly available on [dbGAP](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000607.v3.p2)

2. NKI dataset : available on  the [NeuroImaging Tools and Resources Collaboratory](http://fcon_1000.projects.nitrc.org/indi/pro/nki.html)

3. IRR dataset : Irritablity data is  available on request from the [PennLinc](https://www.pennlinc.io/team)

4. FTD dataset : Frontal-Temporal Degeneration data is available on request from [Penn Frontotemporal Degeneration Center](http://ftd.med.upenn.edu)

5. AGE dataset : Ageing data is publicly available on [Open Neuro](https://openneuro.org/datasets/ds000240/versions/00002)

### Data Preprocessing
All the data were preprocessed with ASLPrep [(v0.2.6)](doi:10.5281/zenodo.4313273)singularity image on [CBICA](https://www.med.upenn.edu/cbica/cubic.html) HPC cluster.

The processing script for all the datastes is organized in this [directory](scripts).

#### PNC data processing
  1. The PNC data were copied from [RBC](https://github.com/PennLINC/RBC) data exlcuding the  bold  and diffusion data.
  The fieldmap metadata were corrected with this 
  [script](scripts/pncdata/fieldmappnc.py) and the ASL data were renamed according to ASL-BIDS specifications.
  2. All subjects were [processed by ASLPrep](scripts/pncdata/run_aslprep.sh)
  3. Computing time for both anatomical preprocessing and perfusion processing  were noted.
#### NKI data processing
  1. Similarly, the NKI data were copied from [RBC](https://github.com/PennLINC/RBC) data exluding the  bold  and diffusion data.
  2. All subjects were [processed by ASLPrep](scripts/nkidata/run_aslprep.sh)
  3. Computing time for both anatomical preprocessing and perfusion processing  were noted.
#### IRR data processing
 1. the IRR data were exported from [flywheel](https://upenn.flywheel.io/). The fieldmap metadata were corrected with this [script](/scripts/grympydata/grmpyinetendedfor.py) and the ASL data were renamed according to ASL-BIDS specifications.
  2. All subjects were [processed by ASLPrep](scripts/grympydata/run_aslprep.sh)
  3. Computing time for both anatomical preprocessing and perfusion processing were noted.
#### FTD data processing
 1. The FTD data were copy from [PMACS](https://www.med.upenn.edu/pmacs/) cluster with permission
  2. All subjects were [processed by ASLPrep](scripts/ftdata/run_aslprep.sh)
  3. Computing time for both anatomical preprocessing and perfusion processing were noted.

#### AGE data processing
 1. The AGE data were  downloaded from [Open Neuro](https://openneuro.org/datasets/ds000240/versions/00002)
  2. All subjects were [processed by ASLPrep](scripts/ageingdata/run_aslprep.sh)
  3. Computing time for both anatomical preprocessing and perfusion processing were noted.


