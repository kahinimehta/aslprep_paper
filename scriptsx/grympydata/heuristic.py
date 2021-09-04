import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes

# Create Keys
t1w = create_key(
   'sub-{subject}/anat/sub-{subject}_T1w')
t2w = create_key(
   'sub-{subject}/anat/sub-{subject}_T2w')

# Field maps
b0_phase = create_key(
   'sub-{subject}/fmap/sub-{subject}_phasediff')
b0_mag = create_key(
   'sub-{subject}/fmap/sub-{subject}_magnitude')


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

    info = {t1w:[], t2w:[],  b0_phase:[],
            b0_mag:[], asl:[],m0:[]}

    def get_latest_series(key, s):
    #    if len(info[key]) == 0:
        info[key].append(s.series_id)
    #    else:
    #        info[key] = [s.series_id]

    for s in seqinfo:
        protocol = s.protocol_name.lower()
        if "mprage" in protocol:
            get_latest_series(t1w,s)
        elif "t2_sag" in protocol:
            get_latest_series(t2w,s)
        elif "b0map" in protocol and "M" in s.image_type:
            info[b0_mag].append(s.series_id)
        elif "b0map" in protocol and "P" in s.image_type:
            info[b0_phase].append(s.series_id)
        elif s.series_description.endswith("_ASL")  and s.dim3 > 64:
            get_latest_series(asl, s)
        elif s.series_description.endswith("_M0"):
            get_latest_series(m0, s)
        #elif s.patient_id in s.dcm_dir_name:
            #get_latest_series(asl, s)

        else:
            print("Series not recognized!: ", s.protocol_name, s.dcm_dir_name)
    return info
