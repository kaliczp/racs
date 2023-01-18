library(readxl)
Kunp <- as.data.frame(read_excel("Kunpeszer_DB.xlsx"))
## Tidy
Kunp$`Fenolf_lug_Na2CO3%` <- as.numeric(Kunp$`Fenolf_lug_Na2CO3%`)
## KA nem számok
Kunp[is.na(as.numeric(Kunp$KA)), "KA"]
Kunp$KA <- as.numeric(Kunp$KA)
## Save as pdf
pdf()
plot(Kunp[-c(3,4:5)])
dev.off()