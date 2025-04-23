######################################################

#Ensure 'Counts1.txt is in the pwd
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

#################################################################

#Creating levels for colData
sampleName <- c("Blood1", "Blood2", "Blood3", "Blood4", "Blood5", "Blood6",
                "Fat1", "Fat2", "Fat3")
fileName <- c("Blood1count.txt", "Blood2count.txt", "Blood3count.txt", "Blood4count.txt",
              "Blood5count.txt", "Blood6count.txt", "Fat1count.txt", "Fat2count.txt", 
              "Fat3count.txt")
condition <- c("Blood", "Blood", "Blood", "Blood", "Blood","Blood", "Fat", "Fat", "Fat")              

#Creating df
colData <- data.frame(row.names = sampleName, fileName = fileName, condition = condition)              
#Setting condition to factor
colData$condition <- factor(colData$condition)

#Loading in and creating counts matrix for all samples
count_matrix <- read.delim("Counts1.txt", row.names = 1, header = TRUE, sep = "\t")
count_matrix <- as.matrix(count_matrix)

#Creating dds object with sample name and count info
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = colData,
                              design = ~ condition)

#Conducting differential expression analysis
dds <- DESeq(dds)
resultsNames(dds)
res <- results(dds)

ggplot(res, aes(x=log2FoldChange, y=-log10(pvalue))) +
  geom_point(alpha=0.7, size=2) +
  xlab("Log2 Fold Change") +
  ylab("-log10 P-value") +
  ggtitle("Volcano Plot (Using Adjusted P-value)") +
  theme_minimal()

#Creating results with p <0.05
res05 <- results(dds, alpha=0.05)
summary(res05)
sum(res05$padj < 0.05, na.rm=TRUE)

#MA Plot

plotMA(res05, ylim=c(-8,8))

#Transforming the data

vsd <- vst(dds, blind=FALSE)
head(assay(vsd), 3)

#Heatmap of sample-sample distances

sampleDists <- dist(t(assay(vsd))) #creating distance values
sampleDists

sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$sampleName, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Reds")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)

#PCA Analysis
plotPCA(vsd, intgroup=("condition"))



        