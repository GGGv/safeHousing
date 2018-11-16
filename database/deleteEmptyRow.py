import csv
import codecs

infile=codecs.open('crimelog.csv','rb','utf-8')
outfile=open('new_crimelog.csv','wb')
writer=csv.writer(outfile)
for row in csv.reader(infile):
	if(row):
		writer.writerow(row)
infile.close()
outfile.close()