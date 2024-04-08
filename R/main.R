#' protein_nankai
#'
#' ENTRY.
#'
#' @param port port
#' @import shiny
#' @import shinyFiles
#' @import pepXMLTab
#' @import random
#' @import methods
#' @import lubridate
#' @import MSnbase
#' @importFrom xcms filterRt filterMz chromatogram
#' @importFrom grDevices rainbow
#' @importFrom graphics legend lines
#' @export
protein_nankai <- function(port = 7654) {
    shinyApp(ui, server)
}