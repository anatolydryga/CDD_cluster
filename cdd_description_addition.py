#!/usr/bin/python

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

def get_title(cdd_accession):
    """ for a given id(e.g. pfam) pull short description"""
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
    

assert len(sys.argv) == 3
pfam_no_description = open(sys.argv[1], "r")
pfam_with_description = open(sys.argv[2], "w")

pfam_no_description_reader = csv.reader(pfam_no_description, delimiter='\t') 
pfam_with_description_writer = csv.writer(
    pfam_with_description, delimiter='\t', quoting=csv.QUOTE_NONE)

for row in pfam_no_description_reader:
    title = get_title(row[0])
    assert title != ""
    pfam_with_description_writer.writerow(row + [title])

pfam_no_description.close()
pfam_with_description.close()

