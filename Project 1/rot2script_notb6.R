#Ensure 'Counts2.txt is in the pwd
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
sampleName <- c("Blood1", "Blood2", "Blood3", "Blood4", "Blood5",
                "Fat1", "Fat2", "Fat3")
fileName <- c("Blood1count.txt", "Blood2count.txt", "Blood3count.txt", "Blood4count.txt",
              "Blood5count.txt", "Fat1count.txt", "Fat2count.txt", 
              "Fat3count.txt")
condition <- c("Blood", "Blood", "Blood", "Blood", "Blood", "Fat", "Fat", "Fat")              

#Creating df
colData <- data.frame(row.names = sampleName, fileName = fileName, condition = condition)              
#Setting condition to a factor
colData$condition <- factor(colData$condition)

#Loading in and creating counts matrix for all samples
count_matrix <- read.delim("Counts2.txt", row.names = 1, header = TRUE, sep = "\t")
count_matrix <- as.matrix(count_matrix)

#Creating dds object with sample name and count info
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = colData,
                              design = ~ condition)

#Conducting differential expression analysis
dds <- DESeq(dds)
resultsNames(dds)
res <- results(dds)

#Omitting NA rows
res_nona <- na.omit(res)

#Creating df for volcano plot (removing outliers)
resvp <- res_nona[res_nona$log2FoldChange >= -20, ]

#Creating volcano plot 
ggplot(resvp, aes(x=log2FoldChange, y=-log10(pvalue))) +
  geom_point(alpha=0.7, size=2) +
  xlab("Log2Fold Change") +
  ylab("-log10 P-value") +
  theme_minimal()

#Running dds results with alpha = 0.01
res01 <- results(dds, alpha=0.01)
summary(res01)

#Running dds with alpha = 0.05
res05 <- results(dds, alpha=0.05)
summary(res05)

#Creating MA Plot, points coloured by p-value set at 0.05
plotMA(res05, ylim=c(-8,8))

#Ordering by P value
resOrdered <- res[order(res$pvalue),]
resOrdered

#Filtering results with p <0.05
res_df <- as.data.frame(res)
res_filtered <- res_df %>% filter(padj < 0.05)
res_filtered

#Transforming the data
vsd <- vst(dds, blind=FALSE)
head(assay(vsd), 3)

#Heatmap of sample-sample distances

sampleDists <- dist(t(assay(vsd))) #creating distance values
sampleDists

sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$fileName, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Reds")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)

#PCA Analysis
plotPCA(vsd, intgroup=("condition"))

#Creating results called res_filtered with padj <0.05 
#and log2fc greater than 1 change
res_df <- as.data.frame(res)
res_filtered <- res_df %>% filter(padj < 0.05 & abs(log2FoldChange) > 1) 
res_filtered
summary(res_filtered)

#Ordering res_filtered by adjusted p-value 
res_ordered1 <- res_filtered %>% arrange(padj)
res_ordered1
#Creating file with all sig genes
write.table(res_ordered1, file = "ptb_res_ordered_05.tsv", sep = "\t", row.names = T, quote = FALSE)

#Creating res_filtered_down with padj < 0.05 and Log2FC < -1
res_filtered_down <- res_filtered %>% filter(log2FoldChange < -1)
res_filtered_down

#Creating res_filtered_up with padj < 0.05 and Log2FC > 1
res_filtered_up <- res_filtered %>% filter(log2FoldChange > 1)
res_filtered_up

#Arranging down reg and saving as table
res_ordered_down <- res_filtered_down %>% arrange(padj)
res_ordered_down
write.table(res_ordered_down, file = "tb_res_ordered_down05.tsv", sep = "\t", row.names = T, quote = FALSE)

#Arranging up reg and saving as table
res_ordered_up <- res_filtered_up %>% arrange(padj)
res_ordered_up
write.table(res_ordered_up, file = "tb_res_ordered_up05.tsv", sep = "\t", row.names = T, quote = FALSE)



        