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


