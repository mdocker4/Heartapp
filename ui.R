#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(randomForest)
library(readr)
library(ggplot2)
library(cowplot)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("superhero"),
                  #Page Header
                  headerPanel("Heart Disease Detector"),
                  #Input values
                  sidebarPanel(
                      HTML("<h3>Input Parameters</h3>"),
                      sliderInput("age","Age:",
                                  min=20,max=100,
                                  value=65),
                      radioButtons(
                          "sex",
                          "Gender:",
                          choices = list("Male"="1","Female"="0"),
                          selected = "Male"),
                      selectInput("cp",label = "Chest Pain Level:",
                                  choices = list("Typical Angina" = "1","Atypical Angina" = "2","Non-anginal Pain" = "3","Asymptomatic"="4"),
                                  selected = "Typical Angina"),
                      sliderInput("trestbps","Resting Blood Pressure:",
                                  min=50,max=250,
                                  value = 100),
                      sliderInput("chol","Cholesterol:",
                                  min=100,max=600,
                                  value = 200),
                      selectInput("fbs", label = "Is fasting blood sugar less than 120 mg/dl:", 
                                  choices = list("Yes" = "1", "No" = "0"), 
                                  selected = "Yes"),
                      selectInput("restecg", label = "Resting electrocardiographic results:", 
                                  choices = list("Normal" = "0", "Having ST-T wave abnormality" = "1","Showing probable or definite left ventricular hypertrophy"="2"), 
                                  selected = "Normal"),
                      sliderInput("thalach","Maximum heart rate achieved:",
                                  min=70,max=250,
                                  value = 150),
                      selectInput("exang", label = "Exercise induced angina:", 
                                  choices = list("Yes" = "0", "No" = "1"), 
                                  selected = "Yes"),
                      sliderInput("oldpeak","ST depression induced by exercise relative to rest:",
                                  min=0,max=10,
                                  value = 5),
                      selectInput("slope", label = "The slope of the peak exercise STsegment:", 
                                  choices = list("Upsloping" = "1", "Flat" = "2","Downsloping"="3"), 
                                  selected = "Upsloping"),
                      selectInput("ca", label = "Number of major vessels (0-3) colored by fluoroscopy:", 
                                  choices = list("0" = "0", "1" = "1","2"="2","3"="3"), 
                                  selected = "0"),
                      selectInput("thal", label = "Thalium heart scan:", 
                                  choices = list("Normal/No Cold Spots" = "3", "Fixed defect/Cold spots during rest and exercise" = "6","Reversible defect/Cold spots only appear during exercise"="7"), 
                                  selected = "0"),
                      actionButton("submitbutton", "Submit", class = "btn btn-primary")
                  ),
                  mainPanel(
                      tags$label(h3('Status/Output Box')), # Status/Output Text Box
                      verbatimTextOutput('contents'),
                      tableOutput('tabledata')
                  )
))