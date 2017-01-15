library(shiny)
#library(shinyFiles)
library(png)
library(DT)

shinyServer(
    function(input, output) {
        
        # dir
        #shinyDirChoose(input, "dir", roots = c(home = "~"), filetypes = c("", "jpg"))
        #dir <- ractive(input$dir)
        # doesn't work yet
        
        images_list_raw <- list.files("www")
        images_list <- images_list_raw[grepl(".jpg", images_list_raw)]
        
        output$myimage <- renderUI({
            
            counter <- input$noduckface + input$duckface + 1
            
            #images_list_raw <- images_list_raw()
            #images_list <- images_list_raw[grepl(".jpg", images_list_raw)]
            
            pic_name <- as.character(images_list[counter])
            
            img(src = pic_name,
                height = "600px", 
                width = "600px")
            

        })

        observe({
            
            if (input$goButton == 0 & (input$duckface + input$noduckface) == 0) {
                
                df_new <- data.frame(rater = character(0), 
                                     pic_name = character(0),
                                     rating = logical(0))
                
                isolate(write.table(df_new, 
                                    "~/Desktop/classificationApp/output.csv", 
                                    row.names = FALSE, 
                                    sep = ","))
                
            }
            
            if (input$goButton > 0 & (input$duckface + input$noduckface) > 0)  {
            
                
                counter <- input$noduckface + input$duckface
                pic_name <- as.character(images_list[counter])
                rater <- input$rater
                last_button <- input$last_btn
                if (last_button == "noduckface") {
                    rating <- FALSE
                }
                if (last_button == "duckface") {
                    rating <- TRUE
                }
                df_new <- data.frame(rater = rater, 
                                     pic_name = pic_name,
                                     rating = rating)
                isolate(write.table(df_new, 
                               "~/Desktop/classificationApp/output.csv", 
                               row.names = FALSE, 
                               col.names = FALSE, 
                               append = TRUE,
                               sep = ","))
            }

       })
        
        # Further Ideas:
        # - let user choose dir where pics are located http://stackoverflow.com/questions/39196743/interactive-directory-input-in-shiny-app-r
        # - let user choose name of file where results should be stored
        # - find out how to best store rating (in csv? in meta info of pic? etc.)
       
})
