# Annotation of Viral and Phage CDD hits

At present pfam IDs are annoatated with function information, e.g. Phage Regulation, Phage Capsid.
See file `pfam_function.tsv` for complet list.

# Usage

For a file with list of contigs and pfam hits add annotation information from `pfam_function.tsv`
and calculate counts of functional groups.

# Development

Read data:

* `read_contig_cdd`
* `read_cdd_annotation`

Process data:
* `add_annotataion_to_cdd`
* `cdd_annotation_counts`

# How to add human-readable title to CDD accession

Create the csv file where  1st column is cdd acession(e.g. pfam1234)
and run the script:

```bash
cdd_description_addition.py file_with_no_description.csv file_with_description.csv
```
that would create a file with last column as title.
