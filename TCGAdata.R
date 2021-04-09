install.packages(c("HGNChelper", "RCurl", "httr", "stringr", "digest", "bitops"), dependencies=T)
setwd("/TCGA-Assembler")
source("./Module_A.r")

#RNASeqRawData = DownloadRNASeqData(traverseResultFile = "./DirectoryTraverseResult_Jul-08-
#.rda", saveFolderName = "./QuickStartGuide_Results/RawData/", cancerType = "READ",
#                                  assayPlatform = "RNASeqV1", dataType = "gene.quantification", inputPatientIDs =patientid, outputFileName =
#                                     "tcgagenes");


#####tcgagenes from TCGA assembler
tumor_rnaseq <- tcgagenes[,2:51]
normal_rnaseq <- tcgagenes[,52:101]
#### t-test for statists and selecting differentially expressed genes

testresults=sapply(1:nrow(tcgagenes), function(i){
    t.test(as.numeric(tumor_rnaseq[i,]), as.numeric(normal_rnaseq[i,]), exact=FALSE )$p.value
}) 

##### plotting the p_values
hist(testresults,main= 'Histogram of p_values',xlab='p_val',ylab='genefrequency')



genenames = tcgagenes[,1]
results = cbind(genenames,testresults)

top200= resulst[testresults>0.05]

resultssort=resulst[order(resulst[,2],decreasing=FALSE),]

####bonferroni correction
adj=p.adjust(testresults, method = 'bonferroni', n = length(testresults))





