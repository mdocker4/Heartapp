library(shiny)
library(shinythemes)
library(data.table)
library(randomForest)
library(readr)

model <- readRDS("BestRFHDModel.rds")

# Define server logic required to draw a histogram
shinyServer(function(input,output,session){
    
    #input data
    datasetinput<-reactive({
        df1<-data.frame(
            Name=c("age",
                   "sex",
                   "cp",
                   "trestbps",
                   "chol",
                   "fbs",
                   "restecg",
                   "thalach",
                   "exang",
                   "oldpeak",
                   "slope",
                   "ca",
                   "thal"),
            Value=as.character(c(input$age,
                                 input$sex,
                                 input$cp,
                                 input$trestbps,
                                 input$chol,
                                 input$fbs,
                                 input$restecg,
                                 input$thalach,
                                 input$exang,
                                 input$oldpeak,
                                 input$slope,
                                 input$ca,
                                 input$thal)),
            stringsAsFactors = FALSE)
        HD<-"hd"
        df2<-rbind(df1,HD)
        input<-transpose(df2)
        write.table(input,"input.csv",sep=",",quote = FALSE,row.names = FALSE,col.names = FALSE)
        test<-read.csv(paste("input",".csv",sep=""),header=TRUE)
        test$sex<-factor(test$sex,levels=c("0","1"))
        test$cp<-factor(test$cp,levels=c("1","2","3","4"))
        test$fbs<-factor(test$fbs,levels=c("0","1"))
        test$restecg<-factor(test$restecg,levels=c("0","1","2"))
        test$exang<-factor(test$exang,levels=c("0","1"))
        test$slope<-factor(test$slope,levels=c("1","2","3"))
        test$ca<-factor(test$ca,levels=c("0","1","2","3"))
        test$thal<-factor(test$thal,levels=c("3","6","7"))
        test$hd<-factor(test$hd,levels = c("Healthy","Unhealthy"))
        Output<-data.frame(Prediction=predict(model,test),round(predict(model,test,type="prob"),3))
        print(Output)
    })
    #Status/Output Text Box
    output$contents <- renderPrint({
        if (input$submitbutton>0) { 
            isolate("Calculation complete.") 
        } else {
            return("Server is ready for calculation.")
        }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$submitbutton>0) { 
            isolate(datasetinput()) 
        } 
    })
})
