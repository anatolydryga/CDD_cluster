#' wrapper f to construct phage annotation counts for sample
#' while keeping sample name.
#' @param contig-cdd file
#' @param name of sample 
#' @param cdd-annotation datafram
#' @return df with 3 columns: sample_name, annotation, count
annotation_counts_for_sample <- function(contig_file, sample_name, cdd_annotation) {
    contig_cdd <- read_contig_cdd(contig_file)
    contig_cdd_annotation <- add_annotation_to_cdd(contig_cdd, cdd_annotation)
    annotation_count <- cdd_annotation_counts(contig_cdd_annotation)
    annotation_count$sample_name <- sample_name
    annotation_count
}
