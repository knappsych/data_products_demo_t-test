library(shiny)
pageWithSidebar(
  #Application Title
  headerPanel(h2("Two Sample t-tests", align="center")),
  
  #Sidebar enter the data and various parameters for the t-test
  sidebarPanel(
    textInput("group1", label="Group 1 Data: Enter values separated by commas (e.g. 1,2,3)"),
    textInput("group2", label="Group 2 Data: Enter values separated by commas (e.g. 1,2,3)"),
    radioButtons("paired", label = "Group Types",
                 choices = list("Paired" = "paired", "Independent" = "independent")),
    radioButtons("variance", label = "Variance Assumption",
                 choices = list("Equal Variance" = "equal", "Different Variance" = "different")),
    actionButton("goButton", "Analyze and Graph the Data")
  ),
  mainPanel(
    uiOutput("error"),
    uiOutput("codeexp"),
    uiOutput("tcode"),
    uiOutput("resultexp"),
    uiOutput("tresults"),
    uiOutput("figexp"),
    plotOutput("figure")
  )
)