koord <- read.table("racsponti_adatsor_2001tol/gridpoints_coordinates.txt", head = TRUE)
grid <- read.fwf("racsponti_adatsor_2001tol/fx_grid_20012021.dat", widths = rep(8,1233))
grid2 <- read.fwf("racsponti_adatsor_2001tol/fx_grid_20012021.dat", widths = c(4,2,2,rep(8,1232)), skip = 1)
## Félbemaradt megoldás
tttest <- scan("racsponti_adatsor_2001tol/fx_grid_20012021.dat", what = character(), sep = "\n")
## Második félbemaradt megoldás
ttest2 <- scan("racsponti_adatsor_2001tol/fx_grid_20012021.dat", what = character(), skip = 1)
test.mt <- matrix(ttest2, nrow = 7671)

idő <- grid[-1,"V1"]
# as.Date(idő, format = "%Y %m %d")
library(xts)
teszt.xts <- xts(grid[-1,"V10"],seq(as.Date("2001-01-01"), as.Date("2021-12-31"), by = "days"))

teszt.m <- as.matrix(grid[-1, -1])

summary(apply(grid2[-1,-(1:3)], 2, max))