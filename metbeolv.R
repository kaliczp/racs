metbeolv <- function(file) {
  ## Csomagok betöltése
  require(rts)
  require(raster)
  grid <- read.fwf(file, # fájlnév
                    widths = c(4,2,2,rep(8,1232)), # sorok struktúrája
                    skip = 1) # első sor eldobáa
  ido <- as.Date(head(paste(grid[,1],grid[,2],grid[,3], sep = "-"))) # idő generálás
  act <- rasterFromXYZ(akt.df) 
  rts(act, ido)
}