#Ensure 'Averaged1.txt is in the pwd
getwd()
setwd("C:/R/Rot2")

#Installing and loading packages
install.packages("BiocManager")
BiocManager::install("DESeq2")
install.packages("pheatmap")
library(DESeq2)
library("dplyr")
library("ggplot2")
library("pheatmap")
library("RColorBrewer")

#Creating levels for colData
sampleName <- c("Sample1", "Sample2", "Sample3", "Sample4", "Sample5", "Sample6",
                "Sample7", "Sample8", "Sample9")
fileName <- c("Sample1", "Sample2", "Sample3", "Sample4", "Sample5", "Sample6",
              "Sample7", "Sample8", "Sample9")
condition <- c("Female", "Male","Female", "Female",
               "Male", "Male", "Male", "Female","Male")


#Creating df
colData <- data.frame(row.names = sampleName, fileName = fileName, condition = condition)              
#Setting condition to factor
colData$condition <- factor(colData$condition)

#Loading in and creating counts matrix for all samples
count_matrix <- read.delim("averaged1.txt", row.names = 1, header = TRUE, sep = "\t")
count_matrix <- as.matrix(count_matrix)


#Creating dds object with sample name and count info
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = colData,
                              design = ~ condition)

#Conducting differential expression analysis
dds <- DESeq(dds)
resultsNames(dds)
res <- results(dds)

res05 <- results(dds, alpha=0.05)
res01 <- results(dds, alpha=0.01)
res001 <- results(dds, alpha = 0.001)

#Creating Volcano plot from res
ggplot(res, aes(x=log2FoldChange, y=-log10(pvalue))) +
  geom_point(alpha=0.7, size=2) +
  xlab("Log2 Fold Change") +
  ylab("-log10 P-value") +
  scale_x_continuous(limits = c(-15, 15)) +
  theme_minimal()

#MA Plot
plotMA(res05, ylim=c(-8,8))

#Ordering by P value
resOrdered <- res[order(res$padj),]

#Creating results called res_filtered with padj <0.01 & log2fc greater than 1
res_df <- as.data.frame(res)
res_filtered <- res_df %>% filter(padj < 0.05 & abs(log2FoldChange) > 1) 
res_filtered
summary(res_filtered)

#Ordering res_filtered by adjusted p value 
res_ordered <- res_filtered %>% arrange(padj)
res_ordered
#Writing gene list ordered by sig to tsv file
write.table(res_ordered, file = "res_ordered_05.tsv", sep = "\t", row.names = T, quote = FALSE)

#Creating res_filtered_down with padj < 0.05 and Log2FC < -1
res_filtered_down <- res_filtered %>% filter(log2FoldChange < -1)
res_filtered_down

#Creating res_filtered_up with padj < 0.05 and Log2FC > 1
res_filtered_up <- res_filtered %>% filter(log2FoldChange > 1)
res_filtered_up

#Arranging down reg and saving as table (can use gene name list in gorilla)
res_ordered_down <- res_filtered_down %>% arrange(padj)
res_ordered_down

#Writing down reg gene list ordered by sig to tsv file
write.table(res_ordered_down, file = "res_ordered_down05.tsv", sep = "\t", row.names = T, quote = FALSE)

#Arranging up reg
res_ordered_up <- res_filtered_up %>% arrange(padj)
res_ordered_up

#Writing gene list ordered by sig to tsv file
write.table(res_ordered_up, file = "res_ordered_up05.tsv", sep = "\t", row.names = T, quote = FALSE)

#Transforming the data (not used for this part of project)

vsd <- vst(dds, blind=FALSE)
head(assay(vsd), 3)

