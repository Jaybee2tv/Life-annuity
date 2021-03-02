vrai_tab <- read.csv("C:/Users/32485/Desktop/R file/Actu502/vrai_tab.txt", sep="")
data_set <- tail(vrai_tab,2220)

z_alp <- 2.58 # LOOk

plot_tau <- function(date){ #give the date you want to plot. ATTENTION!! the max date can be five due to color 
  #limitation and also for visualisation purpose
  col_plot <- c('blue','red', 'green',  'darkorange', 'black')
  
  dates_start <- match(date, data_set$Year)
  end_date <- dates_start[1]+109
  plot(data_set$Age[dates_start[1]:end_date],log(data_set$mx[dates_start[1]:end_date]),type = "l", col = col_plot[1], xlab = 'ages', ylab = "log mu")
  
  if(length(date>1)){
    color_choice <- 1
    n <- length((dates_start))
    last_index <- dates_start[n] #first index of last date
    for(i in seq(2,n)){ 
      color_choice <- color_choice +1
      deb <- dates_start[i]
      fin <- deb+109
      lines(data_set$Age[deb:fin],log(data_set$mx[deb:fin]), col = col_plot[color_choice])
      
    }
  }
  
  legend(40,-2, legend = as.character(date), col = col_plot[1:length(date)], bg = "lightblue", lty=rep(1,length(date)))

}

plot_rectan <- function(date){ #give the date you want to plot. ATTENTION!! the max date can be five due to color 
  #limitation and also for visualisation purpose
  col_plot <- c('blue','red', 'green',  'darkorange', 'black')
  
  dates_start <- match(date, data_set$Year)
  end_date <- dates_start[1]+109
  plot(data_set$Age[dates_start[1]:end_date],data_set$lx[dates_start[1]:end_date],type = "l", col = col_plot[1], xlab = 'ages', ylab = "Nombre d'individu")
  
  if(length(date>1)){
    color_choice <- 1
    n <- length((dates_start))
    last_index <- dates_start[n] #first index of last date
    for(i in seq(2,n)){ 
      color_choice <- color_choice +1
      deb <- dates_start[i]
      fin <- deb+109
      lines(data_set$Age[deb:fin],data_set$lx[deb:fin], col = col_plot[color_choice])
      
    }
  }
  
  legend(18,40000, legend = as.character(date), col = col_plot[1:length(date)], bg = "lightblue", lty=rep(1,length(date)))
  
}

plot_quant <- function(){
  
  quant <- list()
  dates_start <- match(seq(2000,2010), data_set$Year)
  i <- 1
  while(i<=11){#on a 2000-->2010
    deb <-dates_start[i]
    fin <- deb+109
    quant[[i]] <- as.numeric(quantile(data_set$lx[deb:fin], 0.75) - quantile(data_set$lx[deb:fin], 0.25))
    i <- i+1
    
  }
  plot(seq(2000,2010), quant, type = 'l', col = 'blue', xlab = 'années', ylab = 'delta quantile')
  
  
  
  
}
