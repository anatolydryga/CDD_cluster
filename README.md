[![Build Status](https://travis-ci.org/anatolydryga/CDD_cluster.png)](https://travis-ci.org/anatolydryga/CDD_cluster)

# Annotation of Viral and Phage CDD hits with Gene Types

At present PFAM IDs are annoatated with phage function(gene type) information, e.g. Phage Regulation, Phage Capsid.
See file `pfam_function.tsv` for complete list of annotated families.

# Usage

To create Figure with gene type annotation for CDD hits for several samples:
```{bash}
Rscript GeneTypes.R input_file.tsv
```
that script creates `Gene_types.pdf` Figure.

Input file(`input_file.tsv`) format has header and data:
```
files   sample_names
file_name1  label1
file_name2  label2
file_name3  label3
```
where each `file_name*` is tab-separated file with 2 columns: contig name and
cdd accession hit(see file `DNAmod_sample_cdd.tsv` as an example), label is
used on Figure for that file. The `file_name*` can be produced by
ContigAnnotation script.

# How to Add Human-Readable Title to CDD Accession

Create the csv file where  1st column is cdd acession(e.g. pfam1234)
and run the script:

```bash
cdd_description_addition.py file_with_no_description.csv file_with_description.csv
```
that would create a file with last column as title.

If cdd accesion is not in the 1st column the last argument specify index of the 
cdd column(1-based indexing):
```bash
cdd_description_addition.py file_with_no_description.csv file_with_description.csv 2
```
means that in file `file_with_no_description.csv` column with cdd accesion number is column
number 2.

# Development

Read data:

* `read_contig_cdd`
* `read_cdd_annotation`

Process data:
* `add_annotataion_to_cdd`
* `cdd_annotation_counts`


