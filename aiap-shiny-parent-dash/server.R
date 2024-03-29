library(shiny)
library(shinydashboard)
library(data.table)
library(plyr)
library(DT)
library(shinyjs)
library(readxl)
library(wordcloud)
library(ggplot2)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

anneData <- readxl::read_xlsx("data/Anne Data 1.xlsx")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot1<-renderPlot({
    
    ggplot(anneData, aes(timestamp, feeling_index)) + geom_line() + xlab("Time") + ylab("Feeling Index")
    
  })
  
  output$wordPlot <- renderPlot({
    
    docs <- Corpus(VectorSource(anneData$how_are_you_feeling))
    
    toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
    docs <- tm_map(docs, toSpace, "/")
    docs <- tm_map(docs, toSpace, "@")
    docs <- tm_map(docs, toSpace, "\\|")
    
    # Convert the text to lower case
    docs <- tm_map(docs, content_transformer(tolower))
    # Remove numbers
    docs <- tm_map(docs, removeNumbers)
    # Remove english common stopwords
    docs <- tm_map(docs, removeWords, stopwords("english"))
    # Remove your own stop word
    # specify your stopwords as a character vector
    docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
    # Remove punctuations
    docs <- tm_map(docs, removePunctuation)
    # Eliminate extra white spaces
    docs <- tm_map(docs, stripWhitespace)
    # Text stemming
    # docs <- tm_map(docs, stemDocument)
    
    dtm <- TermDocumentMatrix(docs)
    m <- as.matrix(dtm)
    v <- sort(rowSums(m),decreasing=TRUE)
    d <- data.frame(word = names(v),freq=v)
    head(d, 10)
    
    set.seed(1234)
    wordcloud(words = d$word, freq = d$freq, min.freq = 1,
              max.words=200, random.order=FALSE, rot.per=0.35, 
              colors=brewer.pal(8, "Dark2"))
    
  })
  
})
