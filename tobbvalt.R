x <- sample(1:100, size = 200, replace = TRUE)
y <- sample(1:100, size = 200, replace = TRUE)
z <- 2 *x + y + 1
tv.df <- data.frame(x, y, z)
## plot
plot(tv.df, asp = TRUE)

tv.lm <- lm(z ~ x + y, tv.df)
summary(tv.lm)
