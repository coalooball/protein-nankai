ui <- function() {
    navbarPage("Protein Nankai University",
        tabPanel("Setting", setting_ui()),
        tabPanel("Analyzing", create_task_ui()),
    )
}