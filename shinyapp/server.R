#http://shiny.rstudio.com/articles/debugging.html for debugging info
library(shiny)
library(dplyr)
library(ggplot2)
mytfunc<-function(g1,g2,pairing,vareq){
  t<-t.test(g1,g2,paired=pairing,var.equal=vareq)
  tval<-t$statistic
  df<-t$parameter
  pval<-t$p.value
  pstatement=sprintf("p = %.3f",pval)
  if(pval<.001){
    pstatement="p < .001"
  }
  dfstatement=sprintf("%.0f",df)
  if(vareq=="FALSE"){
    dfstatement=sprintf("%.2f",df)
  }
  else{
    dfstatement=sprintf("%.0f",df)
  }
  sprintf("t(%s) = %.1f, %s",dfstatement,tval,pstatement)
}

shinyServer(
  function(input,output){
    output$error<-renderUI({
      input$goButton
      isolate({
        group1=as.numeric(strsplit(gsub(" ","",input$group1),split=",")[[1]])
        group2=as.numeric(strsplit(gsub(" ","",input$group2),split=",")[[1]])
        if (input$goButton == 0){
          output$codeexp<-renderUI({""})
          output$tcode<-renderUI({""})
          output$resultexp<-renderUI({""})
          output$tresults<-renderUI({""})
          output$figexp<-renderUI({""})
          ""
        }
        else if(length(group1)<2 || length(group2)<2){
          output$codeexp<-renderUI({""})
          output$tcode<-renderUI({""})
          output$resultexp<-renderUI({""})
          output$tresults<-renderUI({""})
          output$figexp<-renderUI({""})
          p("You don't have enough data yet.")
        }
        else if (input$paired=="paired" && length(group1)!=length(group2)){
          output$codeexp<-renderUI({""})
          output$tcode<-renderUI({""})
          output$resultexp<-renderUI({""})
          output$tresults<-renderUI({""})
          output$figexp<-renderUI({""})
          p("The number of observations in each group must match.")
        }
        else{
          #Explain we'll be showing the code they use
          output$codeexp<-renderUI({
            p("The r code for running this type of t-test is:")
          })
          
          #Present the code
          output$tcode<-renderUI({
            if(input$paired=="paired" && input$variance=="equal"){
              code("t.test(group1,group2,paired=TRUE,var.equal=TRUE)")
            }
            else if(input$paired=="paired" && input$variance=="different"){
              code("t.test(group1,group2,paired=TRUE,var.equal=FALSE)")
            }
            else if(input$paired=="independent" && input$variance=="different"){
              code("t.test(group1,group2,paired=FALSE,var.equal=FALSE)")
            }
            else{
              code("t.test(group1,group2,paired=FALSE,var.equal=TRUE)")
            }
          })
          
          #Explain we'll show the APA style results.
          output$resultexp<-renderUI({
            p("The results of the test in APA format are:")
          })
          
          #Output the results
          output$tresults<-renderUI({
            if(input$paired=="paired" && input$variance=="equal"){
              p(mytfunc(group1,group2,TRUE,TRUE))
            }
            else if(input$paired=="paired" && input$variance=="different"){
              p(mytfunc(group1,group2,TRUE,FALSE))
            }
            else if(input$paired=="independent" && input$variance=="different"){
              p(mytfunc(group1,group2,FALSE,FALSE))
            }
            else{
              p(mytfunc(group1,group2,FALSE,TRUE))
            }
          })
          
          #Indicate we'll show them a graph
          output$figexp<-renderUI({
            p("Here's a graph showing the two variables graphed with error bars representing the standard error of the mean for each sample.")
          })
          
          #Show the graph
          output$figure<-renderPlot({
            scores=c(group1,group2)
            Group=c(rep("Group 1", times=length(group1)),rep("Group 2", times=length(group2)))
            dat<-data.frame(scores, Group)
            temp<-dat%>%group_by(Group)%>%summarize(Scores=mean(scores),SEMS=(sd(scores))/sqrt((length(scores))))
            fig<-ggplot(temp, aes(x=Group, y=Scores))+
              geom_bar(stat="identity", color="black", fill="blue")+
              geom_errorbar(aes(ymax=Scores+SEMS, ymin=Scores-SEMS),width=.2)
            fig
          })
          
          ""#No error
          
        }#end else for no errors
      })#end isolate
    })#end render for error
  }#end function(input,output)
)#end shinyserver

