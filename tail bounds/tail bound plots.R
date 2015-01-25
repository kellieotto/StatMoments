### X ~ N(0,1)
# Want to bound P(|X| >= t) -- two-sided bound

t <- seq(0, 5, by = 0.01)
b1 <- 2*pnorm(t, mean = 0, sd = 1, lower.tail=FALSE) # actual N(0,1) tail
b2 <- 2*exp(-t^2/2) # theoretical sub-Gaussian tail bound. Squared decay
b3 <- 1/t^2 # Chebyshev's inequality
plot(t, b1, type = "l", xlab = "t", ylab = "P(|X| >= t)", main = "X~N(0,1)", ylim = c(0,1)); lines(t, b2, col = 2); lines(t, b3, col = 3); legend("right", fill = 1:3, legend = c("Truth", "Chernoff", "Chebyshev"))


### Y ~ chi-squared 5
# Want to bound P(Y-5 >= t) -- one-sided bound
# Y is sub-exponential with nu = 2*sqrt(5), b = 4

t <- seq(0, 10, by = 0.01)
c1 <- pchisq(5+t, df = 5, lower.tail=FALSE) # actual chi-squared tail
c2 <- ifelse(t<1/4, exp(-t^2/(8*sqrt(5))), exp(-t/8)) # theoretical sub-exp tail bound. Squared decay for t<1/4
c3 <- 5/(t+5) # P(Y >= t+5) <= 5/(t+5) Markov's inequality (since Y is non-negative!)
plot(t, c1, type = "l", xlab = "t", ylab = "P(Y-5 >= t)", main = "Y ~ Chi-Squared, df=5", ylim = c(0,1)); lines(t, c2, col = 2); lines(t, c3, col = 3); legend("right", fill = 1:3, legend = c("Truth", "Chernoff", "Markov"))


### Gaussian decay vs exponential decay. Just look at the shape
par(mfrow = c(1,2))
t <- seq(-5, 5, by = 0.05)
dens1 <- dnorm(t, 0, 1) # N(0,1)
dens2 <- dcauchy(t, 0, 1) # Cauchy(0,1)
plot(t, dens1, type = "l", xlab = "t", ylab = "", main = "Density"); lines(t, dens2, col = 2)
t <- seq(0, 5, by = 0.01)
tail1 <- pnorm(t, 0, 1, lower.tail=FALSE) # N(0,1)
tail2 <- pcauchy(t, 0, 1, lower.tail = FALSE) # Cauchy(0,1)
plot(t, tail1, type = "l", xlab = "t", ylab = "", main = "P(X >= t)"); lines(t, tail2, col = 2); legend("right", fill = 1:2, legend = c("Gaussian", "Cauchy"))