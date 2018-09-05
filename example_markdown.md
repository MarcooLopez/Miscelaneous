
 ```  
# Create data for the area to shade
mu <- 0
p0 <- 0.1
h2 <- 1
xMax <- mu+3.5

# Culling point (x0) and mean of selected individuals (i)
x0 <- qnorm(1-p0,mean=mu)
i <- dnorm(x0,mean=mu)/p0

R <- h2*i
l <- dnorm(mu,mean=mu)

# =======================================
# Selection differential plot
starty <- 0.01*l  
ptick <- 0.05*l
tt1 <- 0.05*l
tt2 <- 0.25*l

tmp <- seq(x0,xMax,0.01)
cord.x <- c(x0,tmp,xMax) 
cord.y <- c(starty,starty+dnorm(tmp),starty)

plot(0,0,xlim=c(-1*xMax,xMax),ylim=c(-1.18*tt2,l+starty),main='Selection Differential',xaxt="n",yaxt="n",bty="n",pch="",xlab="",ylab="")

# First curve  
curve(starty+dnorm(x,0,1), xlim=c(-1*xMax,xMax),add=T)
rect(-1.1*xMax,starty,1.1*xMax,starty)
polygon(cord.x,cord.y,col='skyblue')
rect(mu+i,0+starty,mu+i,dnorm(mu+i)+starty,lty=2,col=2)
rect(mu,starty,mu,dnorm(mu)+starty,lty=2,col=2)
text((x0+i)/2,0.7*dnorm(i)+starty,labels=expression(p[s]))

text(mu-0.02*2*xMax,starty-tt1,expression(mu[0]),pos=1)
rect(mu,starty-ptick,mu,starty)
text(x0,starty-tt1,expression(x[s]),pos=1)
rect(x0,starty-ptick,x0,starty)
text(mu+i,starty-tt1,expression(mu[s]),pos=1)
rect(mu+i,starty-ptick,mu+i,starty)

# Selection differential
text((mu+i)/2,starty-tt2,"S",pos=1)
rect(mu,starty-tt2-ptick/2,mu,starty-tt2+ptick/2)
rect(mu+i,starty-tt2-ptick/2,mu+i,starty-tt2+ptick/2)
rect(mu,starty-tt2,mu+i,starty-tt2)
box()
```
