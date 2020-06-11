# qrcmsData

R package containing metabolomics data sets to demonstrate functionality of the
qcrms package.

## MTBLS404 data set
Subset of Thermo .Raw data files of [MTBLS404](https://www.ebi.ac.uk/metabolights/MTBLS404/descriptors) study from
MetaboLights data repository was downloaded on May 14, 2020.

36 data files were selected, 16 from batch 1 and 16 from batch 2. 12 QC samples
are evenly distributed across measured analytical batches and selected
biological samples.

### Data pre-processing
- RAW data files were converted into mzML file format using msconvert tool from Proteowizard suite *v3.0.20134-da94b986e*. 

- Profile mode data were centroided using `msconvert` peak picking filter and
`Vendor` algorithm option. 

- Subset filter of the `msconvert` tool was used to
subset spectra in the interval of 300 to 500 seconds.

## Installation

	install.packages("remotes")
	Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="true")
	remotes::install_github('computational-metabolomics/qcrmsData')

## Example

	library(xcms)
	library(openxlsx)
	library(qcrmsData)

	#Get the full path to the mzML files
	mzml_files <- dir(system.file("extdata/MTBLS404/mzML", package="qcrmsData"),
    full.names=TRUE, recursive=TRUE)

	#Sample meta data
	meta_data <- openxlsx::readWorkbook(
    system.file("extdata/MTBLS404/MTBLS404_meta_data.xlsx",
        package="qcrmsData"))

	raw_data <- readMSData(files=mzml_files,
        pdata=new("NAnnotatedDataFrame", meta_data), mode="onDisk")
	cwp <- xcms::CentWaveParam(peakwidth = c(7, 30), ppm=8, mzdiff=0.013,
        snthresh=10, noise=5000)
	xdata <- xcms::findChromPeaks(raw_data, param=cwp)
	xdata <- xcms::groupChromPeaks(xdata,
        xcms::PeakDensityParam(sampleGroups=rep("S", 36), bw=5, binSize=0.01))
	
	# XCMS outputs are stored as data sets in qcrmsData as well
	data(MTBLS404_xset) #S4 class xcmsSet object
	data(MTBLS404_xdata) #S4 class XCMSnExp object 
