function [m_pro, k_t] = projection(dates,ages,n,t1,bet, kap)% project in n year, m=number of simulation
% Give t1, i.e year in wich kappa show linear trend
  global Data z_alpha
  age_LOL = 100; % age at which we plot mortality
  list_ages = ages(1):ages(2);
  list_dates = dates(1):dates(2);
  k_t = zeros(1,n);% simulations in row for year n 
  ktn = kap(length(kap)); %the last kappa
  t_line = (t1-dates(1));
  d = (kap(length(kap))- kap(t1-dates(1)))/(length(kap)-t_line);
  sig_sq = 0;
  %------Estimating d and sigma_square-----
  for t = t_line+1:length(kap)
    sig_sq = sig_sq + (kap(t)-kap(t-1)-d)^2;
  end
  sig_sq = sig_sq/(length(kap)-t_line);
  %-----Project kappat and build Confinden Inter-------
  k_tup= zeros(1,n);k_tdown = k_tup;
  for year = 1:n
    k_t(year) = ktn + year*d;
    k_tup(year) = k_t(year) + sqrt(year*sig_sq).*z_alpha;
    k_tdown(year) = k_t(year) - sqrt(year*sig_sq).*z_alpha;
  end
  
   %------Projecting death------
  m_pro = zeros(length(list_ages),n );
  mxt_prime = zeros(length(list_ages),1);
  m_pro_up = zeros(length(list_ages), n); m_pro_down = zeros(length(list_ages), n); 
  for age = ages(1):ages(2)
    mxt_prime(age-ages(1)+1,1) = Data.mx(find(Data.Year==dates(2),1)+age);
  end
  for age = 1:length(list_ages)
    for year = 1:n
      m_pro(age,year) = mxt_prime(age,1)*exp(bet(age)*(k_t(year)-ktn));
      m_pro_up(age,year) = mxt_prime(age,1)*exp(bet(age)*(k_tup(year)-ktn));
      m_pro_down(age,year) = mxt_prime(age,1)*exp(bet(age)*(k_tdown(year)-ktn));
    end
  end
  
  %-------plotting  kappa-----
  figure('name', 'Kappa projected')
  x = dates(2)+1:dates(2)+n;
  plot(x,k_t, 'DisplayName','\kappa mean')
  hold on
  plot(list_dates, kap,'DisplayName','kappa')
  hold on
  plot(x,k_tup,'DisplayName','k_tup')
  hold on
  plot(x,k_tdown,'DisplayName', 'k_tdown')
  xlabel('Periodes'); ylabel('\kappa_{t}'); legend;
  %ylim([0 10])
  %-----------Plotting mortality rates-----------
  list_mx = zeros(1,length(list_dates));
  for date = list_dates
      list_mx(date-dates(1)+1) = Data.mx(find(Data.Year == date,1)+age_LOL);
  end
  
  figure('name', 'Mortality projected')
  plot(list_dates, list_mx,'DisplayName', '\mu_{x}')
  hold on
  plot(x, m_pro(age_LOL+1,:),'DisplayName', 'mean \mu_x ')
  hold on
  plot(x, m_pro_up(age_LOL+1,:),'DisplayName', '\mu_{x}up ')
  hold on
  plot(x, m_pro_down(age_LOL+1,:),'DisplayName', '\mu_{x}down ')
  xlabel('Periodes'); ylabel('\mu_{x}'); legend;
  %ylim([0 10])
end