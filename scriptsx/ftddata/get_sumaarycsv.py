import pandas as pd
# read subjilist
subjl=pd.read_csv('/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/ageingdata//csvlist.tsv',header=None)
subjlist=subjl[0].to_list()
datax=[]
for i in subjlist:
    print(i)
    dy=pd.read_csv(i)
    datax.append(dy)

df=pd.concat(datax)   
#df1 = datax
df.to_csv('/cbica/projects/GURLAB/projects/aslpipeline/aslprepoutput/ageingdata/ageindata_summary.csv',index=None)
