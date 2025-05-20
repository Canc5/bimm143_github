#' ---
#' title: "Intro to R"
#' author: "Canbin Cai"
#' ---

#My first R script
x <- 1:50
plot(x, sin(x))

plot (x, sin(x), typ="l", col="blue", lwd=3, 
      xlab="Silly x axis", ylab="Sensible y axis")
