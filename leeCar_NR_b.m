function [alp,kap,bet] = leeCar_NR_b(dates, ages,max_iter, tol, dxt)%leecarter for bootstrap
  global Data
  alp = zeros(1,length(ages(1):ages(2)));
  kap = zeros(1,length(dates(1):dates(2)));
  bet = ones(1,length(ages(1):ages(2)));
  list_age = ages(1):ages(2);
  list_period = dates(1):dates(2);
  
  %---------------for f_beta and f_alpha. Just to get the indexes
  dates_indexes_data = zeros(1,length(dates(1):dates(2))); %indexes in Data table. Index of people thath have 0 year in year x
  dates_indexes_expo = zeros(1,length(ages(1):ages(2)));%indexzq in Expo table
  date1 = dates(1);
  date2 = dates(2);
  for i = date1:date2
    dates_indexes_data(i-date1+1) = find(Data.Year==i,1);
    dates_indexes_expo(i-date1+1) = find(Data.Year==i,1);
  end
  %-------------------
  
  for i = 1:max_iter
    if i ==max_iter
      fprintf('NO PARAM FOUND \n')
      alp = 0;bet = 0;kap = 0;
    else
      alp_p = alp;
      bet_p = bet;
      kap_p = kap;
      for age = 1:length(list_age)
        [f_a,fp_a] = f_alpha_b(alp(age),kap,bet(age),dates_indexes_data,dates_indexes_expo,list_age(age),dxt(age,:));
        alp(age) = alp(age) + f_a/fp_a;
        alp = alp + bet*mean(kap);
      end
      for period = 1:length(list_period)
        [f_k,fp_k] = f_kappa_b(alp,kap(period),bet,list_age,list_period(period),dxt(:,period));
        kap(period) = kap(period) + f_k/fp_k;
      end
      for age = 1:length(list_age)
        [f_b,fp_b] = f_beta_b(alp(age),kap,bet(age),dates_indexes_data,dates_indexes_data,list_age(age),dxt(age,:));
        bet(age) = bet(age) + f_b/fp_b;
      end
      bet_dot = sum(bet);
      alp = alp + bet*mean(kap);
      bet = bet/bet_dot;
      kap = (kap-mean(kap))*bet_dot;
    
      if (norm(alp_p-alp)<=tol && norm(bet_p-bet)<=tol && norm(kap_p-kap)<=tol)
          break;
      end
    end
  end
  
end