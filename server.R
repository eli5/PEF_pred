# Konrad Tuszyński, Developing Data Products course project 2015
# App for calculating PEF

library(shiny)
 
PEFwoman <- function(h, a) { exp((0.376*log(a))-(0.012*a)-(58.8/h)+5.63) }
PEFman <- function(h, a) { exp((0.544*log(a))-(0.0151*a)-(74.7/h)+5.48) }

shinyServer(
  function(input, output) {
    
  #works     
      g<- reactive(input$gender)
               
      output$Pred<- renderPrint({
        g<- as.character(g())
        if (g == 'm')
          x<- round(PEFman(input$h, input$a))
        else
          x<- round(PEFwoman(input$h, input$a))
        return(x)
        })
      
      output$PredLimit<- renderPrint({
        g<- as.character(g())
        if (g == 'm')
          x<- round(PEFman(input$h, input$a)*0.8)
        else
          x<- round(PEFwoman(input$h, input$a)*0.8)
        return(x)
      })
      
      
      output$newHist <- renderPlot({
        g<- as.character(g())
        if (g == 'm') {
          predicted<- as.numeric(PEFman(input$h, input$a))
        } else {
          x<-PEFwoman(input$h, input$a)
          predicted<- as.numeric(PEFwoman(input$h, input$a))
        }
        
        maxValue<- 800
        lowerLimit<- predicted*0.8; pred<-predicted-predicted*0.8; max<-maxValue-predicted
        
        legend<-c("Asthma is under good control.",
                  "Caution! Respiratory airways are narrowing. A reliver might be needed.",
                  "Indicates a medical emergency. Get in touch with your doctor ASAP!")
        DF <- data.frame(names = legend, freq=c(lowerLimit, pred, max))
        
        barplot(as.matrix(DF[,2]), col=c(2,7,3), ylim= c(000, maxValue), xlim=c(0,80), width=20)
        title("Setting a personal peakflowmeter")
        par(xpd=TRUE)
        legend(-10,-30, legend=DF[,1], pch=19, col=c(3,7,2))
        
        m<- max(as.numeric(input$m1), as.numeric(input$m2), as.numeric(input$m3))
        abline(m, 0, col='red', lwd=2, lty='dashed')
        text(60, m+30, labels = paste("measured: ", m, "[L/min]"), adj = 0)
        
      }, height = 450, width = 470)
    
  }
)



#shinyapps::deployApp()
          
