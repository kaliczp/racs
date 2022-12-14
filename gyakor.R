szel.tra
szel.rts <- rts(szel.tra, time(szel.tra))
plot(szel.rts[['2020-01-01']])

gyakor70 <- function(x){sum(x > 19.4)}

gyakor.rts <- apply.yearly(szel.rts, gyakor70)

plot(gyakor.rts[['2001/2011']])

valt.rts <- sum(gyakor.rts[['2011/2021']]@raster) - sum(gyakor.rts[['2001/2011']]@raster)
plot(valt.rts)
