metbeolv <- function(file.grid, file.coord) {
  ## Csomagok betöltése
  require(rts)
  require(terra)
  require(xts)
  ## Koordináta beolvasás
  koord <- read.table(file.coord, head = TRUE)
  ## Nyers adatsor beolvasása
  tttest <- scan(file.grid, what = character(), sep = "\n", skip = 1)
  ## Időbélyeg előállítás
  ttidohoz <- paste(substr(tttest, 1, 4), substr(tttest, 5, 6), substr(tttest, 7, 8), sep = "-")
  ttidohoz <- gsub(" ", "0", ttidohoz)
  ido <- as.Date(ttidohoz)
  ### Az adatok előkészítése
  ttest1 <- substring(tttest, 9)
  ttest2 <- strsplit(ttest1, " +")
  ttest2.m  <- matrix(as.numeric(unlist(ttest2)), byrow=TRUE, nrow=length(ttest2))
  ttest2.m <- ttest2.m[,-1]
  ## Terra raszter
  full.terra <- rast(cbind(koord[,c("Lambda","Fi")], t(ttest2.m)), type="xyz", crs = "WGS84")
  ## rts iősor
  rts(full.terra, ido)
}
