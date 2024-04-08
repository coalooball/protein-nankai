get_pepxml_data <- function(file_path) {
    pepXML2tab(file_path)
}

get_pepxml_item_ranges <- function(pepxml_data, idx, rtt = 15, mzt = 10) {
    p = pepxml_data$peptide[[idx]]
    c = pepxml_data$assumed_charge[[idx]]
    rt = pepxml_data$retention_time_sec[[idx]]
    mz = pepxml_data$precursor_neutral_mass[[idx]]
    generate_rt_mz_ranges(p, rt, mz, c, rtt, mzt)
}

get_eic_via_pepxml_item <- function(mzml_data, pepxml_data, pepxml_idx, rtt = 15, mzt = 10) {
    ranges <- get_pepxml_item_ranges(pepxml_data, pepxml_idx, rtt, mzt)
    generate_points_as_EICs(mzml_data, ranges)
}

get_mzml_data <- function(file_path) {
    readMSData(files = file_path, mode = "onDisk")
}