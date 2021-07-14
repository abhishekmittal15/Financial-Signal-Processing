# Hybrid Adaptive filters for Stock market Prediction

## 1. Introduction
Many Economists have studied different intuitive ways of analysing Stock-Market figures through the years and these methods take inspiration from different fields of Mathematics and Science. In this project we chose to use Signal Processing ideas to do the same,using different concepts and recurring ideas from it in order to predict and understand the Stock market. The inherent non-determinism in these figures allow us to only predict them to a certain accuracy and not completely determine them. Thus, improving upon them may lead us to get closer and closer to the true values.We will discuss some of the important Filters and Algorithms used in such analyses in the next few sections.

## 2. Input Signal

Our input signal can be treated as a random process. It is not a deterministic signal. This comes under the purview of statistical signal processing. Here the signal's properties are examined using the concepts of probability and random walks. In this project, we will treat the Stock Market as a stochastic and noisy discrete-time system and thus, we will need Adaptive filters and Algorithms to analyse any underlying patterns in it. 

## 3. Kalman Filters

We know that the Stock market's daily returns are very noisy. This noise clouds the underlying patterns present in the daily returns signals. If we can somehow detect this noise and remove it from our input signal, the patterns will help us in predicting the future returns based on the patterns uncovered. This can be done by Kalman Filters. Our understanding of a Kalman filters is : Lets say we want to measure the length of an object, now we can take multiple measurements using different devices and none of them give us the accurate value, if we know how these measurements are related then we can use a Kalman filter and remove the noise/error in the measurements and find the approximate length of the object. The same concept can be applied to the Stock market's daily returns. The Kalman filter creates an estimate of the prossible values and takes a weighted average of them by assigning lower weights to those who have a lower uncertainty of being close to the true value. In short a Kalman filter is a recursive filter that estimates the internal state of the system using a series of nosiy measurements. 

## 4. Adaptive Filters

There have been multiple conventional filters like autoregressive(AR) and moving average(MA) filters which are used to predict the stock market prices, but they are not very accurate. The main aim of this project is to show how to choose filters that are efficient in extracting the maximum information from the past input signals. Our traditional filters having fixed response irrespective of the input can not be used here because we want the response of the filter to be such that when an input signal is given, its able to correctly predict the output signal. To achieve this we choose a special class of filters called the Adaptive fitlers. These filters are called adaptive because their response to the input signal is not fixed, rather it adapts its response based on the error signal that is generated due to the differences in the actual output signal and the predicted output signal. The change in its response is governed by adaptive algorithms like LMS and RLS. To use these filters we first train our filter to minimise its prediction error by giving huge past data as input and then when the error is minimised, we give it an input signal of today's stock market return and output the next day's stock market return. 

## 4. Algorithms

In these we discuss the Algorithms used in predicting the next element of a vector, whose components are known to us (with regards to the Stock-Market application, the n previous entries would be the components of this vector).

### LMS - Least Mean Square 
LMS algorithm uses the estimates of the gradient vector from the available data. LMS incorporates an iterative procedure that makes successive corrections to the weight vector in the direction of the negative of the gradient vector which eventually leads to the minimum mean square error.

This algorithm basically reduces the Mean-Square error (MSE) in each iteration using the Gradient Descent principle. That is, if the MSE-gradient is positive, it implies the error would keep increasing positively if the same weight is used for further iterations, which means we need to reduce the weights. In the same way, if the gradient is negative, we need to increase the weights. 


### RLS - Recursive Least Squares

In the RLS Algorithm, we assume that the input is a deterministic vector and the error vector is the difference between the desired signal and the actual output signal.We now try to find the weights that minimise this weighted sum of the square of the errors. This function of square of the errors is termed the Cost function and this algorithm helps us to recursively find these weights.Older errors are given exponentially smaller weights and this fact gives us the understanding that the effect of a single output does not reach far into the future. The newer weights are higher and thus increase our algorithm's sensitivity to larger errors that occured recently. The final minimisation is again implemented using the partial derivative of the Cost function w.r.t each entry of the weight vector and then this result is set to 0 and solved for the respective weights.The computational complexity of this algorithm however,is quite high when compared to algorithms like LMS.



## Our plan

We have a rough understanding of the various filter designs and the algorithms that would be required to completely understand the paper and its results. After gaining an intuituve understanding of how these filters work why these filters were chosen and why simply using the discrete cosine transform as the input to these adaptive filters give better predictions, we wish to gain a mathematical understanding of these filters, if time permits. Looking at these filters from a mathematical point of view will help us find the exact prediction accuracy of these filters in predicting the stock market prices. Parallely we would also code up these algorithms in matlab and look at some results. We would try to find a good dataset on which we can test these filters. This way we can compare our results to the results that were presented in the paper, we dont expect them to be exactly same ,as the market is very dynamic and since that paper is over 10 years old, those results may not be relevant today.


## References
1. [Application of Hybrid Adaptive filters for stock market prediction ](https://ieeexplore.ieee.org/abstract/document/5738771/keywords#keywords)
2. Monson Hayes book on Statistical Signal Processing
3. [ Adaptive Filter Design for Stock Market prediction using a Correlation-based Criterion ](https://arxiv.org/ftp/arxiv/papers/1501/1501.07504.pdf) 
