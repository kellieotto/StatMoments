# Kellie Ottoboni
# November 11, 2014
# Confidence intervals for beta using lm and permutation


############################# Errors are IID Normal(0,1)
X <- runif(100, min=0, max=10)
err1 <- rnorm(100, mean=0, sd=1)
Y <- 2*X + err1
mod1 <- lm(Y~X)
summary(mod1)
beta1 <- mod1$coeff[2]
confint(mod1,2)
#     2.5 %   97.5 %
# X 1.917913 2.068841


distrib1 <- replicate(10000, {
	X <- sample(X)
	lm(Y~X)$coeff[2]
})
mean(abs(distrib1) >= abs(beta1)) # 0
se1 <- sd(distrib1)
conf_perm1 <- c(beta1 - 1.96*se1, beta1 + 1.96*se1)
print(conf_perm1)
#       X        X 
# 1.598273 2.388481 
# much wider confidence interval - we lose power by going to permutation test when the data actually is normal



############################# Errors are heavy-tailed and depend on X
library(VGAM)
err <- rlaplace(100)
xcut <- cut(X, 5)
err2 <- err*as.numeric(xcut)
Z <- 2*X + err2
mod2 <- lm(Z~X)
summary(mod2)
beta2 <- mod2$coeff[2]
confint(mod2,2)
#     2.5 %   97.5 %
# X 1.716465 2.348086
# This is just wrong - our data aren't normal!


distrib2 <- replicate(10000, {
	X <- sample(X)
	lm(Z~X)$coeff[2]
})
mean(abs(distrib2) >= abs(beta2)) # 0
se2 <- sd(distrib2)
conf_perm2 <- c(beta2 - 1.96*se2, beta2 + 1.96*se2)
print(conf_perm2)
#       X        X 
# 1.531020 2.533531  
# Wider confidence interval


############################# Plot it
par(mfrow = c(2,2))
plot(density(Y), main = "Distribution of Y")
plot(density(Z), main = "Distribution of Z")
plot(Y~X, main = "Gaussian Errors", cex.main = 0.75); abline(mod1)
plot(Z~X, main = "Double Exp. Errors, Heteroskedasticity", cex.main = 0.75); abline(mod2)
