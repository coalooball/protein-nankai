create_task_ui <- function() {
    fluidPage(
        # titlePanel("Protein Nankai University"),
        fluidRow(
            column(6,
                shinyFilesButton("pepxml_file1", label="Choose pep.xml File", title='Please select a pep.xml file', multiple=FALSE)
            ),
            column(6,
                conditionalPanel(
                condition = "output.is_selected_pepxml_file1",
                textOutput("pepxml_file1_path_detail")
                )
            )
        ),
        fluidRow(
            column(6,
                shinyFilesButton("mzml_files1", label="Choose mzML Files", title='Please select mzML files', multiple=TRUE)
            ),
            column(6,
                conditionalPanel(
                condition = "output.is_selected_mzML_file1",
                textOutput("mzml_file1_path_detail")
                )
            )
        ),
        conditionalPanel(
            condition = "output.show_analyzing_btn",
            fluidRow(
                column(6,
                    textInput(
                        "create_task.task_name", 
                        "Task Name", 
                        value = "", 
                        width = NULL, 
                        placeholder = "The name of task."
                    )
                )
            )
        ),
        conditionalPanel(
            condition = "output.show_analyzing_btn",
            fluidRow(
                column(2,
                    actionButton("analyzing_data", "Analyzing", class = "btn-success")
                ),
                column(6,
                    # conditionalPanel(
                        # condition = "output.bool_analyzing",
                        textOutput("analyzing_info")
                    # )
                )
            )
        ),
        fluidRow(
            tableOutput("pepxml_file1_contents")
        )
    )
}