cudata<- read.csv("C:/Users/romnr/Desktop/This is Statistics/Projects/For practicing time series/annual-copper-prices-18001997.csv", header = T, sep=",")
cudatats<- ts(cudata) #frequency is 1 for annual data, 4 for quaterly, 12 for monthly
cudatats<- ts(cudatats, start = 1800, end = 1985) #specify the 1st year using the start arg in ts() func. and end year using end

#eg:-1st datapoint was colleted in the second quarter of 1986 start=c(1986,2)
#once you've read a ts into R, next stepp is to make plot

plot.ts(cudatats)

#by looking at the plot we try to decide whether the time series is additive or multiplicative?
#interactions between trend and seasonality are typically classified as either additive or multiplicative.
#in a multiplicative time series, the components multiply together. If you have an increasing trend, 
#the amplitude of seasonal activity increases, everything becomes more exaggerated eg. webgtraffic data
#in an additive time series components add together. If you have an increasing trend, still you will see 
#roughly the same size of troughs and peaks throughout the time series.
#This is most likely to be described by ADDITIVE model since the fluctuations in the data are roughly constant in size
#It is a non-seasonal time series data, consists of a trend component and an irregular component.

#to estimate the trend component of a non-seasonal time series that can be described using an additive model,
#it is common to use a smoothing method, ,such as calculating the simple moving average of the time series.
#The SMA function in the "TTR" R package can be used to smooth time series data using a simple moving average

library("TTR")


#If you have a time series that can be described using an additive model with constant level and no seasonality,
#then simple exponential smoothing can be used to make short term forecasts.

#also try exponential smoothing
#exponential smoothing methods are useful for making forecasts, and make no assumptions about the correlations b/w successive
#values of series. 
