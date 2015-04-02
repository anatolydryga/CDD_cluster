#' for each cdd add custom annotation and keeping all contigs.
#' @return datframe with 3 columns: cdd, contig, annotation
add_annotation_to_cdd <- function(contig_cdd, cdd_annotation) {
    contig_cdd_annotation <- merge(contig_cdd, cdd_annotation, by=c("cdd"), all.x=TRUE)
    contig_cdd_annotation
}

#' for each annotation count how many times it is found.
#' @return dataframe with 2 columns: annotation and frequency(Freq)
cdd_annotation_counts <- function(contig_cdd_annotation) {
    counts <- as.data.frame(table(contig_cdd_annotation$annotation))
    names(counts) <- c("annotation", "Freq")
    counts
}

#' find all cdd that does not have annotation.
#' @return vector of cdd ids
not_annotated_cddid <- function(contig_cdd_annotation) {
    no_annotation <- subset(contig_cdd_annotation, is.na(annotation))
    no_annotation$cdd
}
