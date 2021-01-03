#!/bin/bash

for i in `ls -d --color=none *_2*/2*/`; do 
  m=`ls -d --color=none ${i}/*/ | grep -i asl`
  #echo $m
  sub=$(echo $i | cut -d '/' -f1)
  ses=$(echo $i | cut -d '/' -f2)
  t1=`ls -d --color=none ${i}/*/ | grep -i mp | cut -d '/' -f 4`
  if [[ -d $m ]] ; then
     n=`ls --color=none $m/ | head -n 1`
     cp ${m}/${n} tmp.dcm.gz 
     gunzip tmp.dcm.gz 
     dicom_hdr tmp.dcm >> tmpdcm.txt
     mkr=`cat tmpdcm.txt | grep Manufact | head -n1 | cut -d '/' -f5`
    echo ${sub},${ses},${mkr},${t1} >> sub_ses_seq.csv
    rm tmp.dcm tmpdcm.txt
  else 
     echo $i  >> checkdcmdir.txt
  fi 
done
