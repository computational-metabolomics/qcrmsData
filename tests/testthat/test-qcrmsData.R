context("Test qcrmsData consistency")

library(openxlsx)

testthat::test_that("MTBLS404 meta data", {
    meta_data <- openxlsx::readWorkbook(
        system.file("extdata/MTBLS404/MTBLS404_meta_data.xlsx",
        package="qcrmsData"))
    expect_equal(head(meta_data),
        structure(list(
            File.Name = c("Blanc04.mzML", "Blanc04_b2.mzML", "Blanc08.mzML",
                "Blanc08_b2.mzML", "HU_neg_011_b2.mzML", "HU_neg_017.mzML"),
            Sample = c("Blanc04", "Blanc04_b2", "Blanc08", "Blanc08_b2",
                "HU_neg_011_b2", "HU_neg_017"),
            Sample.Class = c("Blank", "Blank", "Blank", "Blank", "Sample",
                "Sample"),
            Batch = c(1, 2, 1, 2, 2, 1),
            Factor.Value.Age. = c(NA, NA, NA, NA, 29, 41),
            Factor.Value.BMI. = c(NA, NA, NA, NA, 19.75, 23.03),
            Factor.Value.Gender. = c(NA, NA, NA, NA, "Male", "Male"),
            Factor.Value.Osmolality. = c(NA, NA, NA, NA, 854, 311)),
            row.names = c(NA, 6L), class = "data.frame"))
    }
)

testthat::test_that("MTBLS4040 xcms outputs", {
    data(MTBLS404_xdata)
    data(MTBLS404_xset)
    expect_true(is(MTBLS404_xset, "xcmsSet"))
    expect_true(is(MTBLS404_xdata, "XCMSnExp"))
    expect_equal(nrow(MTBLS404_xset@peaks), 39608)
    expect_equal(nrow(xcms::chromPeakData(MTBLS404_xdata)), 39608)
})

testthat::test_that("MTBLS404 mzML files", {
    mzml_files <- dir(system.file("extdata/MTBLS404/mzML",
        package="qcrmsData"))
    expect_equal(length(mzml_files), 36)
    expect_true(all(mzml_files %in% c("Blanc04.mzML", "Blanc04_b2.mzML",
        "Blanc08.mzML", "Blanc08_b2.mzML", "HU_neg_011_b2.mzML",
        "HU_neg_017.mzML", "HU_neg_028.mzML", "HU_neg_037.mzML",
        "HU_neg_039_b2.mzML", "HU_neg_044.mzML", "HU_neg_049.mzML",
        "HU_neg_052.mzML", "HU_neg_056_b2.mzML", "HU_neg_063_b2.mzML",
        "HU_neg_065.mzML", "HU_neg_066.mzML", "HU_neg_076_b2.mzML",
        "HU_neg_081_b2.mzML", "HU_neg_086.mzML", "HU_neg_087_b2.mzML",
        "HU_neg_088.mzML", "HU_neg_140_b2.mzML", "HU_neg_166_b2.mzML",
        "HU_neg_195_b2.mzML", "QC1_001.mzML", "QC1_001_b2.mzML",
        "QC1_002.mzML", "QC1_002_b2.mzML", "QC1_003.mzML", "QC1_003_b2.mzML",
        "QC1_004.mzML", "QC1_004_b2.mzML", "QC1_005.mzML", "QC1_005_b2.mzML",
        "QC1_006.mzML", "QC1_006_b2.mzML")))
})
