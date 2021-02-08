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

## Usage

### How to execute the program

#### Using global R, ui.R and server.R
1. Open global.R by R studio
2. click 'run app'

#### Using project.Rmd
1. Open project.Rmd by R studio
2. click 'Run'>'Run all'

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
