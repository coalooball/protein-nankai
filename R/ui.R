ui <- fluidPage(
    titlePanel("Protein Nankai University"),
    fluidRow(
        textInput("load_file_root", "Root Dir", value = "", width = NULL, placeholder = NULL)
    ),
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
        tableOutput("pepxml_file1_contents")
    )
)