function [f,fp] = f_alpha(ax,kt,bx,dates_indexes_data , dates_indexes_expo,x) %x = considered age. Return f(a_x)
  global Data Expo
  f = 0;
  fp = 0;
  for i= 1:length(dates_indexes_data)
    f = f +(Data.dx(dates_indexes_data(i)+x) - Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i)));
    fp = fp +(Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i)));
  end
  
end