ui <- function() {
    navbarPage("Protein Nankai University",
        tabPanel("Analyzing", create_task_ui()),
        tabPanel("Setting", setting_ui()),
    )
}