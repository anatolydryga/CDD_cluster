# to run type : Rscript 9_CDD_gene_types.R  
# on cmd line

# Counts but not abundance is taken into account

library(ggplot2)

source("./CDD_cluster/read_cdd.R")
source("./CDD_cluster/merge_cdd_with_cluster.R")
source("./CDD_cluster/annotation_count_sample.R")

cdd <- "minimo_contigs_min_len_500_cdd_accession.tsv"
folders <- c("4donor_assembly", "P1_t0_pre_assembly", "P2_t0_pre_assembly", "P3_t0_pre_assembly")

samples <- data.frame(
    files=sapply(folders, file.path, cdd),
    sample_name=c("4donor", "P1_t0_pre", "P2_t0_pre", "P3_t0_pre"),
    stringsAsFactors=FALSE
)
cdd_annotation <- read_cdd_annotation("CDD_cluster/pfam_function.tsv") 

sample_annotation_count <- mapply(annotation_counts_for_sample, samples$files, samples$sample_name, 
        MoreArgs=list(cdd_annotation), SIMPLIFY=FALSE)

sample_annotation_count <- do.call(rbind, sample_annotation_count)

ggplot(data = sample_annotation_count, aes(x=sample_name, y=Freq, fill=annotation)) + 
    geom_bar(stat = "identity", colour="darkgreen") + 
    theme_bw() +  scale_fill_brewer(palette="Spectral") +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Viral Gene Types Composition")
ggsave(file.path("9_CDD_Gene_Types", "Gene_types.pdf"))
