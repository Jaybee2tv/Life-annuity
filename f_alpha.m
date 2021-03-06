function [f,fp] = f_alpha(ax,kt,bx, dates, ages,x) %x = considered age. Return f(a_x)
  global Data Expo
  dates_indexes_data = zeros(1,length(dates(1):dates(2))); %indexes in Data table. Index of people thath have 0 year in year x
  dates_indexes_expo = zeros(1,length(ages(1):ages(2)));%indexzq in Expo table
  date1 = dates(1);
  date2 = dates(2);
  for i = date1:date2
    dates_indexes_data(i-date1+1) = find(Data.Year==i,1);
    dates_indexes_expo(i-date1+1) = find(Data.Year==i,1);
  end
  f = 0;
  fp = 0;
  for i= 1:length(dates_indexes_data)
    f = f +(Data.dx(dates_indexes_data(i)+x) - Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i)));
    fp = fp +(Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i)));
  end
  
end