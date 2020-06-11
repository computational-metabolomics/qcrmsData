library(openxlsx)
library(dplyr)

mzml_files <- dir(system.file("extdata/MTBLS404/mzML", package="qcrmsData"),
    full.names=TRUE, recursive=TRUE)

mzml_filenames <- mzml_files <- dir(system.file("extdata/MTBLS404/mzML",
    package="qcrmsData"), full.names=FALSE, recursive=TRUE)

download.file(destfile = "s_sacurine.txt", mode="wb",
url = "https://www.ebi.ac.uk/metabolights/ws/studies/MTBLS404/download/
    dc11f678-8ae1-423f-a075-5403ef2638e7?file=s_sacurine.txt")

raw_sample_meta_data <- read.csv("s_sacurine.txt", sep="\t")

raw_sample_meta_data <-
raw_sample_meta_data[, c("Sample.Name", "Factor.Value.Age.",
    "Factor.Value.BMI.", "Factor.Value.Gender.", "Factor.Value.Osmolality.")]

sample_meta_data <- data.frame(File.Name=mzml_filenames)
sample_meta_data$Sample <- sub("\\.mzML", "", mzml_filenames)
sample_meta_data$Sample.Class <- "Sample"
sample_meta_data$Sample.Class[grep("Blanc", mzml_filenames)] <- "Blank"
sample_meta_data$Sample.Class[grep("QC", mzml_filenames)] <- "QC"
sample_meta_data$Batch <- 1
sample_meta_data$Batch[grep("_b2", mzml_filenames)] <- 2
sample_meta_data$Sample.Name <- sub("_neg", "", sample_meta_data$Sample)
sample_meta_data$Sample.Name <- sub("_b2", "", sample_meta_data$Sample.Name)

sample_meta_data <- dplyr::left_join(sample_meta_data, raw_sample_meta_data,
    by="Sample.Name")
sample_meta_data$Sample.Name <- NULL

wb <- openxlsx::createWorkbook()
openxlsx::addWorksheet(wb, "meta")
openxlsx::writeData(wb, "meta", sample_meta_data, rowNames=FALSE)
openxlsx::saveWorkbook(wb, "MTBLS404_meta_data.xlsx", overwrite=TRUE)

file.remove("s_sacurine.txt")
