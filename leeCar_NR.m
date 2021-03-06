function [alp,kap,bet] = leeCar_NR(dates, ages,max_iter, tol)
  alp = zeros(1,length(ages(1):ages(2)));
  kap = zeros(1,length(dates(1):dates(2)));
  bet = ones(1,length(ages(1):ages(2)));
  list_age = [ages(1):ages(2)];
  list_period = [dates(1):dates(2)];
  
  for i = 1:max_iter
    if i ==max_iter
      fprintf('NO PARAM FOUND')
      alp = 0;bet = 0;kap = 0;
    else
      alp_p = alp;
      bet_p = bet;
      kap_p = kap;
      for age = 1:length(list_age)
        [f_a,fp_a] = f_alpha(alp(age),kap,bet(age),dates,list_age,list_age(age));
        alp(age) = alp(age) + f_a/fp_a;
        alp = alp + bet*mean(kap);
      end
      for period = 1:length(list_period)
        [f_k,fp_k] = f_kappa(alp,kap(period),bet,dates,list_age,list_period(period));
        kap(period) = kap(period) + f_k/fp_k;
      end
      for age = 1:length(list_age)
        [f_b,fp_b] = f_beta(alp(age),kap,bet(age),dates,list_age,list_age(age));
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
  
  figure('name','ALPHA')
  plot(list_age,alp)
  ylabel('\alpha_{x}')
  xlabel('ages')
  
  figure('name','BETTTA')
  plot(list_age,bet)
  ylabel('\beta_{x}')
  xlabel('ages')
  
  figure('name','KAPPA')
  plot(list_period,kap)
  ylabel('\kappa_{x}')
  xlabel('periodes')
    
end