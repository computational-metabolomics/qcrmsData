\docType{data}
\name{MTBLS404}
\alias{MTBLS404}
\title{Subset of 'Sacurine' data set from MetaboLights data repository.}
\source{
https://www.ebi.ac.uk/metabolights/MTBLS404
}
\description{
The subset of MTBLS404 study Thermo Raw data was donwloaded on May 14, 2020.
RAW data files were converted into mzML file format using msconvert tool from
Proteowizard suite v3.0.20134-da94b986e. Profile mode data were centroided using
Vendor peak picking algorithn. Subset filter of the \code{msconvert} tool was
used to subset spectra in the interval of 300 to 500 seconds.
}
\examples{
mzml_files <- dir(system.file("extdata/MTBLS404/mzML", package="qcrmsData"),
    full.names=TRUE)
}
\value{
36 mzML files in \code{extdata/MTBLS404/mzML} folder of the package.
}
\references{
Roux A, Xu Y, Heilier JF, Olivier MF, Ezan E, Tabet JC, Junot C. 2012.
Annotation of the Human Adult Urinary Metabolome and Metabolite Identification
Using Ultra High Performance Liquid Chromatography Coupled to a Linear
Quadrupole Ion Trap-Orbitrap Mass Spectrometer.
Anal Chem. Aug 7;84(15):6429-37. doi: 10.1021/ac300829f.
}
\keyword{datasets}
