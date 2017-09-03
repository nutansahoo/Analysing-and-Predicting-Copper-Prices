cudata<- read.csv("C:/Users/romnr/Desktop/This is Statistics/Projects/For practicing time series/cudata.csv", header = T, sep=",")

#omit last five rows
cudata<- cudata[-(194:197), -1]
cudatats<- ts(cudata)
cudatats<- ts(cudatats, start = 1800, end = 1992)
plot.ts(cudatats)

#the long term trend has already been subtracted, now we test for stationarity in the data
#plot acf and pacf graphs to check significant lags
acf(cudatats)
pacf(cudatats)
#both the graphs have a few significant lags but these die out quickly, our series maybe stationary
#statistical tests to test stationarity

library(fpp) #install packages fpp and forecast before loading
library(forecast)

adf.test(cudatats) #p value is 0.3564(>0.05). Hence, not stationary
kpss.test(cudatats) #p value is 0.1 (>0.05), fail to reject null hypothesis that it is level stationary

#we are getting contradictory results from these tests
#we will take out first difference of series and store in diff_cudata
diff_cudata<- diff(cudatats)
plot.ts(diff_cudata)

adf.test(diff_cudata)  #p value is 0.01 (<0.05), reject the null that it is not stationary
kpss.test(diff_cudata) #p value is 0.1 (>0.05),fail to reject null hyp. that series is level stationarity

#the differenced series is stationary

#Identify the model order and estimate the parameters
acf(diff_cudata)
pacf(diff_cudata)

#values of the Partialautocorrelations and autocorreltaions
acf(diff_cudata, plot=FALSE)
pacf(diff_cudata, plot=FALSE)

#The partial correlogram shows that partial autocorrelations at lags 2,5,11and 14 exceed the signifiance bounds.hence, we should fit an AR model of order 2.
#rest are way below the significance bounds.the correlogram shows that ac at lag 2 is exceeding the significance bounds.Hence, an MA model of order 2 would be apt for this.
#meaning, approriate model to be fitted is ARIMA(2,0,2)
#we use the principle of parsimony to decide which model is the best: that is we assume that the model with the fewer parameters is the best

#auto.arima() fn.(from forecast package) can also be used to find the appropriate ARIMA model 
fit<- auto.arima(diff_cudata)   #gives out ARIMA(2,0,2) as the best output

#testing diiferent models myself for better understanding
m1<- arima(diff_cudata, order=c(1,0,2))
m2<- arima(diff_cudata, order=c(2,0,2))
m3<- arima(diff_cudata, order=c(3,0,2))
m4<- arima(diff_cudata, order=c(4,0,2))
m1$loglik;m1$aic ;m1$sigma2
m2$loglik;m2$aic ;m2$sigma2  #our selected model has the lowest AIC, it is the best model
m3$loglik;m3$aic ;m3$sigma2
m4$loglik;m4$aic ;m4$sigma2

#model diagnostics
res<- fit$residuals
#we will now check that the basic assumptions of the ARMA models are met
#check the independence of the residuals and normality of the residuals. Once, the residuals look like white noise and normally distributed
#after that we calculate the forecasts

#plot()


