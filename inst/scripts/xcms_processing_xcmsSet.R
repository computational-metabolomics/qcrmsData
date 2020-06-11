library(xcms)

## Get the full path to the mzML files
mzml_files <- dir(system.file("extdata/MTBLS404/mzML", package="qcrmsData"),
    full.names=TRUE, recursive=TRUE)

xset <- xcms::xcmsSet(mzml_files, method="centWave", peakwidth=c(7, 30),
    ppm=8, mzdiff=0.013, snthresh=10, noise=5000)
MTBLS404_xset <- xcms::group(xset, method="density", bw=5, mzwid=0.01)

usethis::use_data(MTBLS404_xset, overwrite=T)
