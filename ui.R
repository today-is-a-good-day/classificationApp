library(shiny)
#library(shinyFiles)

shinyUI(
    fluidPage(
        titlePanel("Not Tinder"),
        tags$head(tags$script(HTML("$(document).on('click', '.needed', function () {
                                Shiny.onInputChange('last_btn',this.id);
                             });"))),
        sidebarLayout(
            sidebarPanel( 
                textInput("rater", label = h3("Enter Rater Name:")),
                #shinyDirButton("dir", "Indicate directory with Pics", "Upload"),
                actionButton("goButton", "Start", styleclass = "primary")
            ),
            mainPanel(
                h3("Info"),
                p("Indicate wether or not you see a duck face in the pictures below
              by clicking the respective buttons."),
                conditionalPanel(
                    condition = "input.goButton > 0",
                    uiOutput("myimage")
                ),
                br(),
                column(
                    tags$head(tags$script(src = "left_arrow.json")),
                    div(actionButton("noduckface", "No Duckface", class = "needed"), 
                        style="horizontal-aign: right; float:right"),
                    width = 6),
                column(
                    tags$head(tags$script(src = "right_arrow.json")),
                    div(actionButton("duckface", "Duckface", class = "needed"),
                        style="float:left"), 
                    width = 6)
            
            )
        )
    )
)