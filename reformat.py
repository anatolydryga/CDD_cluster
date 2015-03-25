import sys

description = ""

for line in open(sys.argv[1]):
    line = line.strip()
    if line == "": 
        continue
    if  not line.startswith("pfam"):
        description = line
        continue
    # pfamid line
    assert line.startswith("pfam")
    print line + "\t" + description
