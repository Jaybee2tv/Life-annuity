function[kapup, kapdown] = boot_vs_proj(dates,t1,alp,bet,kap,kap_p_b,alp_b,bet_b,kap_b,k,cohor)
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
  %-----Project kappat and build Confinden Inter-------Construct rate after
  %projection
  k_tup= zeros(1,k);k_tdown = k_tup;
  mxt_up = zeros(1,k); mxt_down = zeros(1,k);
  mxt_k = zeros(1,k);
  index = dates(2)-dates(1)+1;
  for year = 1:k
    index = index+1;
    k_t(year) = ktn + year*d ;%+ random('norm',0,sqrt(sig_sq));
    k_tup(year) = ktn + year*d + sqrt(year*sig_sq)*z_alpha;
    k_tdown(year) = ktn + year*d - sqrt(year*sig_sq)*z_alpha;
    
    mxt_up(year) = exp(alp(index)+bet(index)*k_tup(year));
    mxt_down(year) = exp(alp(index) + bet(index)*k_tdown(year));
    mxt_k(year) = exp(alp(index) + bet(index)*k_t(year));
    
  end
  
  %---COnstruct rate before projection-----Historical rate-----
  index = cohor;
  mxt = zeros(1,length((dates(1)+cohor):dates(2)));
  for year = 1: length((dates(1)+cohor):dates(2))
    index = index +1;
    mxt(year) = exp(alp(index) + bet(index)*kap(index));
  end
  
  %-----Build IC from bootstrap---
  year_cohor = (dates(1)+cohor):(dates(2)+k); 
  kapup = zeros(1,length(year_cohor));
  kapdown = zeros(1,length(year_cohor));
  alpup = zeros(1,length(year_cohor)); alpdown = zeros(1,length(year_cohor));
  betup = zeros(1,length(year_cohor)); betdown = zeros(1,length(year_cohor));
  i = 1;
  mxtb_up = zeros(1,length(year_cohor));
  mxtb_down = zeros(1,length(year_cohor));
  index = cohor;
  for year = 1:length(year_cohor)% length(kap_p_b(1,:)=length(kap_p_b(2,:)...
    index = index+1;
    alpup(year) = quantile(alp_b(index,:),0.975);
    betup(year) = quantile(bet_b(index,:),0.975);
    
    alpdown(year) = quantile(alp_b(index,:),0.025);
    betdown(year) = quantile(bet_b(index,:),0.025);
    
    if(index<= height(kap_b))
      kapup(year) = quantile(kap_b(index,:),0.975);
      kapdown(year) = quantile(kap_b(index,:),0.025);
    else
      kapup(year) = quantile(kap_p_b(i,:),0.975);
      kapdown(year) = quantile(kap_p_b(i,:),0.025);
      i = i+1;
    end
    
    mxtb_up(year) = exp(alpup(year)+betup(year)*kapup(year));
    mxtb_down(year) = exp(alpdown(year)+betdown(year)*kapdown(year));
  end
  
  
  %-------plotting  kappas-----
  list_dates = dates(1):dates(2);
  figure('name', 'Kappa projected')
  x = dates(2)+1:dates(2)+k;
  plot(x,mxt_k, 'DisplayName','\rate_m_p')
  hold on
  plot((dates(1)+cohor):dates(2), mxt,'DisplayName','rate')
  hold on
  plot(x,mxt_up,'r','DisplayName','proj_up')
  hold on
  plot(x,mxt_down,'r','DisplayName', 'proj_down')
  hold on
  plot(year_cohor,mxtb_down,'g','DisplayName','boot')
  hold on
  plot(year_cohor,mxtb_up,'g','DisplayName','boot')
  xlabel('Année'); ylabel('\mu_{xt}'); legend;
  
  %ylim([0 10])
end

