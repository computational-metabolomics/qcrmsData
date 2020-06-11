\docType{data}
\name{MTBLS404_xset}
\alias{MTBLS404_xset}
\title{XCMS output object of class \code{xcmsSet}}
\format{
R object of S4 class \link[xcms]{xcmsSet}.
}
\usage{
MTBLS404_xset
}
\description{
XCMS output of 36 mzML from MTBLS404 study data files included in this package.

Output was created using Bioconductor 3.11 and xcms 3.10.1 with code
shown below.
\preformatted{
library(xcms)

mzml_files <- dir(system.file("extdata/MTBLS404/mzML", package="qcrmsData"),
    full.names=TRUE, recursive=TRUE)

xset <- xcms::xcmsSet(mzml_files, method="centWave", peakwidth=c(7, 30),
    ppm=8, mzdiff=0.013, snthresh=10, noise=5000)
MTBLS404_xset <- xcms::group(xset, method="density", bw=5, mzwid=0.01)
}
}
\keyword{datasets}
