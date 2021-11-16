library(shiny);
library(readr);
library(dplyr);
library(ggplot2);
library(tidyr);

Summer_Olympic_Medals <- read.csv("Summer-Olympic-medals-1976-to-2008.csv");
Filtered_Countries <- Summer_Olympic_Medals %>% filter(Year==1976) %>% group_by(Country_Code) %>% summarise(Count=n()) %>% select(Country_Code);

for(i in seq(from=1980, to=2008, by=4)){
  Filtered_Countries_Right <- Summer_Olympic_Medals %>% filter(Year==i) %>% group_by(Country_Code) %>% summarise(Count=n()) %>% select(Country_Code);
  Filtered_Countries <- inner_join(Filtered_Countries, Filtered_Countries_Right, by="Country_Code");
}

ui <- fluidPage(
  sliderInput(inputId="n", "Year", min = 1976, max = 2008, value=1976, step=4), 
  checkboxGroupInput(inputId="boxes", label="Medal Types", choices=c("Bronze", "Silver", "Gold"), selected=c("Bronze", "Silver", "Gold")),
  checkboxGroupInput(inputId="genders", label="Gender of Winner", choices=c("Men", "Women"), selected=c("Men", "Women")),
  checkboxGroupInput(inputId="all", label="Include All Countries?", choices=c("Only Include Countries That Were in All of the Olympics"), selected=c()),
  plotOutput(outputId = "barplot")
);

server <- function(input,output,session){
  output$barplot <- renderPlot({
    
    Medal_Data<-Summer_Olympic_Medals
    
    if(length(input$all)!=0){
      Medal_Data<-Medal_Data %>% inner_join(Filtered_Countries, by="Country_Code");
    }
    
    data <- Medal_Data %>% mutate(included=(Year==4*floor((input$n)/4) & Medal %in% input$boxes & Gender %in% input$genders)) %>% 
      select(Country_Code, included) %>% group_by(Country_Code) %>% summarise(Count=sum(included)) %>% drop_na()
    
    data %>% ggplot(aes(x=Country_Code, y=Count))+ylim(0, 350)+theme(axis.text.x = element_text(angle = 90))+labs(y="Number of Medals Won")+
      geom_bar(stat="identity")
  })
}

shinyApp(ui=ui,server=server,
         options=list(port=8080, host="0.0.0.0"))



