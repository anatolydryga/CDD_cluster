#' for a given pfam family finds if there is preferential transfer
#' of contigs. 
#' @return p value for Fisher's exact test
#' cdd_contig_annotation(with is_transferred column) is from global env.
differential_transfer <- function(family) {
    cdd_contig_annotation$is_family <- cdd_contig_annotation$cdd == family
    transfer_family <- table(cdd_contig_annotation$is_transferred, cdd_contig_annotation$is_family)
    cdd_contig_annotation$is_family <- NULL
    fisher.test(transfer_family)$p.value
}

# TODO: refactor merge with differential_transfer function

#' for a given funcitional group finds if there is preferential transfer
#' of contigs. 
#' @return p value for Fisher's exact test
#' cdd_contig_annotation(with is_transferred column) is from global env.
differential_transfer_group <- function(functional_group) {
    cdd_contig_annotation$is_family <- cdd_contig_annotation$annotation == functional_group
    transfer_family <- table(cdd_contig_annotation$is_transferred, cdd_contig_annotation$is_family)
    if (nrow(transfer_family) != 2 || ncol(transfer_family) != 2) return(1.0)
    cdd_contig_annotation$is_family <- NULL
    fisher.test(transfer_family)$p.value
}

#' from cdd hits find all unique pfam families.
all_pfam_families <- function(cdd) {
    pfams <- cdd[ grepl("pfam", cdd, fixed=TRUE)]
    as.character(unique(pfams))
}

contig_cdd <- read_contig_cdd("minimo_contigs_min_len_500_cdd_accession.tsv")
cdd_annotation <- read_cdd_annotation("pfam_function.tsv")
cdd_contig_annotation <- add_annotataion_to_cdd(contig_cdd, cdd_annotation)

transferred_contigs <- scan("transfferred_contigs_from_4_donor.txt", what=character())
cdd_contig_annotation$is_transferred <- cdd_contig_annotation$contig %in% transferred_contigs

pfam_families <- all_pfam_families(cdd_contig_annotation$cdd)
differential_transferred_families <- sapply(pfam_families, differential_transfer)
families_of_interest <- differential_transferred_families[ differential_transferred_families < 0.1]

functional_groups <- as.character(unique(cdd_annotation$annotation))
differential_transferred_functional_groups <- sapply(functional_groups, differential_transfer_group)
functional_groups_of_interest <- differential_transferred_functional_groups[ 
    differential_transferred_functional_groups < 0.1]
