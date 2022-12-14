koord <- read.table("racsponti_adatsor_2001tol/gridpoints_coordinates.txt", head = TRUE)

## fwf beolvasás
grid2 <- read.fwf("racsponti_adatsor_2001tol/fx_grid_20012021.dat", widths = c(4,2,2,rep(8,1232)), skip = 1)
as.Date(head(paste(grid2[,1],grid2[,2],grid2[,3], sep = "-")))

## Gyorsabb megoldás soronkénti feldolgozással
tttest <- scan("racsponti_adatsor_2001tol/fx_grid_20012021.dat", what = character(), sep = "\n", skip = 1)
ttidohoz <- paste(substr(tttest, 1, 4), substr(tttest, 5, 6), substr(tttest, 7, 8), sep = "-")
ttidohoz <- gsub(" ", "0", ttidohoz)
ido <- as.Date(ttidohoz)
ttest1 <- substring(tttest, 9)
ttest2 <- strsplit(ttest1, " +")
ttest2.m  <- matrix(as.numeric(unlist(ttest2)), byrow=TRUE, nrow=length(ttest2))
ttest2.m <- ttest2.m[,-1]
library(xts)
fullgrid.xts <- xts(ttest2.m, ido)
rm(list = ls(patt="^tt"))

akt.df  <- data.frame(lon = koord$Lambda, lat = koord$Fi,
                      val = as.vector(coredata(fullgrid.xts['2001-01-01'])))
library(raster)
act <- rasterFromXYZ(akt.df)
plot(act)

## Éves maximum
akt.df  <- data.frame(lon = koord$Lambda, lat = koord$Fi,
                      val = apply(fullgrid.xts['2021'], 2, max))
plot(rasterFromXYZ(akt.df))

## RasterBrick
act <- rasterFromXYZ(koord[,c("Lambda", "Fi", "Index")])
act.df <- as.data.frame(act)
act.df <- cbind(cell=1:nrow(act.df) ,act.df)
act.df[is.na(act.df[, "Index"]), "Index"] <- max(act.df[, "Index"], na.rm = TRUE) + 1
acthoz <- cbind(Index = 1:ncol(ttest2.m), as.data.frame(t(ttest2.m)))
acthoz.full  <-  merge(act.df, acthoz, by = "Index", all.x = TRUE, sort = FALSE)
acthoz.full.ok <- acthoz.full[order(acthoz.full$cell),]
full.brick <- brick(nrows=30, ncols=69, xmn=16.05, xmx=22.95, ymn=45.65, ymx=48.65, nl=7670)
full.brick <- setValues(full.brick, as.matrix(acthoz.full.ok[,-(1:2)]))

library(rts)
full.rts <- rts(full.brick, ido)

## Példa a saját függvény alkalmazására
szel <- metbeolv(file.grid = "racsponti_adatsor_2001tol/fx_grid_20012021.dat", file.coord = "racsponti_adatsor_2001tol/gridpoints_coordinates.txt")
## Sugárzás teszt
sug <- metbeolv(file.grid = "racsponti_adatsor_2001tol/sr_grid_20012021.dat", file.coord = "racsponti_adatsor_2001tol/gridpoints_coordinates.txt")
## Hőmérs teszt
hom <- metbeolv(file.grid = "racsponti_adatsor_2001tol/ta_grid_19712021.dat", file.coord = "racsponti_adatsor_2001tol/gridpoints_coordinates.txt")
## Csapi
csap <- metbeolv(file.grid = "racsponti_adatsor_2001tol/r_grid_19712021", file.coord = "racsponti_adatsor_2001tol/gridpoints_coordinates.txt")

## Idősor egy cellára kerülő úton
egycell <- extract(hom@raster, c(18,47))
cell.xts <- xts(t(as.matrix(egycell[2,])), index(hom@time))

## terra
szel.tra <- metbeolv(file.grid = "racsponti_adatsor_2001tol/fx_grid_20012021.dat", file.coord = "racsponti_adatsor_2001tol/gridpoints_coordinates.txt", output = "terra")

## Idősor egy cellára kerülő úton
egycell <- extract(szel.tra, c(18,47))
cell.xts <- xts(t(as.matrix(egycell[2,])), time(szel.tra))
cell.df <- cbind(as.data.frame(t(egycell[2,])), time(szel.tra))
names(cell.df) <- c("sz","date")
plot(sz ~ date, data = cell.df, type = "l")
cell.lm <- lm(sz ~ date, data = cell.df)

## Éves gyakoriság 19.4 vagy nagyobb
ttest <- tapply(cell.df$sz, format(cell.df$date, "%Y"), function(x){sum(x > 19.4)})

out.mat <- matrix(NA, nrow = 30, ncol = 69)
evido <-  format(time(szel.tra), "%Y")
tti <- 1
for(ttsor in 1:30) {
  for(ttosz in 1:69) {
    szelcell <- as.numeric(szel.tra[tti])
    if(any(is.na(szelcell))) {
      out.mat[ttsor,ttosz] <- NA
    } else {
      ttest <- tapply(szelcell, evido, function(x){sum(x > 19.4)})
      out.mat[ttsor,ttosz] <- sum(ttest[11:21]) - sum(ttest[1:11])
    }
    tti <- tti + 1
    print(tti)
  }
}