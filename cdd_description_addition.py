#!/usr/bin/python

# interface:
# ./cdd_description_addition.py file_in.tsv file_out_description.tsv [pfam_column]
# pfam_column = 1 by default(1-based indexing)

import sys
import tempfile
import os
import csv
import subprocess

def run_command(command, error_message):
    try:
        subprocess.check_call(command, shell=True)
    except subprocess.CalledProcessError:
        print error_message

cdd_title = {}

def get_title(cdd_accession):
    if cdd_accession in cdd_title:
        return cdd_title[cdd_accession]
    else:
        title = _get_title_from_ncbi(cdd_accession)
        cdd_title[cdd_accession] = title
    return title

def _get_title_from_ncbi(cdd_accession):
    """ for a given id(e.g. pfam) pull short description from NCBI"""
    output = tempfile.NamedTemporaryFile(delete=False)
    command = ('esearch -db cdd -query "' + cdd_accession 
        + ' [ACCN]" | efetch > ' + output.name)
    run_command(command, "cannot get title from NCBI")
    title = parse_output(output)
    os.remove(output.name)
    return title


def parse_output(output_fh):
    try:
        next(output_fh)
    except StopIteration:
        return "DESCRIPTION IS NOT AVAILABLE"
    line = next(output_fh)
    assert len(line) >= 5 # for "1. " desciption + "\n"
    line = line[3:].strip()
    return line
    

assert len(sys.argv) == 3 or len(sys.argv) == 4
pfam_no_description = open(sys.argv[1], "r")
pfam_with_description = open(sys.argv[2], "w")
if len(sys.argv) == 3:
    pfam_column = 0
if len(sys.argv) == 4:
    pfam_column = int(sys.argv[3]) - 1
assert pfam_column >= 0

pfam_no_description_reader = csv.reader(pfam_no_description, delimiter='\t') 
pfam_with_description_writer = csv.writer(
    pfam_with_description, delimiter='\t', quoting=csv.QUOTE_NONE)

for row in pfam_no_description_reader:
    title = get_title(row[pfam_column])
    print row[pfam_column],  title
    assert title != ""
    pfam_with_description_writer.writerow(row + [title])

pfam_no_description.close()
pfam_with_description.close()

