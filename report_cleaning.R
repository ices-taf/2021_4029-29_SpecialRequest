
# Check available stocks for 2019 ewg
library(FLCore)
library(ggplotFL)

load("data/stocks.RData",verbose = TRUE)
sof <- FLStocks(stocks)
names(sof)

# to be fixed
# Assign standard units
sof = FLStocks(lapply(sof, function(x){
  units(x)=standardUnits(x)
  x}))

stks <- sof
plot(stks)

dir.create("checks")
pdf("checks/ices_by_stock_checks.pdf")
# now by stock
for(s in 1:length(stks)){
  stk = stks[[s]]

  # Show some Stock Dynamics at age
  dat=as.data.frame(FLQuants(stk,Numbers=stock.n, Weight=catch.wt,M=m,Maturity=mat),drop=T)
  dat$Age = factor(dat$age)
  # Plotting dynamics at age
  bio =ggplot(dat)+
    geom_line(aes(year,data,group=age,col=Age))+
    facet_wrap(~qname,scale="free",ncol=2)+
    theme_bw()+theme(legend.position="bottom")+
    xlab("Year")+ylab("Value-at-age")+ggtitle(paste0(s,". ",stk@name,": Biology"))
  print(bio+theme_grey())

  # Fishery
  dat = as.data.frame(
    FLQuants(Biomass=stock.n(stk)*stock.wt(stk), Vuln.Bio=stock.n(stk)*stock.wt(stk)*catch.sel(stk),SSB=stock.n(stk)*stock.wt(stk)*mat(stk),
             Catch = catch.n(stk),F=harvest(stk),
             "Selectivity"=catch.sel(stk))
  )

  # Stock at age
  dat$Age = factor(dat$age)
  # Plotting dynamics at age
  fish =ggplot(dat)+
    geom_line(aes(year,data,group=age,col=Age))+
    facet_wrap(~qname,scale="free",ncol=2)+
    theme_bw()+theme(legend.position="bottom")+
    xlab("Year")+ylab("Value-at-age")+ggtitle(paste0(s,". ",stk@name,": Stock dynamics"))
  print(fish+theme_grey())

  # grouped
  dat = as.data.frame(
    FLQuants(M=m(stk),Weight=stock.wt(stk),
             F=harvest(stk),Selectivity=catch.sel(stk))
  )
  dat$Year = factor(dat$year)
  byage =ggplot(dat)+
    geom_line(aes(age,data,group=Year,col=Year))+
    facet_wrap(~qname,scale="free",ncol=2)+
    theme_bw()+theme(legend.position="bottom")+
    xlab("Age")+ylab("Value-at-age")+ggtitle(paste0(s,". ",stk@name,": Stock-at-age"))
  print(byage+theme_grey())

}
dev.off()
