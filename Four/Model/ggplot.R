area = function(x,data){
  probs = c(0.02,0.5,0.975)
  qua = t(apply(data,2,quantile,probs=probs))
  d = data.frame(X= x, qua)
  colnames(d) = c("X",c("lwr","mdl","upr"))
  return(d)
}

conf_95 = area(1:20,ms$s_base_new)
pred_95 = area(1:20,ms$s_new)

mt = matrix(vec,ncol=9)
meansp = data.frame( a=1:ncol(mt), s=apply(mt,2,mean))
base = data.frame(a =a, s =vec)

gp = ggplot()
gp = gp + geom_ribbon(data= conf_95,aes(x=X, ymax=upr, ymin=lwr),alpha=2/6)
gp = gp + geom_ribbon(data= pred_95,aes(x=X, ymax=upr, ymin=lwr),alpha=1/6)
gp = gp + geom_line(data = conf_95,aes(x=X,y=mdl),size=0.5)
gp = gp + geom_point(data=meansp,aes(x=a, y=s),size=4)
