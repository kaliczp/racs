## A korábban előállított terra objektum
szel.tra
## rts gyártás az objektum időbélyege segítségével és ellenőrző plottolás.
szel.rts <- rts(szel.tra, time(szel.tra))
plot(szel.rts[['2020-01-01']])

## A 19.4 nél nagyobb értékeket számláló függvény és évenkénti futtatása
gyakor70 <- function(x){sum(x > 19.4)}
gyakor.rts <- apply.yearly(szel.rts, gyakor70)

## A 2001–2011 közötti időszak vizuális ellenőrzése
plot(gyakor.rts[['2001/2011']])

## cellánkénti összegzés és kivonás, majd ellenőrzés
valt.rts <- sum(gyakor.rts[['2011/2021']]@raster) - sum(gyakor.rts[['2001/2011']]@raster)
plot(valt.rts)
valt.rts