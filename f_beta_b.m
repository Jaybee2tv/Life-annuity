function [f,fp] = f_beta_b(ax,kt,bx, dates_indexes_data, dates_indexes_expo,x,dxt) %x = considered age. Return f(a_x)
  global Expo
  f = 0; fp =0;
  for i=1:length(dates_indexes_data)
    f = f+  (dxt(i)*kt(i) - Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i))*kt(i));
    fp = fp + (Expo.Female(dates_indexes_expo(i)+x)*exp(ax+bx*kt(i))*kt(i)*kt(i));
  end  
  
end