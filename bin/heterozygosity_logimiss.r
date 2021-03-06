###############################
###  2010, David Ellinghaus ###
###############################

rm(list=ls())

file.het   = commandArgs()[4]
file.imiss = commandArgs()[5]
fraction_miss.thresh = as.numeric(commandArgs()[6])

# heterozygosity +- 5SD way from mean
sd.times = 5

imiss = read.table(file.imiss,header=T)
het   = read.table(file.het,header=T)

imiss.log10F_MISS = log10(imiss$F_MISS)
het = 1 - het$O.HOM./het$N.NM.

png(file=paste(file.het, ".logscale.2.png", sep=""), width=960, height=960)

dcols = densCols(imiss.log10F_MISS,het)
plot(imiss.log10F_MISS,het, xlim=c(-3,0), ylim=c(0,0.5), xlab="Individual missingness", ylab="Heterozygosity rate", col=dcols, pch=20, axes=F)
axis(1, at=c(-3,-2,log10(fraction_miss.thresh),-1,0), labels=c(0.001,0.01,fraction_miss.thresh,0.1,1))
axis(2, at=seq(0,0.5,0.05), tick=T)
abline(h=mean(het)-(sd.times*sd(het)), lty=2, col="red")
abline(h=mean(het)+(sd.times*sd(het)), lty=2, col="red")
abline(v=log10(fraction_miss.thresh), col="red", lty=2)

dev.off()
