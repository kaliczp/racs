library(terra)
full.terra <- rast(cbind(koord[,c("Lambda","Fi")], t(ttest2.m)), type="xyz")

library(rts)
full.rts <- rts(full.terra, ido)

maxyr.rts <- apply.yearly(full.rts, max)

## Éves maximum
plot(maxyr.rts[['2001']])

eves.terra <- maxyr.rts@raster

## Export tiff
writeRaster(eves.terra, "eves.tiff", filetype = "GTiff")
