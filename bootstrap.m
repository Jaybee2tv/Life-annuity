function [alp,bet,kap,kap_p] = bootstrap(B,dates, ages,max_iter,tol,n,t1) %n=horizon of projection
  global Data Expo Death
  %---------------for f_beta and f_alpha. Just to get the indexes
  dates_indexes_data = zeros(1,length(dates(1):dates(2))); %indexes in Data table. Index of people thath have 0 year in year x
  dates_indexes_expo = zeros(1,length(dates(1):dates(2)));%indexzq in Expo table
  date1 = dates(1);
  date2 = dates(2);
  for i = date1:date2
    dates_indexes_data(i-date1+1) = find(Data.Year==i,1);
    dates_indexes_expo(i-date1+1) = find(Expo.Year==i,1);
    dates_indexes_death(i-date1+1) = find(Expo.Year==i,1);
  end
  %-------------------
  etr_xt = zeros(length(ages(1):ages(2)),length(date1:date2));
  m_xt = etr_xt;
  list_age = ages(1):ages(2);
  for age = 1:length(list_age)
    for year = 1:length(date1:date2)
      etr_xt(age,year) = Expo.Female(dates_indexes_expo(year)+list_age(age));
      m_xt(age,year) = Data.mx(dates_indexes_data(year)+list_age(age));
    end
  end
  d_xt = etr_xt.*m_xt;
  %bootstrap per se
  rng(1); %=seed. to conserve the same random values
  colum = length(1:B);
  alp = zeros(length(list_age),colum);
  bet = alp;
  kap = zeros(length(date1:date2),colum);
  kap_p = zeros(n,colum);
  for b = 1:B
    d_xtb = random('Poisson',d_xt);
    [alp(:,b),kap(:,b),bet(:,b)] = leeCar_NR_b(dates, ages,max_iter, tol, d_xtb);
    kap_p(:,b) = projection_b(dates,n,t1,kap(:,b));
  end
  
  
  
end