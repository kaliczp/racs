library(terra)
full.terra <- rast(cbind(koord[,c("Lambda","Fi")], t(ttest2.m)), type="xyz")

library(rts)
full.rts <- rts(full.terra, ttido)

maxyr.rts <- apply.yearly(full.rts, max)

