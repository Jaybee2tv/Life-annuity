function [m_pro, k_t] = projection(dates,ages,n,t1,bet, kap,cohor)% project in n year, m=number of simulation
%Note: bet,kap must come from LeeCar estimatimation not from bootstrap
%kap_p (kappa projected) must come from LeeCar
% Give t1, i.e year in wich kappa show linear trend
%This will project kappa, death rate
%Evaluate confidence interval on kappa death rate
  global Data 
  z_alpha = 1.96;
  list_ages = ages(1):ages(2);
  list_dates = dates(1):dates(2);
  k_t = zeros(n,1);% simulations in row for year n 
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
    k_tup(year) = ktn + year*d + sqrt(year*sig_sq).*z_alpha;
    k_tdown(year) = ktn + year*d - sqrt(year*sig_sq).*z_alpha;
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
  plot(list_dates(cohor+1:end), kap(cohor+1:end),'DisplayName','kappa')
  hold on
  plot(x,k_tup,'DisplayName','k_tup')
  hold on
  plot(x,k_tdown,'DisplayName', 'k_tdown')
  xlabel('Année'); ylabel('\kappa_{t}'); legend;
  %ylim([0 10])
  %-----------Plotting mortality rates-----------
  list_d = (dates(1)+cohor):dates(2);
  list_mx = zeros(1,length(list_d));
  i = 0;
  for date = list_d
      i = i+1;
      list_mx(i) = Data.mx(find(Data.Year == date,1)+cohor+i-1);
  end
  a = cohor+length(list_d);
  figure('name', 'Mortality projected')
  plot(list_d, log(list_mx),'DisplayName', '\mu_{x}')
  hold on
  plot(x, log(diag(m_pro,-(a))),'DisplayName', 'mean \mu_x ')
  hold on
  plot(x, log(diag(m_pro_up,-(a))),'r','DisplayName', '\mu_{x}up ')
  hold on
  plot(x, log(diag(m_pro_down,-(a))),'r','DisplayName', '\mu_{x}down ')
  xlabel('Periodes'); ylabel('\mu_{x}'); legend;
  xlim([dates(1)+cohor 2050])
  %ylim([0 10])
end