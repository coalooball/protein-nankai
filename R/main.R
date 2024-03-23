#' protein_nankai
#'
#' ENTRY.
#'
#' @param port port
#' @import shiny
#' @import shinyFiles
#' @import pepXMLTab
#' @export
protein_nankai <- function(port = 7654) {
    shinyApp(ui, server)
}