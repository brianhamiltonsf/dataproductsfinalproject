#
# Brian Hamilton
# Developing Data Products Course Project
#

library(shiny)

# Define UI for the application 
ui <- fluidPage(
   
   # Application title
   titlePanel("Predict Child's Height based on Parent's Height"),
   
   # Sidebar with slider inputs for entering the parent's height
   sidebarLayout(
      sidebarPanel(
         tags$h4("Is the child a boy or a girl?"),
         radioButtons("gender",
                      label = "",
                      choices = list("boy" = 1,"girl" = 2)),
         tags$hr(),
         tags$h4("Enter the father's height:"),
         sliderInput("fatherFeet",
                     "Feet",
                     min = 4,
                     max = 7,
                     value = 4),
         sliderInput("fatherInches",
                     "Inches",
                     min = 0,
                     max = 12,
                     value = 0),
         tags$hr(),
         tags$h4("Enter the mother's height:"),
         sliderInput("motherFeet",
                     "Feet",
                     min = 4,
                     max = 7,
                     value = 4),
         sliderInput("motherInches",
                     "Inches",
                     min = 0,
                     max = 12,
                     value = 0),
         actionButton("button",
                      "Calculate"
                      )
        
      ),
      
      # Show the child's predicted height
      mainPanel(
        tags$h4("The child's predicted height is: "),
        textOutput("childHeight")
      )
   )
)

# Define server logic 
server <- function(input, output) {
   observeEvent(input$button, 
     output$childHeight <- renderText({
       # add the father and mother height
       fatherFeet <- input$fatherFeet
       fatherInches <- input$fatherInches
       motherFeet <- input$motherFeet
       motherInches <- input$motherInches
       totalInches <- fatherInches + (fatherFeet * 12) + motherInches + (motherFeet *12)
       
       # add five inches for a boy, subtract five inches for a girl
       if(input$gender == 1){
         totalInches <- totalInches + 5
       } else {
         totalInches <- totalInches - 5
       }
       
       # divide totalInches by 2
       totalInches <- totalInches / 2
       
       # create output
       paste(as.integer(totalInches / 12), " feet, ", as.integer(totalInches %% 12), " inches")
     })
   )
}

# Run the application 
shinyApp(ui = ui, server = server)

