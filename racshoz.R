koord <- read.table("racsponti_adatsor_2001tol/gridpoints_coordinates.txt", head = TRUE)

## fwf beolvasás
grid2 <- read.fwf("racsponti_adatsor_2001tol/fx_grid_20012021.dat", widths = c(4,2,2,rep(8,1232)), skip = 1)

## Gyorsabb megoldás soronkénti feldolgozással
tttest <- scan("racsponti_adatsor_2001tol/fx_grid_20012021.dat", what = character(), sep = "\n")
ttidohoz <- paste(substr(tttest[-1], 1, 4), substr(tttest[-1], 5, 6), substr(tttest[-1], 7, 8), sep = "-")
ttidohoz <- gsub(" ", "0", ttidohoz)
ttido <- as.Date(ttidohoz)
ttest1 <- substring(tttest[-1], 9)
ttest2 <- strsplit(ttest1, " +")
ttest2.m  <- matrix(as.numeric(unlist(ttest2)), byrow=TRUE, nrow=length(ttest2))
ttest2.m <- ttest2.m[,-1]
library(xts)
fullgrid.xts <- xts(ttest2.m, ttido)
rm(list = ls(patt="^tt"))

akt.df  <- data.frame(lon = koord$Lambda, lat = koord$Fi,
                      val = as.vector(coredata(fullgrid.xts['2001-01-01'])))
library(raster)
act <- rasterFromXYZ(akt.df)
plot(act)
