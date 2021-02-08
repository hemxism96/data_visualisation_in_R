server = function(input, output) {
  #select what ui gets from user as a input
  #choice is changed depends on select
  #if select is happiness index, europeMap$H_Socre will be stored at choice
  choice = reactive({
    switch(input$select,
           'Happiness index' = europeMap$H_Score,
           'Suicide rate' = europeMap$Suicide_Rate,
           'Freedom' = europeMap$Freedom)
  })


  #ff what ui gets from user as a input
  #factor is changed depends on ff
  #if ff is Working hour, free$Working_hour will be stored at factor
  factor = reactive({
    switch(input$ff,
           'Working hour'=free$Working_hour,
           'Rule of law'=free$Rule,
           'Freedom of expression'=free$Expression,
           'Identity'=free$Identity
    )
  })

  #plot named bubble_map
  #return a ggplot on the place that bubble_map was called
  output$bubble_map=renderPlot({
    #on the map, draw bubbles
    #size is changed by H_Score(happiness index)
    #color is changed by Suicide_Rate
    ggplot() +
      geom_polygon(data = europeMap, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
      geom_point( data=e, aes(x=long, y=lat, size=H_Score, colour=Suicide_Rate))
  })

  #plot named dot
  #return a ggplot on the place that dot was called
  output$dot=renderPlot({
    ggplot(df1,aes(x=H_Score,y=Suicide_Rate,fill=Country)) +
      geom_point(aes(color=Country),size=4)+xlab("Happiness index")+ylab("Suicide rate")
  })

  #plot named h_hist
  #return a ggplot on the place that h_hist was called
  output$h_hist=renderPlot({
    ggplot(happiness, aes(x=H_Score)) +
      geom_histogram(fill='blue',  colour="black", bins = input$slider1)+xlab("Happiness index")
  })

  #plot named s_hist
  #return a ggplot on the place that s_hist was called
  output$s_hist=renderPlot({
    ggplot(suicide, aes(x=Suicide_Rate)) +
      geom_histogram(fill='orange',  colour="black", bins = input$slider2)+xlab("Suicide rate")
  })

  #data table named happiness
  #return a data table on the place that happiness was called
  output$happiness = DT::renderDataTable({
    happiness
  })

  #data table named bubble_map
  #return a data table on the place that suicide was called
  output$suicide = DT::renderDataTable({
    suicide
  })

  #plot named f_cor
  #return a correlation chart on the place that f_cor was called
  output$f_cor=renderPlot({
    chart.Correlation(c_free, histogram=TRUE, pch=19)
  })

  #plot named map
  #return a ggplot on the place that map was called
  #this time the input$selct&choice will be reflected when gglot is drawed
  output$map=renderPlot({
    #draw europeMap
    ggplot(europeMap,mapping = aes(x = long,y = lat,group = group))+
      #modulated the map balance
      coord_map() +
      #the color of county is changed depends on choice's value
      geom_polygon(mapping = aes(fill = choice()),colour = 'gray30')+
      #apply my_them on ggplot
      my_theme +
      #title
      ggtitle(label = input$select) +
      #chose extra things
      scale_fill_gradient(low='black',high='pink')+theme(legend.position = c(0.9, 0.1),legend.text = element_text(size = 8, face = 'bold'),legend.title = element_text(size = 10, face = 'bold'))
  })

  #plot named ff1
  #return a ggplot on the place that ff1 was called
  output$ff1=renderPlot({
    ggplot(free,aes(x=H_Score,y=factor()))+
      geom_line(stat='identity',color='blue')+xlab("Happiness index")+ylab(input$ff)
  })

  #plot named ff2
  #return a ggplot on the place that ff2 was called
  output$ff2=renderPlot({
    ggplot(free,aes(x=Suicide_Rate,y=factor()))+
      geom_line(stat='identity',color='orange')+xlab("Suicide rate")+ylab(input$ff)
  })

  #plot named w_hist
  #return a ggplot on the place that w_hist was called
  output$w_hist=renderPlot({
    ggplot(c_weather, aes(x=Avg_temp)) +
      geom_histogram(fill='pink',  colour="black", bins = 30)+xlab("Average temperature")
  })

  #plot named w_cor
  #return a correlation plot on the place that w_cor was called
  output$w_cor=renderPlot({
    corrplot(cor(cc_weather),method='number')
  })

  #plot named w_bar_h
  #return a ggplot on the place that w_bar_h was called
  output$w_bar_h=renderPlot({
    ggplot(cc_weather,aes(x=Avg_temp,y=H_Score))+
      geom_bar(stat='identity',color='blue')+xlab("Average temperature")+ylab("Happiness index")
  })

  #plot named w_bar_s
  #return a ggplot on the place that w_bar_s was called
  output$w_bar_s=renderPlot({
    ggplot(cc_weather,aes(x=Avg_temp,y=Suicide_Rate))+
      geom_bar(stat='identity',color='orange')+xlab("Average temperature")+ylab("Suicide rate")
  })

  #plot named u_hist
  #return a ggplot on the place that u_hist was called
  output$u_hist=renderPlot({
    ggplot(cc_unemployment, aes(x=Unemployment_Rate)) +
      geom_histogram(fill='pink',  colour="black", bins = 30)+xlab("Unemployment rate")
  })

  #plot named u_cor
  #return a correlation plot on the place that u_cor was called
  output$u_cor=renderPlot({
    corrplot(cor(cc_unemployment),method='number')
  })

  #plot named u_bar_h
  #return a ggplot on the place that u_bar_h was called
  output$u_bar_h=renderPlot({
    ggplot(cc_unemployment,aes(x=Unemployment_Rate,y=H_Score))+
      geom_bar(stat='identity',color='blue')+xlab("Unemployment rate")+ylab("Happiness index")
  })

  #plot named u_bar_s
  #return a ggplot on the place that u_bar_s was called
  output$u_bar_s=renderPlot({
    ggplot(cc_unemployment,aes(x=Unemployment_Rate,y=Suicide_Rate))+
      geom_bar(stat='identity',color='orange')+xlab("Unemployment rate")+ylab("Suicide Rate")
  })
}
