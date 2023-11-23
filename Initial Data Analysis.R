lakedata=read.csv("RID_196_Chem_L375.csv")
summary(lakedata)
library(tidyverse)
View(lakedata)

#Looking at the timeseries for all six variables we chose
target <- c("TDP", "TDN","PARTP","PARTN","PARTC","SO4")
significant_variables=filter(lakedata, characteristic_name %in% target)
average_sigvariables_by_year=significant_variables%>%
  group_by(year,characteristic_name)%>%
  summarise(Mean=mean(result_value))
ggplot(average_sigvariables_by_year,aes(x=year,y=Mean))+
  geom_line()+ geom_point()+geom_vline(xintercept = 2002,color = "blue", size=1.5)+geom_vline(xintercept = 2008,  color = "blue", size=1.5)+facet_wrap(vars(characteristic_name),scales = "free_y")

for (i in target) {
  plots=generalplotfunction(i)
}
#Function for making plot with just name
generalplotfunction=function(z){
  data0=lakedata%>%
    filter(characteristic_name==z)%>%
    group_by(year)%>%
    summarise(mean=mean(result_value))
graph=ggplot(data0,aes(x=year,y=mean))+
    geom_line()+ geom_point()+geom_vline(xintercept = 2002,color = "blue", size=1.5)+geom_vline(xintercept = 2008,  color = "blue", size=1.5)+labs(title=z)
return(graph)
}

library(ggpubr)
ggarrange(a, b, c,d,e,f+ rremove("x.text"), 
          ncol = 2, nrow = 3)
a=generalplotfunction("PARTP")
b=generalplotfunction("PARTN")
c=generalplotfunction("PARTC")
d=generalplotfunction("TDP")
e=generalplotfunction("SO4")
f=generalplotfunction("TDN")

#Trying to look at the the distribution

summary(lakedata)

histogramfunction= function(charateristic)
{
  datafunc=lakedata%>%
    filter(characteristic_name==charateristic)%>%
    select(result_value)
  return(hist(datafunc$result_value,main = charateristic))
}

par(mfrow = c(2, 2))
histogramfunction("PARTN")
histogramfunction("PARTP")
histogramfunction("PARTC")
histogramfunction("SO4")







PARTPDATA=filter(lakedata, characteristic_name=="PARTP")


average_sigvariables_by_year=PARTPDATA%>%
  group_by(year,characteristic_name)%>%
  summarise(Mean=mean(result_value))

PARTPDATA <- PARTPDATA %>% mutate(yearfactor = as.factor(year))

library(lme4)
library(lmerTest)
library(MuMIn)

#Models with all data 


p_data_with_treatment=read_csv("output1.csv")

summary(aov(result_value~Treatment,data = p_data_with_treatment))
summary(glm(result_value~Treatment,data = p_data_with_treatment))
P_model_MM <- lmer(result_value~Treatment+(1|as.factor(p_data_with_treatment$year)), data=p_data_with_treatment, REML=FALSE)
summary(P_model_MM)
r.squaredLR(P_model_MM)

ggplot(data=p_data_with_treatment, aes(x=Treatment,y=result_value))+
  geom_boxplot()


#Models with all data 
#For N
View(lakedata)

N_data=lakedata%>%
  filter(characteristic_name=="PARTN")
N_BF=N_data
aov_N=aov(result_value~Treatment,data = N_data)
summary.aov(aov(result_value~Treatment,data = N_data))
summary(glm(result_value~Treatment,data = N_data))
glm_N=glm(result_value~Treatment,data = N_data)
N_model_MM <- lmer(result_value~Treatment+(1|as.factor(N_data$year)), data=N_data, REML=FALSE)
summary(N_model_MM)

AICc(N_model_MM, aov_N,glm_N)

  
#For P
P_data=lakedata%>%
  filter(characteristic_name=="PARTP")
  #select(result_value)


aov_p=aov(result_value~Treatment,data = P_data)
summary.aov(aov(result_value~Treatment,data = P_data))
summary(glm(result_value~Treatment,data = P_data))
glm_P=glm(result_value~Treatment,data = P_data)
newP_model_MM <- lmer(result_value~Treatment+(1|as.factor(P_data$year)), data=P_data, REML=FALSE)
summary(newP_model_MM)

AICc(newP_model_MM, aov_p,glm_P,model,model3,modelint)

#For C
C_data=lakedata%>%
  filter(characteristic_name=="PARTC")
aov_C=aov(result_value~Treatment,data = C_data)
summary.aov(aov(result_value~Treatment,data = C_data))
glm_C=glm(result_value~Treatment,data = C_data)
summary(glm(result_value~Treatment,data = C_data))
C_model_MM <- lmer(result_value~Treatment+(1|as.factor(C_data$year)), data=C_data, REML=FALSE)
summary(C_model_MM)

AICc(C_model_MM, aov_C,glm_C)


#Forecasting

library(forecast)
#Has all values no gaps filled in 

P_data2=lakedata%>%
  filter(characteristic_name=="PARTP")%>%
  select(result_value)

model=auto.arima(P_data2) 
summary(model)
forecast_data <- forecast(model, 20) 

print(forecast_data)

a=plot(forecast_data, main = "forecasting_data for rain_ts")

#Averaged
P_data3=lakedata%>%
  filter(characteristic_name=="PARTP")%>%
  group_by(year)%>%
  summarise(mean=mean(result_value))%>%
  select(mean)

model3=auto.arima(P_data3) 
summary(model3)
forecast_data3 <- forecast(model3, 20) 


print(forecast_data3)


b=plot(forecast_data3, main = "forecasting_data for rain_ts")

#Adding in the missing values
#Forecast with missing values

model4=auto.arima(added_data_P) 
summary(model4)
forecast_data4 <- forecast(model4, 20) 


print(forecast_data4)


c=plot(forecast_data4, main = "forecasting_data for rain_ts")

par(mfrow = c(2, 2))
plot(forecast_data, main = "All Data Forecasted")
plot(forecast_data3, main = "Averages Forecasted")
plot(forecast_data4, main = "Averaged with missing values Forecasted")

#Forecasting at different stages
#Before
P_datab=lakedata%>%
  filter(characteristic_name=="PARTP")%>%
  filter(year<"2003")%>%
  select(result_value)

modelb=auto.arima(P_datab) 
summary(modelb)
forecast_datab <- forecast(modelb, 47) 


print(forecast_datab)


plot(forecast_datab, main = "Before")

#During
P_datad=lakedata%>%
  filter(characteristic_name=="PARTP")%>%
  filter(year>"2002")%>%
  filter(year<"2008")%>%
  select(result_value)

modeld=auto.arima(P_datad) 
summary(modeld)
forecast_datad <- forecast(modeld, 42) 


print(forecast_datad)


plot(forecast_datad, main = "During")

#After
P_dataa=lakedata%>%
  filter(characteristic_name=="PARTP")%>%
  filter(year>"2007")%>%
  select(result_value)

modela=auto.arima(P_dataa) 
summary(modela)
forecast_dataa <- forecast(modela, 28) 


print(forecast_dataa)


plot(forecast_dataa, main = "After")

#Before +During

P_datadb=lakedata%>%
  filter(characteristic_name=="PARTP")%>%
  filter(year<"2007")%>%
  select(result_value)

modeldb=auto.arima(P_datadb) 
summary(modeldb)
forecast_dataa <- forecast(modeldb, 43) 


print(forecast_datadb)


plot(forecast_datadb, main = "Before +During")



par(mfrow = c(2, 2))
plot(forecast_data, main = "All Data Forecasted")
plot(forecast_data3, main = "Averages Forecasted")
plot(forecast_data4, main = "Averaged with interpolation")
par(mfrow = c(2, 2))
plot(forecast_datab, main = "Before")
plot(forecast_datad, main = "During")
plot(forecast_dataa, main = "After")
plot(forecast_dataa, main = "Before +During")



#Function for different datasets
alldataforecastfunction=function(y){
  data1=lakedata%>%
    filter(characteristic_name==y)%>%
    select(result_value)
  model3=auto.arima(data1) 
  summary(model3)
  forecast_data3 <- forecast(model3, 20) 
  plot=plot(forecast_data3, main = y)
  return(plot)
}
par(mfrow = c(2, 2))
alldataforecastfunction("PARTN")
alldataforecastfunction("PARTP")
alldataforecastfunction("PARTC")
alldataforecastfunction("SO4")
par(mfrow = c(2, 2))
alldataforecastfunction("TDP")
alldataforecastfunction("TDN")
alldataforecastfunction("PARTN")
alldataforecastfunction("DOC")

#ALL INTERPOLATION

library(forecast)
#General 
na_p_data=read.csv("pdata.csv")
class(na_p_datanew)
na_p_data2 <- na.interp(na_p_datanew)
added_data_P=as.data.frame(na_p_data2)
autoplot(na_p_data2, series="Interpolated" ) +
  autolayer(as.ts(na_p_datanew), series="Original") +
  scale_colour_manual(
    values=c(`Interpolated`="red",`Original`="Blue"))


interpolationfunction=function(k){
  data3=lakedata%>%
    filter(characteristic_name== k)%>%
    group_by(year)%>%
    summarise(mean=mean(result_value))
  allyears=seq(1982,2022,1)
  dfallyears=data.frame(year=allyears)
  merged_data <- merge(dfallyears, data3, by = "year", all = TRUE)
  finaldata=merged_data%>%
    select(mean)
  na_p_data2 <- na.interp(finaldata)
  added_data_P=as.data.frame(na_p_data2)
  autoplot(na_p_data2, series="Interpolated") +
    autolayer(as.ts(finaldata), series="Original") +
    scale_colour_manual(values=c(`Interpolated`="red",`Original`="Blue"))+
    labs(title = k)
  
}

interpolationfunction("PARTP")





ggarrange(a1, b1, c1,d1+ rremove("x.text"), 
          ncol = 2, nrow = 3)
a1=interpolationfunction("PARTP")
b1=interpolationfunction("PARTC")
interpolationfunction("PARTC")
d1=interpolationfunction("TDP")

for (j in 1:length(target)){
  save(interpolationfunction(target[j]))
}

#Running arima with interpolated data

modelint=auto.arima(na_p_data2) 
summary(modelint)
forecast_dataint <- forecast(modelint, 20) 

print(forecast_dataint)

plot(forecast_dataint, main = "forecasting_data for rain_ts")

