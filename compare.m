function compare(dates,cohorte, alp,bet,kap) %This function compare LeeCAR Death rate with crude death rate. date = [date1 date2 date3 ...], function will plot date1...daten
  global Data  % ages must be [a b] to specify range of interest
  %compare date1 crude and LEEcar death rates. Then compare date1 Crude vs
  %date2 LeeCar death rates
  if length(dates)~=2
    error('Ages must be [age1 age2]')
  end
  
  %construct log_mxt based on lee carter row= age, column= date
  age_lim = cohorte+dates(2)-dates(1);
  alp = alp(cohorte:age_lim);
  bet = bet(cohorte:age_lim);
  log_mxt = zeros(1,length(alp));
  for t = 1: length(alp)
    log_mxt(t) = alp(t) +bet(t)*kap(t); %LEECAR FORMULAE
  end
  %----retrive mx from data-----
  death_rate_xt = zeros(1,length(dates(1):dates(2)));
  for i = dates(1):dates(2)
    index_year = find(Data.Year==i,i-dates(1)+1);% retrieve index of year. 
    death_rate_xt(i-dates(1)+1) = Data.mx(index_year(i-dates(1)+1)+cohorte);
  end
  % Compare la même année
  differ = abs(mean(log_mxt)-mean(log(death_rate_xt)));
  figure('name', 'Comapraison LeeCar vs data. Cohorte = 50')
  plot(dates(1):dates(2),log(death_rate_xt),'DisplayName', 'Crude')
  hold on
  plot(dates(1):dates(2), log_mxt, 'DisplayName', 'LeeCar');
  %text(2002,-4.5,'mean diff = ' +string(differ))
  xlabel('Age'); ylabel('log(\mu_{x})'); 
  %compare 
    
end
