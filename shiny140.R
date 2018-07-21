library(dplyr)
busbit <- filter(bus_new,attributes.BusinessAcceptsBitcoin==TRUE)


library(shiny)

ui <- fluidPage(selectInput(inputId = "state", "Choose a State", levels(as.factor(busbit$state))),
                selected = levels(as.factor(busbit$state))[11],
                plotOutput("hist")
)


server <- function(input, output) {
  bitcoin <- reactive({
    as.data.frame(busbit[busbit$state == input$state,])
  })
  output$hist <- renderPlot({
    qplot(attributes.RestaurantsPriceRange2,
          data=bitcoin(),
          color=factor(attributes.RestaurantsPriceRange2),
         # fill=I(c("blue")),
          geom="histogram",binwidth=1,xlim=c(0,5),
          xlab="Price Range",ylab="Count")
  })
}

shinyApp(ui = ui, server = server)
