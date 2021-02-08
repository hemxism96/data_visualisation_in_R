#Bring library

library(tidyverse)
library(corrplot)
library(shiny)
library(maps)
library(mapproj)
library(shinydashboard)
library(DT)
library(PerformanceAnalytics)
library(gridExtra)


#Bring Data
#df_s is suicide data.
#df_h_1 is 2015 happiness data and df_h_2 is 2016 happiness data.
df_s=read.csv("./data/suicide.csv",header = TRUE)
df_h_1=read.csv("./data/happiness_2015.csv",header = TRUE)
df_h_2=read.csv("./data/happiness_2016.csv",header = TRUE)

#[Suicide data] pre-processing
#Duplicated years with happiness data are only 2015 and 2016, so filter data frame for these years.
df_s = df_s %>% filter(year==2015|year==2016)

#Change column names to easy one.
names(df_s)=c('Country','Year','Sex','Age','Count_S','Population','S_Rate','CY','HDI','GDP_Year','GDP_Capita','Generation')

#Select only meaningful columns,group by country and summarize by suicide rate.
df_s = df_s %>% select('Country','Year','Sex','Age','Count_S','Population','S_Rate','GDP_Capita') %>% group_by(Country,Year) %>% summarise(Suicide_Rate=mean(S_Rate,na.rm = TRUE))
#We got simple df_s now.

#Separate df_s by year because df_s is combined 2015 data and 2016 data.
df_s1 = df_s %>% filter(Year==2015)
df_s2 = df_s %>% filter(Year==2016)
#df_s1 is suicide data for 2015, df_s2 is suicide data for 2016.

#[Happiness data] pre-processing

#Change column names to easy one.
names(df_h_1)=c('Country','Region','H_Rank','H_Score','S_Error','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R')
names(df_h_2)=c('Country','Region','H_Rank','H_Score','L_confidence','U_confidence','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R')

#Select only meaningful columns.
df_h_1 = df_h_1 %>% select('Country','Region','H_Rank','H_Score','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R')
df_h_2 = df_h_2 %>% select('Country','Region','H_Rank','H_Score','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R')


#[Merge happiness data with suicide data per year]
#If there's no suicide data, this data won't be considered and disappeared.
#df1 is 2015 data and df2 is 2016 data.
df1=merge(df_h_1,df_s1,by=c('Country'))
df2=merge(df_h_2,df_s2,by=c('Country'))

#Restrict the countries to Western and Northern European country only.
#refer to.These data combined Western Europe and Northern Europe to just Western Europe and I will keep this name.
df1 = df1 %>% filter(Region=='Western Europe')
df2 = df2 %>% filter(Region=='Western Europe')

#We wanted to use 2016 data but the sample of 2016 data is not enough for analyze and we will ignore them.
#Also,when we check country of df1 there's not proper country : Cyprus and Malta
#Take them off from df1
df1 = df1[!(df1$Country == "Cyprus"|df1$Country == "Malta"), ]

#-----------Basic Data processing is over-----------

#[2015] Check relation between happiness index and suicide rate
attach(df1)
cor.test(H_Score,Suicide_Rate)
#The value of p-value is 0.004882 and correlation coefficient is 0.684457.

#Dot plots
p=ggplot(df1,aes(x=H_Score,y=Suicide_Rate,fill=Country)) + geom_point(aes(color=Country))+ ggtitle("The relevance between Happiness index and Suicide rate") +xlab("Happiness")

#Histogram
p1=ggplot(df1, aes(x=H_Score))+geom_histogram(fill='pink',colour="black", bins = 20)+scale_x_continuous(breaks = c(5,6,7,8))
p2=ggplot(df1, aes(x=Suicide_Rate))+geom_histogram(fill='blue',colour="black", bins = 20)+scale_x_continuous(breaks = c(8,12,16))
grid.arrange(p1,p2,nrow=1)

#With these numbers and graph, we can figure it out there's positive correlation between happiness and suicide rate in Western and Northern European countries.
#But why? How come this relevance is showed?
#To check this relevance, let's draw the correlation matrix plot of df1.
#Select the number columns. (or we can't use corrplot)
c_df1 = df1 %>% select('H_Score','GDP_Capita','Family','H_Expect','Freedom','Trust_G','Generosity','Dystopia_R','Suicide_Rate')
corrplot(cor(c_df1),method='number')

#When we see the this plot, we can check the element of Freedom has high correlation with both Suicide Rate and Happiness.
#By this fact, I suppose the elements about freedom lead to the relevance of Suicide Rate and Happiness.

#To prove this correlation, I will use 'df' data frame who has only three columns 'H_Score','Freedom','Suicide_Rate'.
df = df1 %>% select('Country','H_Score','Freedom','Suicide_Rate')

#First hypothetical factor of freedom is working hour.
#I get this data on 'work'.
#I restrict these data to 2015 year and choose only Location(Country code) and Value(Working hour) columns.
#After that, change these columns names properly.
work=read.csv("./data/work.csv",header=TRUE)
work = work %>% subset(TIME==2015,select = c('LOCATION','Value'))
names(work)=c('code','Working_hour')
work

#I want to merge work with df now but there's no Country name on work df.
#To add country name according to country code, we need a data frame who relates country name with country code.
c_code=read.csv("./data/c_code.csv",header = TRUE)
c_code = c_code %>% select('English.short.name.lower.case','Alpha.3.code')
names(c_code)=c('Country','code')

#Merge c_code and work and delete country code column what we don't need.
work=merge(c_code,work)
work=work[-1]

#Merge this work_h and df and check working hour's correlation with df columns.
work_h=merge(df,work,by='Country')
work_h

#Check relation between freedom index and working hour.
attach(work_h)
plot(Freedom~Working_hour)
cor.test(Freedom,Working_hour)
#The p-value is 1.219e-05 and correlation coefficient is -0.92948 .

#What about with Happiness and Suicide rate?
#Select the number columns. (or we can't use corrplot)
c_work_h=work_h[,-1]
corrplot(cor(c_work_h),method='number')

#This time, we will consider elements who can be related with freedom.
#We bring the data,filter it (2015 year data), select the columns we are interested in and change these name clearly.
freedom=read.csv("./data/hfi_cc_2018.csv",header=TRUE)
freedom = freedom %>% subset(year==2015,select = c('countries','pf_rol_civil','pf_rol','pf_religion','pf_association','pf_expression','pf_identity'))
names(freedom)=c('Country','Civil_justice','Rule','Religion','Association','Expression','Identity')

#Merge this freedom and df.
freedom=merge(df,freedom,by='Country')

#Unfortunately, There's NA value on civil justice and we will skip this column.
freedom=freedom[,-5]

#Check there's correlation with df columns and the other elements.
#Select the number columns. (or we can't use corrplot)
c_df=freedom[,-1]
corrplot(cor(c_df),method='number')

#[Weather]
#Bring data and select the columns what we are interested in.
#Change column names clearly.
weather=read.csv("./data/weather.csv",header=TRUE)
weather = weather %>% select('country','avg_temp')
names(weather)=c('Country','Avg_temp')

#Merge weather data with df(happiness,suicide and freedom)
weather=merge(df,weather,by='Country')
weather

#Check there's correlation with df columns and the weather.
#Select the number columns. (or we can't use corrplot)
c_weather=weather[,-1]
corrplot(cor(c_weather),method='number')

#[Close Relationship ratio]
#Bring data and select the columns what we are interested in.
#Change column names clearly.
relations=read.csv("./data/close_relations_2015.csv",header=TRUE)
names(relations)=c('Country','Close_Relations')

#Merge relationships data with df(happiness,suicide and freedom)
relations=merge(df,relations,by='Country')

#Check there's correlation with df columns and the relationship.
#Select the number columns. (or we can't use corrplot)
c_relations=relations[,-1]
corrplot(cor(c_relations),method='number')

#[Unemployment rate]
#Bring data and select the columns what we are interested in.
#Change column names clearly.
unemployment=read.csv("./data/unemployment.csv",header=TRUE)
unemployment = unemployment %>% select('LOCATION','Value')
names(unemployment)=c('code','Unemployment_Rate')

#I want to merge unemployment with df directly but there's no Country name on unemployment df.
#To add country name according to country code, we will use c_code df again what we used before.
unemployment=merge(c_code,unemployment,by='code')

#Delete country code column because we don't need anymore.
unemployment=unemployment[,-1]

#Merge unemployment data with df(happiness,suicide and freedom)
unemployment=merge(df,unemployment,by='Country')

#Check there's correlation with df columns and the unemployment.
#Select the number columns. (or we can't use corrplot)
c_unemployment=unemployment[,-1]
corrplot(cor(c_unemployment),method='number')

#-----------Analysis is over-----------

#[Map]
#I want to show a map who contains the information.
#For that, we will make a map of Europe first.
#Brings map info and restrict it to European countries.
world=map_data(map = 'world', region = '.')
europe=map_data(map='world',region=c("Austria","Belgium","Bulgaria","Croatia","Cyprus",
                                     "Czech Rep.","Denmark","Estonia","Finland","France",
                                     "Germany","Greece","Hungary","Iceland","Ireland","Italy","Latvia",
                                     "Lithuania","Luxembourg","Malta","Netherlands","Norway","Poland",
                                     "Portugal","Romania","Slovakia","Slovenia","Spain",
                                     "Sweden","Switzerland","UK"))

#To merge map info with df, we will change somethings.
#Change df's country column to region.
#Change United Kingdom name to UK because it is stored by 'UK' in map info.
colnames(df)[1]='region'
df$region=gsub("United Kingdom", "UK", df$region)

#Right join df and europe(map) by region.
#I do right join to draw complete map although there is no data on df.
europeMap=right_join(df,europe,by='region')
europeMap=europeMap[order(europeMap$region,europeMap$order),]

#ps. I made my theme for drawing a map more interesting.
my_theme <- theme(panel.background = element_blank(),
                  axis.title = element_blank(),
                  axis.text = element_blank(),
                  axis.ticks = element_blank(),
                  plot.title = element_text(hjust = 0.5,face = 'bold'))

#Let's make a dashboard about this analysis.
#First of all, organize data frame to use on dashboard.
happiness = df1 %>% select('Country','H_Score')
suicide = df1 %>% select('Country','Suicide_Rate')
c_free=freedom %>% select('H_Score','Suicide_Rate','Freedom')
work_h = work_h %>% select(Country,Working_hour)
freedom = freedom %>% select(Country,H_Score,Suicide_Rate,Rule,Expression,Identity)
free=merge(work_h,freedom)
cc_weather=c_weather %>% select(H_Score,Suicide_Rate,Avg_temp)
cc_unemployment=c_unemployment %>% select (H_Score,Suicide_Rate,Unemployment_Rate)
e=europeMap%>%group_by(region,H_Score,Suicide_Rate) %>% summarize(lat=mean(lat),long=mean(long))
