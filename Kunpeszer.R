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

## pH összehasonlítás
plot(pH_H2O ~ pH_KCL, Kunp)
pH.lm <- lm(pH_H2O ~ pH_KCL, Kunp)
abline(pH.lm)
boxplot(resid(pH.lm))
plot(pH.lm)

## Gyanús pH-k
plot(pH_H2O ~ pH_KCL, Kunp)
abline(0,1)
identify(Kunp[,c("pH_KCL","pH_H2O")])
## Az azonosítottak kizárása
Kunp1 <- Kunp[-c(508, 566, 1330, 2366),]
plot(pH_H2O ~ pH_KCL, Kunp1)
abline(0,1)

## Modell újra
plot(pH_H2O ~ pH_KCL, Kunp1)
pH1.lm <- lm(pH_H2O ~ pH_KCL, Kunp1)
abline(pH1.lm)
cor(Kunp1$pH_H2O, Kunp1$pH_KCL)
cor(Kunp1[,-c(1:5,14,17:18)])
