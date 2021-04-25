function [mxt_b_p] = boo_vs_pro(B,dates,t1,k,cohor,alp,bet,kap,alp_b,bet_b,kap_b)
  
%-----simulate projected kappa for each bootstrap sample----
  t_line = (t1-dates(1));
  kap_p = zeros(k,B*B); % the first Bs column represent the first bootstrap param
  mxt_b_p = zeros(k,B*B);% projected rate for each bootstrap and simulation
  year_cohor = (dates(1)+cohor):(dates(2))+1;
  star_i = cohor;
  end_i = star_i + length(year_cohor)-1;
  %mxt_b = zeros(length(year_cohor),B);
  logmxb = alp_b(star_i:end_i,:) + bet_b(cohor:end_i,:).*kap_b(cohor:end,:);
  mxt_b = exp(logmxb);
  logmx =  alp(star_i:end_i) + bet(cohor:end_i).*kap(cohor:end);
  mxt = exp(logmx);
  
  %plot(mxt_b)
  column = 1;
  for b = 1:B
    ka = kap_b(:,b);
    n = length(ka);
    ktn = ka(n);
    sig_sq = 0;
    d = (ktn- ka(t_line))/(n-t_line);
    for t = t_line+1:n
      sig_sq = sig_sq + (ka(t)-ka(t-1)-d)^2;
    end
    sig_sq = sig_sq/(n-t_line);
    kap_p(1,:) = ktn + d + random('norm',0,sqrt(sig_sq),1,B*B);
    for sim = column:(column+B-1)
      index = dates(2)-dates(1)+1;
      for year = 2:k
        index = index+1;
        kap_p(year,sim) = kap_p(year-1,sim) + d + random('norm',0,sqrt(sig_sq));
        mxt_b_p(year,sim) = exp(alp_b(index,b) + bet_b(index,b)*kap_p(year,sim));
      end
    end
    column = column+B;
  end
  
  %----NOW simulate B trajectories of leecar param in order to extract quantile--
  
  k_t = zeros(k,B);% simulations in row for year n 
  ktn = kap(length(kap)); %the last kappa
  t_line = (t1-dates(1));
  d = (kap(length(kap))- kap(t1-dates(1)))/(length(kap)-t_line);
  sig_sq = 0;
  mxt_p = zeros(k,B);
       %------Estimating sigma_square-----
  for t = t_line+1:length(kap)
    sig_sq = sig_sq + (kap(t)-kap(t-1)-d)^2;
  end
  sig_sq = sig_sq/(length(kap)-t_line);
  k_t(1,:) = ktn + d + random('norm',0,sqrt(sig_sq),1,B);
  for sim = 1:B
    index = dates(2)-dates(1)+1;
    for year = 2:k
      index = index+1;
      k_t(year,sim) = k_t(year-1,sim) + d + random('norm',0,sqrt(sig_sq));
      mxt_p(year,sim) = exp(alp(index) + bet(index)*k_t(year,sim));
    end
  end
  
   %----extract quantile------
  ic_bp_up = zeros(1,k);
  ic_bp_down = zeros(1,k);
  ic_up = zeros(1,length(year_cohor));
  ic_down = zeros(1,length(year_cohor));
  ic_p_up = zeros(1,k);
  ic_p_down = zeros(1,k);
  for year = 1:k
    ic_bp_down(year) = quantile(mxt_b_p(year,:),0.025);
    ic_bp_up(year) = quantile(mxt_b_p(year,:),0.975);
    ic_p_down(year) = quantile(mxt_p(year,:),0.025);
    ic_p_up(year) = quantile(mxt_p(year,:),0.975);
    
  end
  for year = 1:length(year_cohor)
    ic_down(year) = quantile(mxt_b(year,:),0.025);
    ic_up(year) = quantile(mxt_b(year,:),0.975);
  end
   x = dates(2)+1:dates(2)+k;
  figure('name', 'IC COMPARISON')
  plot(year_cohor,log(mxt))
  hold on
  plot(year_cohor,log(ic_up),'red','DisplayName', 'model')
  hold on
  plot(year_cohor,log(ic_down),'red', 'DisplayName', 'model')
  hold on
  plot(x,log(ic_bp_down),'red', 'DisplayName', 'model+project')
  hold on 
  plot(x,log(ic_bp_up),'red', 'DisplayName', 'model+project')
  hold on 
  plot(x,log(ic_p_up),'green','DisplayName', 'project')
  hold on 
  plot(x,log(ic_p_down),'green','DisplayName','project')
  
  
   
  
%   star_i_p = end_i+1;
%   end_i_p = star_i_p +k;
%   a = 1;
%   for sim = B:B:B*B
%       length(alp_b(star_i_p:end_i_p,:))
%     mxt_b_p(:,a:sim) = alp_b(star_i_p:end_i_p,:) + bet_b(star_i_p:end_i_p,:).*kap_p(:,a:sim);
%     a = a+B;
%   end
%   
  %------Evaluate death rate for the cohorte-----
  
  

end 