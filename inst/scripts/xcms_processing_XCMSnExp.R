library(xcms)
library(openxlsx)
library(qcrmsData)

## Get the full path to the mzML files
mzml_files <- dir(system.file("extdata/MTBLS404/mzML", package="qcrmsData"),
    full.names=TRUE, recursive=TRUE)

## Create a phenodata data.frame
meta_data <- openxlsx::readWorkbook(
    system.file("extdata/MTBLS404/MTBLS404_meta_data.xlsx",
    package="qcrmsData")
)
rownames(meta_data) <- meta_data$Sample

raw_data <- readMSData(files=mzml_files,
    pdata=new("NAnnotatedDataFrame", meta_data), mode="onDisk")
cwp <- xcms::CentWaveParam(peakwidth = c(7, 30), ppm=8, mzdiff=0.013,
    snthresh=10, noise=5000)
xdata <- xcms::findChromPeaks(raw_data, param=cwp)
MTBLS404_xdata <- xcms::groupChromPeaks(xdata,
    xcms::PeakDensityParam(sampleGroups=rep("S", 36), bw=5, binSize=0.01))

usethis::use_data(MTBLS404_xdata)
