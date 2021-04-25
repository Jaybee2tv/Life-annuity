function [f,fp] = f_alpha_b(ax,kt,bx,dates_indexes_data , dates_indexes_expo,x, dxt) %for bootstrap
  global Expo
  f = 0;
  fp = 0;
  for i= 1:length(dates_indexes_data)
    f = f +(dxt(i) - Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i)));
    fp = fp +(Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i)));
  end
  
end