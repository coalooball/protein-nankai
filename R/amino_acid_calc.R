# Define LIST of amino_acids
amino_acids <- list(
  A = c(3, 5, 1, 1, 0, 0),
  C = c(3, 5, 1, 1, 0, 1),
  D = c(4, 5, 3, 1, 0, 0),
  E = c(5, 7, 3, 1, 0, 0),
  F = c(9, 9, 1, 1, 0, 0),
  G = c(2, 3, 1, 1, 0, 0),
  H = c(6, 7, 1, 3, 0, 0),
  I = c(6, 11, 1, 1, 0, 0),
  K = c(6, 12, 1, 2, 0, 0),
  L = c(6, 11, 1, 1, 0, 0),
  M = c(5, 9, 1, 1, 0, 1),
  N = c(4, 6, 2, 2, 0, 0),
  P = c(5, 7, 1, 1, 0, 0),
  Q = c(5, 8, 2, 2, 0, 0),
  R = c(6, 12, 1, 4, 0, 0),
  S = c(3, 5, 2, 1, 0, 0),
  T = c(4, 7, 2, 1, 0, 0),
  V = c(5, 9, 1, 1, 0, 0),
  W = c(11, 10, 1, 2, 0, 0),
  Y = c(9, 9, 2, 1, 0, 0),
  a = c(2, 2, 1, 0, 0, 0),
  c = c(5, 8, 2, 2, 0, 1),
  m = c(5, 9, 2, 1, 0, 1)
)

# Name each element vector
names_vector <- c("C", "H", "O", "N", "P", "S")
for (i in names(amino_acids)) {
  names(amino_acids[[i]]) <- names_vector
}

#' sum_amino_acids
#'
#' Define a function that inputs a string and accumulates the number of digits based on each letter.
#'
#' @param sequence Alphabetical sequence of peptides
#' @export
#' @examples
#' sum_amino_acids("ACDE")
sum_amino_acids <- function(sequence) {
  total_counts <- c(C=0, H=0, O=0, N=0, P=0, S=0)
  sequence <- strsplit(sequence, "")[[1]]
  for (letter in sequence) {
    if (letter %in% names(amino_acids)) {
      counts <- amino_acids[[letter]]
      total_counts <- total_counts + counts
    }
  }
  return(total_counts)
}

#' count_carbon_atoms
#'
#' Define a function that takes a peptide name and outputs the number of C elements it contains.
#'
#' @param sequence Alphabetical sequence of peptides
#' @export
#' @examples
#' count_carbon_atoms("ACDE")
count_carbon_atoms <- function(sequence) {
    sum_amino_acids(sequence)[["C"]]
}

#' Generating ranges
#'
#' Define a function that takes a peptide name and outputs the ranges of rt and mz.
#'
#' @param sequence Alphabetical sequence of peptides
#' @param rt rt
#' @param mz mz
#' @param charge charge
#' @param rt_tolerance rt_tolerance
#' @param mz_tolerance mz_tolerance
#' @export
#' @examples
#' generate_rt_mz_ranges(
#'    "AGPQAKK", 
#'    as.double("213.421"), as.double("123.12"), as.numeric("2"), 15, 10)
generate_rt_mz_ranges <- function(sequence, rt, mz, charge, rt_tolerance, mz_tolerance) {
  rt <- as.double(rt)
  mz <- as.double(mz)
  charge <- as.numeric(charge)
  num_c <- count_carbon_atoms(sequence)
  rt_ranges <- list(c(rt - rt_tolerance, rt + rt_tolerance), c(rt - rt_tolerance, rt + rt_tolerance))
  mz_ranges <- list(
    c(mz - mz_tolerance + 1/charge*-1, mz + mz_tolerance + 1/charge*-1),
    c(mz - mz_tolerance + 1/charge*0, mz + mz_tolerance + 1/charge*0)
  )
  for (i in 1:num_c) {
    rt_ranges <- c(rt_ranges, list(c(rt - rt_tolerance, rt + rt_tolerance)))
    mz_ranges <- c(mz_ranges, list(c(mz - mz_tolerance + 1/charge*i, mz + mz_tolerance + 1/charge*i)))
  }
  list(rt_ranges=rt_ranges, mz_ranges=mz_ranges)
}

atomic_properties <- list(
  C = data.frame(
    isotopeNr = c(12, 13),
    mass = c(12.0, 13.0033548378),
    abundance = c(0.9889, 0.0111)
  ),
  H = data.frame(
    isotopeNr = c(1, 2),
    mass = c(1.0078250321, 2.0141017780),
    abundance = c(0.999885, 0.000115)
  ),
  O = data.frame(
    isotopeNr = c(16, 17, 18),
    mass = c(15.9949146, 16.9991312, 17.9991603),
    abundance = c(0.99757, 0.00038, 0.00205)
  ),
  N = data.frame(
    isotopeNr = c(14, 15),
    mass = c(14.0030740052, 15.0001088984),
    abundance = c(0.99636, 0.00364)
  ),
  P = data.frame(
    isotopeNr = 31,
    mass = 30.97376163,
    abundance = 1
  ),
  S = data.frame(
    isotopeNr = c(32, 33, 34, 36),
    mass = c(31.97207070, 32.97145843, 33.96786665, 35.96708062),
    abundance = c(0.9499, 0.0075, 0.0425, 0.0001)
  )
)

# Calculate the average mass of the elements
calculate_element_mass <- function(element) {
  properties <- atomic_properties[[element]]
  average_mass <- sum(properties$mass * properties$abundance)
  return(average_mass)
}

# Calculate the total mass of a given combination
calculate_mass <- function(elements) {
  total_mass <- 0
  for (element in names(elements)) {
    element_mass <- calculate_element_mass(element)
    total_mass <- total_mass + (element_mass * elements[[element]])
  }
  return(total_mass)
}