function [m_pro, k_t] = multiple_path(dates,ages,n,m,t1,bet, kap)% project in n year, m=number of simulation
% Give t1, i.e year in wich kappa show linear trend
%% DO NOT USE THIS
  global Data
  age_LOL = 0; % age at which we plot mortality
  list_ages = ages(1):ages(2);
  list_dates = dates(1):dates(2);
  k_t = zeros(m,n);% simulations in row for year n 
  ktn = kap(length(kap)); %the last kappa
  t_line = (t1-dates(1));
  d = (kap(length(kap))- kap(t1-dates(1)))/(length(kap)-t_line);
  sig_sq = 0;
  for t = t_line+1:length(kap)
    sig_sq = sig_sq + (kap(t)-kap(t-1)-d)^2;
  end
  sig_sq = sig_sq/(length(kap)-t_line);
  
  for simu = 1:m% this simulation will create a new random number
    for year = 1:n
      k_t(simu,year) = ktn + year*d + normrnd(0,sig_sq);
    end
  end
  
   %------Projecting death------
  m_pro = zeros(length(list_ages), n);
  mxt_prime = zeros(length(list_ages),1);
  for age = ages(1):ages(2)
    mxt_prime(age-ages(1)+1,1) = Data.mx(find(Data.Year==dates(2),1)+age);
  end
  for age = 1:length(list_ages)
    for year = 1:n
      m_pro(age,year) = mxt_prime(age,1)*exp(bet(age)*(k_t(year)-ktn));
    end
  end
  set(gca, 'XLimMode', 'auto', 'YLimMode', 'auto')
  %-------plotting  kappa-----
  figure('name', 'Kappa projected')
  x = dates(2)+1:dates(2)+n;
  for simu = 1:m
    plot(x,k_t(simu,:))
    hold on
  end
  plot(list_dates, kap)
  xlabel('Periodes'); ylabel('\kappa_{t}'); legend;
  %ylim([0 10])
  %-----------Plotting mortality rates-----------
  list_mx = zeros(1,length(list_dates));
  for date = list_dates
      list_mx(date-dates(1)+1) = Data.mx(find(Data.Year == date,1)+age_LOL);
  end
  
  figure('name', 'Mortality projected')
  for simu = 1:m
    plot(x,m_pro(simu,:), 'DisplayName', 'Simulation '+ string(simu))
    hold on
  end
  plot(list_dates, list_mx)
  xlabel('Periodes'); ylabel('\mu_{x}'); legend;
  %ylim([0 10])
end