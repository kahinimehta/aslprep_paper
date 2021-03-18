import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes

# Create Keys
t1w = create_key(
   'sub-{subject}/anat/sub-{subject}_T1w')


# ASL scans
asl = create_key(
   'sub-{subject}/perf/sub-{subject}_task-rest_asl')
m0 = create_key(
   'sub-{subject}/perf/sub-{subject}_task-rest_m0scan')

def infotodict(seqinfo):
    """Heuristic evaluator for determining which runs belong where
    allowed template fields - follow python string module:
    item: index within category
    subject: participant id
    seqitem: run number during scanning
    subindex: sub index within group
    """

    last_run = len(seqinfo)

    info = {t1w:[],asl:[],
            m0:[]}

    def get_latest_series(key, s):
        info[key].append(s.series_id)


    for s in seqinfo:
        protocol = s.series_description
        if "Sag" in protocol:
            get_latest_series(t1w,s)
        elif "pCASL" in protocol and len(s.image_type) == 6:
            info[asl].append([s.series_id])
        elif "pCASL" in protocol and len(s.image_type) == 4:
            info[m0].append([s.series_id])
        else:
            print("Series not recognized!: ", s.protocol_name, s.dcm_dir_name)
    return info
