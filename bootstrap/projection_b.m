function [k_t] = projection_b(dates,n,t1, kap)% project in n year, m=number of simulation
% t1, i.e year in wich kappa show linear trend
  k_t = zeros(1,n);% simulations in row for year n 
  ktn = kap(length(kap)); %the last kappa
  t_line = (t1-dates(1));
  d = (kap(length(kap))- kap(t1-dates(1)))/(length(kap)-t_line);
  sig_sq = 0;
  %------Estimating sigma_square-----
  for t = t_line+1:length(kap)
    sig_sq = sig_sq + (kap(t)-kap(t-1)-d)^2;
  end
  sig_sq = sig_sq/(length(kap)-t_line);
  %-----Project kappat and build Confinden Inter-------
  for year = 1:n
    k_t(year) = ktn + year*d + random('norm',0,sqrt(sig_sq));
  end
  
end