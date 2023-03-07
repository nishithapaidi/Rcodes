# script to install R packages
# setwd("~/Desktop/Filename")



install.packages("tidyverse")
install.packages("dplyr")
source("http://www.bioconductor.org/biocLite.R")
biocLite(c("GEOquery"))

library(dplyr)
library(tidyverse)
library(GEOquery)

## read in the data
dat <- read.csv(file="GSEXXXX_fpkm.csv")
dim(dat)

# get metadata
gse <- getGEO(GEO ='GSEXXXX', GSEMatrix =TRUE)

Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 *1000)


install.packages("tidyverse")

source("http://www.bioconductor.org/biocLite.R")
biocLite(c("GEOquery"))

library(dplyr)
library(tidyverse)
library(GEOquery)

## read in the data
dat <- read.csv(file="GSE183947_fpkm.csv")
dim(dat)

# get metadata
gse <- getGEO(GEO ='GSE183947', GSEMatrix =TRUE)

Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 *1000)

gse

metadata <- pData(phenoData(gse[[1]]))
head(metadata)
##select, mutate, rename using pipe operator to do repetitive works 
metadata.modified <- metadata %>%
  select(1,10,11,21) %>%
  rename(GenomeBuild = data_processing.3) %>%
  mutate(GenomeBuild= gsub("Genome_build: Homo sapiens (GRCh37),"",GenomeBuild))

