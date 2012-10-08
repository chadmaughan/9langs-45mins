#	Plots histograms for all variables (therefore 8 histograms)
#	Provides descriptive statistics for all variables

library('psych')

pwd <- getwd() 
setwd(pwd)

# read in the sample wine data into a 'data.frame'
data<-read.table("DAA.01.txt",header=T)

# grep the 'des' condition and store in separate data.frame
des <- data[grep("des", data$cond),]
aer <- data[grep("aer", data$cond),]

# describe them
describe(des)
describe(aer)

# save it to a png
png('des.png')

# plot four histograms on a single page for 'des'
layout(matrix(c(1,2,3,4),2,2,byrow=TRUE))

# plot histograms
hist(des$pre.wm.s)
hist(des$post.wm.s)
hist(des$pre.wm.v)
hist(des$post.wm.v)

dev.off()

# save it to a png
pdf('aer.pdf')

# plot four histograms on a single page for 'aer'
layout(matrix(c(1,2,3,4),2,2,byrow=TRUE))

hist(aer$pre.wm.s)
hist(aer$post.wm.s)
hist(aer$pre.wm.v)
hist(aer$post.wm.v)

dev.off()
