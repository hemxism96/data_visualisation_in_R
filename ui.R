#radioButtons option
check_list=c('Happiness index','Suicide rate','Freedom')
freedom_factor=c('Working hour','Rule of law','Freedom of expression','Identity')

ui = dashboardPage(

  dashboardHeader(title="The Relevance between Happiness and Suicide", titleWidth = 450),

  #menage sidebar
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Freedom", tabName = "freedom", icon = icon("th")),
      menuItem("Weather", tabName = "weather", icon = icon("th")),
      menuItem("Unemployment", tabName = "unemployment", icon = icon("th"))
    )
  ),

  dashboardBody(
    #control sidebar font size
    tags$head(
      tags$style(HTML(".main-sidebar { font-size: 20px; }"))
    ),
    tabItems(
      # First tab content
      tabItem(
        #relate with sidebarMenu by tabName
        tabName = "dashboard",
        #To show the dashboard properly at first, we need to make a tap active
        class='active',
        #title
        h2("The Correlation between Happiness Index and Suicide Rate in Western and Northern European Countries"),
        # First fluidRow
        fluidRow(
          # box1
          box(
            title='Map of Europe',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            # bring a plot named 'bubble map'
            plotOutput('bubble_map')
          ),
          # box2
          box(
            title='Correlation between happiness and suicide',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            # bring a plot named 'dot'
            plotOutput('dot')
          )
        ),
        # Second fluidRow
        fluidRow(
          # box1
          box(
            title='Happiness Index higtogram',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #range is from 10 to 30 and default value is 30
            #the choice will be stored on slider1
            sliderInput("slider1", "histogram bins size:", 10, 30, 30),
            # bring a plot named 'h_hist'
            plotOutput('h_hist')
          ),
          # box2
          box(
            title='Suicide rate histogram',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #range is from 10 to 30 and default value is 30
            #the choice will be stored on slider2
            sliderInput("slider2", "histogram bins size:", 10, 30, 30),
            # bring a plot named 's_hist'
            plotOutput('s_hist')
          )
        ),
        # Third fluidRow
        fluidRow(
          # box1
          box(
            title='Happiness Index data table',
            status = 'primary',
            #bring a data table 'happiness'
            DT::dataTableOutput("happiness")
          ),
          # box2
          box(
            title='Suicide rate data table',
            status = 'primary',
            # bring a data table 'suicide'
            DT::dataTableOutput("suicide")
          )
        )
      ),

      # Second tab content
      tabItem(
        #relate with sidebarMenu by tabName
        tabName = "freedom",
        #title
        h2("Correlation of freedom with happiness index and suicide rate"),
        # first fluidRox
        fluidRow(
          # box1
          box(
            title='Correlation Analysis',
            status = 'primary',
            #explanation of histogram
            '[Happiness Index~Freedom] Correlation Coefficient: 0.96',
            br(),
            '[Suicide Rate~Freedom] Correlation Coefficient: 0.72',
            solidHeader = TRUE,
            collapsible = TRUE,
            # bring a plot named 'f_cor'
            plotOutput('f_cor')
          ),
          # box2
          box(
            title='Compare by country',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #there are reactive buttons what user can choose and the result of this choice will be reflected on server
            #the choice will be stored on select
            radioButtons("select", "Which factor you want to compare?", check_list),
            #bring a plot named 'map'
            plotOutput('map')
          )
        ),
        # Second fluidRox
        fluidRow(
          # box1
          box(
            title='Elements related with Freedom',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #there are reactive buttons what user can choose and the result of this choice will be reflected on server
            #the choice will be stored on ff
            radioButtons("ff", "Which freedom factor you want to check?", freedom_factor)
          ),
          # box2
          box(
            #bring a plot named 'ff1'
            plotOutput('ff1'),
            #bring a plot named 'ff2'
            plotOutput('ff2')
          )
        )
      ),
      # Third tab content
      tabItem(
        #relate with sidebarMenu by tabName
        tabName = "weather",
        #title
        h2("What about the factor who is not related with freedom? It will have same correlation with Happiness index and Suicide?: Weather"),
        # First fluidRow
        fluidRow(
          # box1
          box(
            title='Average temperature higtogram',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #bring a plot named 'w_hist'
            plotOutput('w_hist')
          ),
          # box2
          box(
            title='Average temperature correlation analysis',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #plot explanation
            'Temperature and (happiness score,suicide rate) have negative correlation',
            #bring a plot named 'w_cor'
            plotOutput('w_cor')
          )
        ),
        # Second fluidRow
        fluidRow(
          # box1
          box(
            title='Average temperature and Happiness index bar graph',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #bring a plot named 'w_bar_h'
            plotOutput('w_bar_h')
          ),
          box(
            title='Average temperature and Suicide Rate bar graph',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #bring a plot named 'w_bar_s'
            plotOutput('w_bar_s')
          )
        )
      ),
      # Fourth tab content
      tabItem(
        #relate with sidebarMenu by tabName
        tabName = "unemployment",
        #title
        h2("What about the factor who is not related with freedom? It will have same correlation with Happiness index and Suicide?: Unemployement"),
        # First fluidRow
        fluidRow(
          # box1
          box(
            title='Unemployment rate higtogram',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #bring a plot named 'u_hist'
            plotOutput('u_hist')
          ),
          # box2
          box(
            title='Unemployment rate correlation analysis',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #plot explanation
            'Unemployment and (happiness score,suicide rate) have negative correlation',
            #bring a plot named 'u_cor'
            plotOutput('u_cor')
          )
        ),
        # Second fluidRow
        fluidRow(
          # box1
          box(
            title='Unemployment rate and Happiness index bar graph',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #bring a plot named 'u_bar_h'
            plotOutput('u_bar_h')
          ),
          # box2
          box(
            title='Unemployment rate and Suicide Rate bar graph',
            status = 'primary',
            solidHeader = TRUE,
            collapsible = TRUE,
            #bring a plot named u_bar_h
            plotOutput('u_bar_s')
          )
        )
      )
    )
  )
)
