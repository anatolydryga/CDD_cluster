# to run type : Rscript GeneTypes.R input_file_name.tsv
# on cmd line
# Counts but not abundance is taken into account

library(ggplot2)
library(RColorBrewer)
source("read_cdd.R")
source("merge_cdd_with_cluster.R")
source("annotation_count_sample.R")

input_file <- commandArgs(trailingOnly=TRUE)[1]

samples <- read.delim(input_file, stringsAsFactors=FALSE)
cdd_annotation <- read_cdd_annotation("pfam_function.tsv") 

sample_annotation_count <- mapply(annotation_counts_for_sample, samples$files, samples$sample_name, 
        MoreArgs=list(cdd_annotation), SIMPLIFY=FALSE)
sample_annotation_count <- do.call(rbind, sample_annotation_count)

levels(sample_annotation_count$annotation) <- c(levels(sample_annotation_count$annotation), "Other")
sample_annotation_count$annotation[which(is.na(sample_annotation_count$annotation))] <- "Other"

n_annotation <- length(unique(sample_annotation_count$annotation))
colorPallete <- colorRampPalette(brewer.pal(12, "Paired"))

ggplot(data = sample_annotation_count, aes(x=sample_name, y=Freq, fill=annotation)) + 
    geom_bar(stat = "identity", colour="darkgreen") + 
    theme_bw() +  scale_fill_manual(values=colorPallete(n_annotation)) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Viral Gene Types Composition")
ggsave("Gene_types_counts.pdf", scale=1.3)

ggplot(data = sample_annotation_count, aes(x=sample_name, y=Freq, fill=annotation)) +
    geom_bar(stat = "identity", colour="darkgreen", position = "fill") +
    theme_bw() +  scale_fill_manual(values=colorPallete(n_annotation)) +
    theme(axis.text.x = element_text(angle = 90)) +
    ggtitle("Viral Gene Types Composition")
ggsave("Gene_types_proportions.pdf", scale=1.3)
