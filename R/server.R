server <- function(input, output) {
    options(shiny.maxRequestSize=500*1024^2)
    file_root = reactive({
        input$load_file_root
    })
    
    get_file_root = reactive({
        if (nchar(file_root()) == 0) {
            tmp_file_root = getwd()
        } else {
            tmp_file_root = file_root()
        }
        names(tmp_file_root) = "working-dir"
        tmp_file_root
    })
    
    shinyFileChoose(input, "pepxml_file1", root = get_file_root(), filetypes = c('xml'))
    pepxml_name <- reactive({
        # print(typeof(input$pepxml_file1))
        # if (typeof(input$pepxml_file1) == "list") {
            print(input$pepxml_file1)
            print(get_file_root())
        if (!is.null(input$pepxml_file1)) {
            file_selected<-parseFilePaths(get_file_root(), input$pepxml_file1)
            # https://stackoverflow.com/questions/25640161/r-how-to-test-for-character0-in-if-statement
            # The type of file_selected$datapath is `character(0)` at very beginning. 
            if (rlang::is_empty(file_selected$datapath)) {
                ""
            } else {
                as.character(file_selected$datapath)
            }
        } else {
            ""
        }
    })
    output$pepxml_file1_contents <- renderTable({
        ext <- tools::file_ext(pepxml_name())

        req(file)
        validate(need(ext == "xml", "Please upload a pep.xml file"))
        # pepXML2tab(file$datapath)
    })
    output$is_selected_pepxml_file1 <- reactive({
        nchar(pepxml_name()) > 0
    })
    output$pepxml_file1_path_detail <- renderText({ 
        print(pepxml_name())
        paste0("Selected Pepxml File: ", pepxml_name(), " .")
    });
    outputOptions(output, "is_selected_pepxml_file1", suspendWhenHidden = FALSE)  
}
