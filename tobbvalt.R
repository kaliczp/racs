x <- sample(1:100, size = 200, replace = TRUE)
y <- sample(1:100, size = 200, replace = TRUE)
tv.df <- data.frame(x, y)
## plot
plot(tv.df, asp = TRUE)

tv.lm <- lm(y ~ x, tv.df)
summary(tv.lm)
