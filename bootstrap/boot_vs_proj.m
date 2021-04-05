function[kbup, kbdown] = boot_vs_proj(dates,t1,kap_p_b,kap,k,cohor)
  z_alpha = 1.96;
  k_t = zeros(1,k);% simulations in row for year n 
  ktn = kap(length(kap)); %the last kappa
  t_line = (t1-dates(1));
  d = (kap(length(kap))- kap(t1-dates(1)))/(length(kap)-t_line);
  sig_sq = 0;
  %------Estimating sigma_square-----
  for t = t_line+1:length(kap)
    sig_sq = sig_sq + (kap(t)-kap(t-1)-d)^2;
  end
  sig_sq = sig_sq/(length(kap)-t_line);
  %-----Project kappat and build Confinden Inter-------
  k_tup= zeros(1,k);k_tdown = k_tup;
  for year = 1:k
    k_t(year) = ktn + year*d ;%+ random('norm',0,sqrt(sig_sq));
    k_tup(year) = ktn + year*d + sqrt(year*sig_sq)*z_alpha;
    k_tdown(year) = ktn + year*d - sqrt(year*sig_sq)*z_alpha;
  end
  %-----Build IC from bootstrap---
  kbup = zeros(1,k);
  kbdown = kbup;
  for year = 1:k% length(kap_p_b(1,:)=length(kap_p_b(2,:)...
    kbup(year) = quantile(kap_p_b(year,:),0.975);
    kbdown(year) = quantile(kap_p_b(year,:),0.025);
  end
  
  %-------plotting  kappas-----
  list_dates = dates(1):dates(2);
  figure('name', 'Kappa projected')
  x = dates(2)+1:dates(2)+k;
  plot(x,k_t, 'DisplayName','\kappa mean')
  hold on
  plot(list_dates(cohor+1:end), kap(cohor+1:end),'DisplayName','kappa')
  hold on
  plot(x,k_tup,'r','DisplayName','proj')
  hold on
  plot(x,k_tdown,'r','DisplayName', 'proj')
  hold on
  plot(x,kbup,'g','DisplayName','boot')
  hold on
  plot(x,kbdown,'g','DisplayName','boot')
  xlabel('Année'); ylabel('\kappa_{t}'); legend;
  
  %ylim([0 10])
end

