\docType{data}
\name{MTBLS404_xdata}
\alias{MTBLS404_xdata}
\title{XCMS output object of class \code{XCMSnExp}}
\format{
R object of S4 class \link[xcms]{XCMSnExp-class}.
}
\usage{
MTBLS404_xdata
}
\description{
XCMS output of 36 mzML from MTBLS404 study data files included in this package.
Output was created using Bioconductor 3.11 and xcms 3.10.1 with code
shown below.
\preformatted{
library(xcms)
library(openxlsx)
library(qcrms)

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
}
}
\keyword{datasets}
