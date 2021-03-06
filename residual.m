function [resi, eps_squar] = residual(dates, ages, alp, bet, kap)
%to plot a matrix see :imagesc(eye(4)); colorbar
  global Data
  resi = zeros(length(ages(1):ages(2)),length(dates(1):dates(2)));
  
  %---------------for f_beta and f_alpha. Just to get the indexes
  dates_indexes_data = zeros(1,length(dates(1):dates(2))); %indexes in Data table. Index of people thath have 0 year in year x
  date1 = dates(1);
  date2 = dates(2);
  x_t = ages(2)-ages(1); t_t = dates(2)-dates(1)-1;
  cohor = ages(1):ages(2);
  for i = date1:date2
    dates_indexes_data(i-date1+1) = find(Data.Year==i,1);
  end
  %-------------------
  eps_squar = 0;
  for age = 1:length(ages(1):ages(2))
    for year = 1:length(dates(1):dates(2))
      if Data.mx(dates_indexes_data(year)+cohor(age))== 0
        continue %bcause there are value with 0 in mx
      end
      eps_squar = eps_squar +(log(Data.mx(dates_indexes_data(year)+cohor(age))) - (alp(age)+bet(age)*kap(year)))^2;
    end
  end
      
  for age = 1:length(ages(1):ages(2))
    for year = 1:length(dates(1):dates(2))
      if Data.mx(dates_indexes_data(year)+cohor(age))==0
        continue %bcause there are value with 0 in mx
      end
      epsi = log(Data.mx(dates_indexes_data(year)+cohor(age))) - (alp(age)+bet(age)*kap(year));
      resi(age,year) = (epsi)/(sqrt(eps_squar/x_t*t_t));
    end
  end
  
  figure('name','RESIDU');
  surf(resi)
  %imagesc(dates,ages,resi);
  set(gca,'YDir','normal')
  colorbar;
  
end