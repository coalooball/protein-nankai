server <- function(input, output) {
    options(shiny.maxRequestSize=500*1024^2)
    file_root = reactive({
        input$setting.search_file_root_dir
    })

    current_task_name <- reactive({
        input$create_task.task_name
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
    shinyFileChoose(input, "mzml_files1", root = get_file_root(), filetypes = c('mzML'))
    pepxml_name <- reactive({
        # print(typeof(input$pepxml_file1))
        # if (typeof(input$pepxml_file1) == "list") {
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
    mzML_name <- reactive({
        if (!is.null(input$mzml_files1)) {
            file_selected<-parseFilePaths(get_file_root(), input$mzml_files1)
            # https://stackoverflow.com/questions/25640161/r-how-to-test-for-character0-in-if-statement
            # The type of file_selected$datapath is `character(0)` at very beginning. 
            if (rlang::is_empty(file_selected$datapath)) {
                ""
            } else {
                print(typeof(file_selected$datapath))
                print(file_selected$datapath)
                as.character(file_selected$datapath)
            }
        } else {
            ""
        }
    })
    observeEvent(input$analyzing_data, {
        # output$bool_analyzing <- reactive({TRUE})
        output$analyzing_info <- renderText({ 
            paste0("Loading Pepxml File: ", pepxml_name(), " ...")
        });
        # output$pepxml_file1_contents <- renderTable({
            
        #     ext <- tools::file_ext(pepxml_name())

        #     req(file)
        #     validate(need(ext == "xml", "Please upload a pep.xml file"))
            
        #     pepXML2tab(pepxml_name())
        # })
        task_result_path <- paste(
            PROTEIN_NANKAI, 
            randomStrings(n = 1, len=18),
            RDS_EXT,
            sep="."
        )
        t_time <- as.character(now())
        task_name <- as.character(now())
        if (nchar(current_task_name()) != 0){
            task_name = current_task_name()
        }
        t = TaskData(task_name, t_time, list())
        saveRDS(t, task_result_path)
        output$analyzing_info <- renderText({ 
            paste0("Loaded Pepxml File: ", pepxml_name(), " .")
        });
    })
    observeEvent(input$setting.save, {
        saveRDS(input$setting.search_file_root_dir, SETTING_RDS_PATH)
    })
    output$bool_analyzing <- reactive({FALSE})
    output$is_selected_pepxml_file1 <- reactive({
        nchar(pepxml_name()) > 0
    })
    output$is_selected_mzML_file1 <- reactive({
        nchar(mzML_name()) > 0
    })
    output$pepxml_file1_path_detail <- renderText({ 
        paste0("Selected Pepxml File: ", pepxml_name(), " .")
    });
    output$mzml_file1_path_detail <- renderText({ 
        print(mzML_name())
        paste0("Selected mzML Files: ", mzML_name(), " .")
    });
    # When the pepxml mzml file is also selected, the Analyze button is displayed
    output$show_analyzing_btn <- reactive({
        nchar(pepxml_name()) > 0 && nchar(mzML_name()) > 0
    })
    outputOptions(output, "is_selected_pepxml_file1", suspendWhenHidden = FALSE)  
    outputOptions(output, "is_selected_mzML_file1", suspendWhenHidden = FALSE)  
    outputOptions(output, "show_analyzing_btn", suspendWhenHidden = FALSE)  
    # outputOptions(output, "bool_analyzing", suspendWhenHidden = FALSE)  
}
