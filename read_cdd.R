#' read file with 2 columns: contig name and cdd id.
#' @return dataframe with contig, cdd columns. 
read_contig_cdd <- function(filename) {
    contig_cdd <- read.delim(filename, header=FALSE)
    if(ncol(contig_cdd) != 2){
	stop("contig cdd file should have two columns, the 1st is contig_name, the second is pfam")
    }
    names(contig_cdd) <- c("contig", "cdd")
    contig_cdd
}

#' read file with 2 columns: cdd id and annotation of cdd id.
#' @return dataframe with cdd, annotation columns.
read_cdd_annotation <- function(filename) {
    cdd_annotation <- read.delim(filename, header=FALSE)
    names(cdd_annotation) <- c("cdd", "annotation")
    cdd_annotation
}
