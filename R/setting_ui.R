setting_ui <- function() {
    last_search_dir <- ""
    # titlePanel("Protein Nankai University"),
    if (file.exists(SETTING_RDS_PATH)) {
        last_search_dir <- readRDS(SETTING_RDS_PATH)
    }
    fluidPage(
        fluidRow(
            column(4,
                textInput(
                    "setting.search_file_root_dir", 
                    "Search Files Root Dir", 
                    value = last_search_dir, 
                    width = NULL, 
                    placeholder = "Directory for searching files."
                )
            ),
        ),
        fluidRow(
            column(4,
                actionButton("setting.save", "Save")
            ),
        )
    )
}