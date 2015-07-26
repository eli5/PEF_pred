# Konrad Tuszyński, Developing Data Products course project 2015
# App for calculating PEF


library(shiny)

# Define UI for dataset viewer application
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Peak Expiratory Flow Prediction"),
    
    sidebarPanel(
      radioButtons('gender', 'Gender', c("Female"='f', "Male"='m'), selected = NULL, inline = FALSE),
      sliderInput('h', 'Height [cm]', 150, min = 50, max = 200, step = 1),
      sliderInput('a', 'Age [years]', 25, min = 5, max = 99, step = 1),
      br(),
      h4('Take 3 measurements:'),
      p('(highest value is considered)'),
      numericInput('m1', 'PEF [L/min]', 0, min = 200, max = 1000, step = 1),
      numericInput('m2', 'PEF [L/min]', 0, min = 200, max = 1000, step = 1),
      numericInput('m3', 'PEF [L/min]', 0, min = 200, max = 1000, step = 1)
      
    ),
    mainPanel(
      h3('Results'),
      h4('Predicted normal value:'),
      strong(span( textOutput("Pred"), style='color:red')),
      br(),
      p('lower limit (80% of PEF normal value):'),
      textOutput("PredLimit"),
      plotOutput("newHist"),
      
      br(),
      br(),
      br(),
      p('Calculating normal PEF values for healthy people. For educational purposes only.'),
      strong('(c) Konrad Tuszyński, Developing Data Products, Coursera course project 2015'),
      br(),
      br(),
      br(),
      p('An example of a cheap mechanical personal peakflowmeter:'),
      img(src = 'http://www.oncallmedicalsupplies.co.uk/media/catalog/product/cache/2/image/9df78eab33525d08d6e5fb8d27136e95/M/P/MPE8200EUlarge.jpg'),
      br(),
      br(),
      strong('Documentation'),
      p('This app calculates the expected Peak Expiratory Flow for a healthy indivitual or for a
        person with controlled asthma. Simply specify your gender, body weight and height.
        The predicted value will be given - your measurement shouldnt fall below 80% of this value (also 
        given). It this is the case, your airways are narrowing! I am a pharmacist and i will 
        be actually using this app in my work! Formulae used for calculations:'),
      p('Radeos MS, Camargo CA. Predicted peak expiratory flow: differences across formulae in the literature. Am J Emerg Med. 2004 Nov;22(7):516-21.'),
      p('Notice: once you are getting old, your expected outcome is increasing to the point you are
        old and then it starts decreasing. Once you set the limits, you take 3 measurements
        from the peakflowmeter - the app chooses the max value and plots it on the scale.'),
      br(),br(),br(),
      br()
    )
  )
)
