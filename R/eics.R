#' Generating points forming EIC
#'
#' Define a function that takes a mzML data and rt/mz ranges.
#'
#' @param raw_data raw_data
#' @param ranges ranges
#' @export
generate_points_as_EICs <- function(raw_data, ranges) {
  rt_ranges = ranges$rt_ranges
  mz_ranges = ranges$mz_ranges
  eic_results <- list()
  for (i in 1:length(rt_ranges)) {
    rt_range <- rt_ranges[[i]]
    mz_range <- mz_ranges[[i]]
    filtered_data <- filterRt(filterMz(raw_data, mz = mz_range), rt = rt_range)
    eic <- chromatogram(filtered_data, mz = mz_range, rt = rt_range)
    eic_results[[i]] <- eic
  }
  rt_min <- Inf
  rt_max <- -Inf
  int_min <- Inf
  int_max <- -Inf
  for (eic in eic_results) {
    temp_min = min(rtime(eic[[1]]))
    temp_max = max(rtime(eic[[1]]))
    if (rt_min > temp_min) {
      rt_min = temp_min
    }
    if (rt_max < temp_max) {
      rt_max = temp_max
    }
    temp_min = min(intensity(eic[[1]]), na.rm = TRUE)
    temp_max = max(intensity(eic[[1]]), na.rm = TRUE)
    if (int_min > temp_min) {
      int_min = temp_min
    }
    if (int_max < temp_max) {
      int_max = temp_max
    }
  }
  rt_min_max <- c(rt_min, rt_max)
  int_min_max <- c(int_min, int_max)
  EicResults(rt_min_max, int_min_max, eic_results)
}

plot_via_eicResults <- function(eic_res) {
  colors <- rainbow(length(eic_res@data))
  plot(NA, xlim = eic_res@rt_min_max, ylim = eic_res@int_min_max, xlab = "Retention Time", ylab = "Intensity", main = "EICs", type = "n")
  for (i in 1:length(eic_res@data)) {
    eic <- eic_res@data[[i]]
    lines(rtime(eic[[1]]), intensity(eic[[1]]), type = "l", col = colors[i], lwd = 2)
  }
  # legend_labels <- sapply(1:length(mz_ranges), function(i) paste("m/z =", mz_ranges[[i]][1], "-", mz_ranges[[i]][2]))
  legend_labels <- sapply(1:length(eic_res@data), function(i) paste("item ", i))
  legend("topright", legend = legend_labels, col = colors, lwd = 2)
}
