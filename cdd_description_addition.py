import sys
import csv

def get_title(cdd_accession):
    """ for a given id(e.g. pfam) pull short description"""
    return "nobody knows"

assert len(sys.argv) == 3
pfam_no_description = open(sys.argv[1], "r")
pfam_with_description = open(sys.argv[2], "w")

pfam_no_description_reader = csv.reader(pfam_no_description, delimiter='\t') 
pfam_with_description_writer = csv.writer(pfam_with_description, delimiter='\t')

for row in pfam_no_description_reader:
    title = get_title(row[0])
    assert title != ""
    pfam_with_description_writer.writerow(row + [title])

pfam_no_description.close()
pfam_with_description.close()

