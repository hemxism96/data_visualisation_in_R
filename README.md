# The Correlation between Happiness Index and Suicide Rate in Western and Northern European Countries
For people who are living in modern society, pursuing happiness is important. 
The happiness index represents the quality of life and shows how sound is our society. 
However, despite materialistic affluence, fewer people think they are happy and the rate of suicide, an act of abandoning their lives, is rising. 
The happiness index and suicide rate, these barometers indicate society’s well-being. 
Which relation do they have then? 
The happier you are, the lower the suicide rate. 
We generally think this way, the studies and research on happiness index and suicide rate tell us a fact unexpectedly. 
The happier you are, the higher the suicide rate. 
Interested by this irony thing, I proceed with a project about the correlation between the happiness index and suicide rate in western and northern European countries.

## Installation
### Requirements
- R & R studio

Download and install R core language from <https://cran.univ-paris1.fr/>.<br/>
Also, I highly recommend using R Studio Desktop, a powerful open source IDE for R.<br/>
Download and install free version from <https://rstudio.com/products/rstudio/download/>
- Packages

From a R command line, installation of necessary packages

    install.packages('dplyr')
    install.packages('tidyverse')
    install.packages('ggplot2')
    install.packages('corrplot')
    install.packages('shiny')
    install.packages('maps')
    install.packages('mapproj')
    install.packages('gridExtra')
    install.packages('shinydashboard')
    install.packages('DT')
    install.packages('PerformanceAnalytics')
    
### Instructions
#### Using terminal
Clone this project from the command line:<br/>

    $ git clone https://git.esiee.fr/chos/the-correlation-between-happiness-index-and-suicide-rate.git
#### Download directly
click 'download icon'>'zip'<br/>
![download](/uploads/d0c34767694b31c2e057224db7d4693d/download.png)

## Usage

### How to execute the program

#### Using global R, ui.R and server.R
1. Open global.R by R studio
2. click 'run app'

![global](/uploads/1026be79938e717fd270ccd03a58c674/global.png)
#### Using project.Rmd
1. Open project.Rmd by R studio
2. click 'Run'>'Run all'

![rmd](/uploads/a23985c45c6ff9929cbaf8c4a158f6a2/rmd.png)

### How to access to dashboard
You can find the dashboard from <https://hemxism.shinyapps.io/project/?_ga=2.253722825.1162433021.1603635769-964100731.1603635769>

## Development
On this project there are many R files and the data we need exist on data file.<br/>
- global R, ui.R and server.R

To make a dashboard what we will show our project result, we need a shiny app and it is mainly consisted with two components.<br/>

A user interface component (UI): defining the front end of the app. It’s responsible of displaying components on the web page. Components may be inputs (slider, dropdown menus, buttons, check boxes, text, …) or outputs (graphs, tables, text, …). Interactions with input components are detected and may modify outputs via the server component.<br/>
A server component: playing the role of the back end of the app. It’s responsible of preparing data and generating graphs reflecting user interactions.<br/>

Then what is global.R? Think of the global.R file as a file that is being run once before your app starts. <br/>
That means you can use it for all sorts of data processing, running models, and, of course, to load in your data.
- project.Rmd

On this file, explanations of code and how to proceed the project are wrote more detaily.<br/>
Processing the data and making shiny app are dealed by one time.<br/>
If you don't understand the structure of global R, ui.R and server.R, using this file will be easier.
- project.Rproj

You can check all these file in same time.

### Packages
1. tidyverse

The tidyverse is an opinionated collection of R packages designed for data science. <br/>
All packages share an underlying design philosophy, grammar, and data structures. <br/>
As of tidyverse 1.3.0, the following packages are included in the core tidyverse:<br/>
dplyr, ggplot2, tidyr, readr, purrr, nibble, strings, forecast<br/>
<br/>
Among these packages I mainly used dplyr package and ggplot2 package.<br/>
dplyr package: dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges.
- Example
```{r}
df_s = df_s %>% filter(year==2015|year==2016)
```
ggplot2 package: this package helps to create Elegant data visualisations using the grammar of graphics
- Example
```{r}
ggplot() +
    geom_polygon(data = europeMap, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
    geom_point( data=e, aes(x=long, y=lat, size=H_Score, colour=Suicide_Rate))
```

2. corrplot

A graphical display of a correlation matrix or general matrix. <br/>
It also contains some algorithms to do matrix reordering. <br/>
In addition, corrplot is good at details, including choosing color, text labels, color labels, layout, etc.
- Example
```{r}
c_df1 = df1 %>% select('H_Score','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R','Suicide_Rate')
corrplot(cor(c_df1),method='number')
```

3. shiny

Shiny is an R package that makes it easy to build interactive web apps straight fromR. <br/>
You can host standalone apps on a webpage or embed them in R Markdown documents or build dashboards. <br/>
You can also extend your Shiny apps with CSS themes, htmlwidgets, and JavaScript actions.
- Example
```{r}
shinyApp(ui,server)
```

4. maps

This package is for display of maps.
- Example
```{r}
world=map_data(map = 'world', region = '.')

europe=map_data(map='world',region=c("Austria","Belgium","Bulgaria","Croatia","Cyprus",
                   "Czech Rep.","Denmark","Estonia","Finland","France",
                   "Germany","Greece","Hungary","Iceland","Ireland","Italy","Latvia",
                   "Lithuania","Luxembourg","Malta","Netherlands","Norway","Poland",
                   "Portugal","Romania","Slovakia","Slovenia","Spain",
                   "Sweden","Switzerland","UK"))
```

5. mapproj

Map Projections - Converts latitude/longitude into projected coordinates.
- Example
```{r}
output$map=renderPlot({
    ggplot(europeMap,mapping = aes(x = long,y = lat,group = group))+
    coord_map() + 
    geom_polygon(mapping = aes(fill = choice()),colour = 'gray30')+
    my_theme +
    ggtitle(label = input$select) +
    scale_fill_gradient(low='black',high='pink')+theme(legend.position = c(0.9, 0.1),legend.text = element_text(size = 8, face = 'bold'),legend.title = element_text(size = 10, face = 'bold'))
  })
```

6. shinydashboard

Create dashboards with 'Shiny'. <br/>
This package provides a theme on top of 'Shiny', making it easy to create attractive dashboards.
- Example
```{r}
sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Freedom", tabName = "freedom", icon = icon("th")),
    menuItem("Weather", tabName = "weather", icon = icon("th")),
    menuItem("Unemployment", tabName = "unemployment", icon = icon("th"))
```

7. DT

The R package DT provides an R interface to the JavaScript library DataTables. <br/>
R data objects (matrices or data frames) can be displayed as tables on HTML pages, and DataTables provides filtering, pagination, sorting, and many other features in the tables.
- Example
```{r}
box(
            title='Suicide rate data table',
            status = 'primary',
            # bring a data table 'suicide'
            DT::dataTableOutput("suicide")
          )
```

8. PerformanceAnalytics

Collection of econometric functions for performance and risk analysis. 
- Example
```{r}
output$f_cor=renderPlot({
    chart.Correlation(c_free, histogram=TRUE, pch=19)
  })
```

9. gridExtra

Provides a number of user-level functions to work with grid.<br/>
graphics, notably to arrange multiple grid-based plots on a page, and draw tables.
- Example
```{r}
grid.arrange(p1,p2,nrow=1)
```
### Working Environment
R version 3.6.1 

## Analysis Report
### The goal of Project
Check a presence of correlation between happiness index and suicide and verify how this relevance can be possible

### Procedure
#### Verify the correlation between the happiness index and suicide rate
Histogram of the happiness index and suicide rate
```{r}
p1=ggplot(df1, aes(x=H_Score))+geom_histogram(fill='pink',colour="black", bins = 20)+scale_x_continuous(breaks = c(5,6,7,8))
p2=ggplot(df1, aes(x=Suicide_Rate))+geom_histogram(fill='blue',colour="black", bins = 20)+scale_x_continuous(breaks = c(8,12,16))

grid.arrange(p1,p2,nrow=1)
```
![hist_H_S](/uploads/da4638e15c3963acefddb5f4580624a0/hist_H_S.png)<br/>
Dot graph
```{r}
p=ggplot(df1,aes(x=H_Score,y=Suicide_Rate,fill=Country)) + 
    geom_point(aes(color=Country))+ 
    ggtitle("The relevance between Happiness index and Suicide rate") +xlab("Happiness")
p
```
![1](/uploads/98ce25b49e6c95bccb21939f58951681/1.png)<br/>
Bubble graph<br/>
![bubble](/uploads/613217fd459bcd9b2265a534930b14ce/bubble.png)<br/>
Correlation test
```{r}
attach(df1)
cor.test(H_Score,Suicide_Rate)
```
![1_verify](/uploads/0c3887b5251c2592b466222b6b6cf959/1_verify.png)<br/>
The p-value is 0.004882 and the correlation coefficient is 0.684457.<br/>
With these numbers and the graph, we can figure out there's a positive correlation between happiness and suicide rate in Western and Northern European countries.<br/>
But why? How is this relevance showed?

#### Find the main factor that affects this correlation
Check happiness index and suicide index, and freedom index by country on European map<br/>
![map_h](/uploads/a8cd6ee2ae2dd6922f3423b6b991c3c1/map_h.png)
![map_s](/uploads/e0ba8a3fc730b55c37c122786319bf97/map_s.png)
![map_f](/uploads/345db118f849adb2b4f058aa47a0b487/map_f.png)<br/>
To check this relevance, let's draw the correlation matrix plot of the data frame.<br/>
```{r}
c_df1 = df1 %>% select('H_Score','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R','Suicide_Rate')
corrplot(cor(c_df1),method='number')
```
![2](/uploads/73e7231c97cd0399cc166c7a309c5626/2.png)<br/>
When we see this plot, we can check the element of Freedom has a high correlation with both Suicide Rate and Happiness.<br/>
By this fact, I suppose the elements of freedom lead to the relevance of Suicide Rate and Happiness.

#### The factor of freedom

1. First hypothetical factor of freedom is working hours.

Check the relation between freedom index and working hours.
```{r}
attach(work_h)
plot(Freedom~Working_hour)
cor.test(Freedom,Working_hour)
```
![free_work](/uploads/f342b6ffc1ff0937b45821a843d8e30c/free_work.png)<br/>
The p-value is 1.219e-05 and the correlation coefficient is -0.92948.<br/>
What about with Happiness and Suicide rate?
```{r}
c_work_h=work_h[,-1]
corrplot(cor(c_work_h),method='number')
```
![3](/uploads/b18728825037d2594555daa6e5d7704c/3.png)<br/>
It means working hours and (freedom, happiness score, suicide rate) have a negative correlation and it can be proof that working time is a factor of freedom, and working time affects the correlation between happiness and suicide rate.

2. The elements of freedom

This time, we will consider elements that can be related to freedom.<br/>
'Rule of law','Religious freedom','Freedom to associate and assemble with peaceful individuals or organizations','Freedom of expression','Identity'.<br/>
Check there's a correlation with (freedom, happiness score, suicide rate)
```{r}
c_df=freedom[,-1]
corrplot(cor(c_df),method='number')
```
![4](/uploads/86bdf535c4122713757bb66e079eed21/4.png)<br/>
Among five factors, Rule, Expression, and Identity have a significant correlation with freedom and also have a positive with Happiness and Suicide rate. <br/>
It can be proof that these three factors are related to freedom and affect the correlation between happiness and suicide rate.<br/>

Until now we verified freedom and the elements that are related to freedom affect the correlation of happiness and suicide.<br/>
What about the factor that is not related to freedom? It will have the same correlation with the happiness index and Suicide?

#### The other factor
1. Weather data

Check there's a correlation with (freedom, happiness score, suicide rate)
```{r}
c_weather=weather[,-1]
corrplot(cor(c_weather),method='number')
```
![5](/uploads/cf4a5b96574e3f146955117c60077df2/5.png)<br/>
It means weather(average temperature) and (freedom, happiness score, suicide rate) have a negative correlation and it can be proof that weather(average temperature) affects the correlation between happiness and suicide rate.

2. Close relationship ratio

Check there's a correlation with (freedom, happiness score, suicide rate)
```{r}
c_relations=relations[,-1]
corrplot(cor(c_relations),method='number')
```
![6](/uploads/0c7683c4487c6bcde9e695591fc41c5f/6.png)<br/>
The correlation coefficient of a close relationship with happiness, Suicide rate, and freedom is smaller than 0.3. <br/>
This number tells us we can't find any correlation between them. <br/>
By this verification, we can know if something does not correlate with happiness, the correlation with suicide does not exist and it's proof of the relevance of the happiness index and suicide rate.

3. Unemployment rate

Check there's a correlation with (freedom, happiness score, suicide rate)
```{r}
c_unemployment=unemployment[,-1]
corrplot(cor(c_unemployment),method='number')
```
![7](/uploads/dd403c1ad98b337b045daa23d90e6361/7.png)<br/>
It means the unemployment rate and (freedom, happiness score, suicide rate) have a negative correlation and it can prove that the unemployment rate affects the correlation between happiness and suicide rate.

### Conclusion
The happiness index and suicide rate have a positive correlation.<br/>
Many factors of our life have significant relevance with this correlation and prove the relation.

### Data resources
c_code.csv: <https://www.kaggle.com/juanumusic/countries-iso-codes><br/>
close_relations_2015.csv: <https://www.kaggle.com/roshansharma/europe-datasets><br/>
happiness_2015.csv: <https://www.kaggle.com/unsdsn/world-happiness><br/>
happiness_2016.csv: <https://www.kaggle.com/unsdsn/world-happiness><br/>
hfi_cc_2018.csv: <https://www.kaggle.com/gsutters/the-human-freedom-index><br/>
suicide.csv: <https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016><br/>
unemployment.csv: <https://data.oecd.org/unemp/unemployment-rate.htm><br/>
weather.csv: <https://www.kaggle.com/roshansharma/europe-datasets><br/>
work.csv: <https://data.oecd.org/emp/hours-worked.htm>