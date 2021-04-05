function [f,fp] = f_kappa_b(ax,kt,bx, ages,t, dxt) %t = considered time. Return f(a_x)
  global Expo
  dates_indexes_expo= find(Expo.Year==t);
  f= 0;fp = 0;
  for i=1:length(ages(1):ages(2))
    f = f+ ((dxt(i)*bx(i))- (Expo.Female(dates_indexes_expo(i+ages(i))))*exp(ax(i)+bx(i)*kt)*bx(i)); %les betas sont bien construit
    fp = fp + (Expo.Female(dates_indexes_expo(i+ages(i))))*exp(ax(i)+bx(i)*kt)*bx(i)*bx(i);
  end
end