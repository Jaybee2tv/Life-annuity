function [f,fp] = f_kappa(ax,kt,bx, ages,t) %t = considered time. Return f(a_x)
  global Death Expo
  dates_indexes_data = find(Death.Year==t);
  dates_indexes_expo= find(Expo.Year==t);
  f= 0;fp = 0;
  for i=1:length(ages(1):ages(2))
    f = f+ ((Death.Female(dates_indexes_data(i+ages(i)))*bx(i))- (Expo.Female(dates_indexes_expo(i+ages(i))))*exp(ax(i)+bx(i)*kt)*bx(i)); %les betas sont bien construit
    fp = fp + (Expo.Female(dates_indexes_expo(i+ages(i))))*exp(ax(i)+bx(i)*kt)*bx(i)*bx(i);
  end
end