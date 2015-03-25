cut -d _ -f 1 pfam_groups > pfam_groups_no_description
python reformat.py pfam_groups_no_description > pfam_function.tsv
