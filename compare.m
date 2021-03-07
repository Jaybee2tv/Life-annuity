function compare(dates,ages, alp,bet,kap) %This function compare LeeCAR Death rate with crude death rate. date = [date1 date2 date3 ...], function will plot date1...daten
  global Data % ages must be [a b] to specify range of interest
  %compare date1 crude and LEEcar death rates. Then compare date1 Crude vs
  %date2 LeeCar death rates
  if length(ages)~=2 &&length(dates)~=2
    error('Ages must be [age1 age2]')
  end
  
  start_date_ind = zeros(1,length(dates)); 
  a = 1;
  for i = dates
      start_date_ind(a) =  find(Data.Year == i,1);
      a = a+1;
  end
  
  %construct log_mxt based on lee carter row= age, column= date
  log_mxt = zeros(length(ages(1):ages(2)),length(dates(1):dates(2)));
  for age = 1:length(ages(1):ages(2))
    for year = 1:length(dates(1):dates(2))
      log_mxt(age,year) = alp(age) +bet(age)*kap(year); %LEECAR FORMULAE
    end
  end
  % Compare la même année
  figure('name', 'Comapraison LeeCar vs data. Même date')
  deb = start_date_ind(1)+ages(1); %date1
  fin = start_date_ind(1)+ages(2);
  plot(Data.Age(deb:fin),log(Data.mx(deb:fin)),'DisplayName', 'Crude')
  hold on
  plot(ages(1):ages(2), log_mxt(:,1), 'DisplayName', 'LeeCar');
  text(40,-2,string(dates(1)))
  xlabel('Age'); ylabel('log(\mu_{x})'); legend
  
  %Compare 2 different year. date1 for crude and date2 for LeeCar
  figure('name', 'Comapraison LeeCar vs data. Different Year')
  deb = start_date_ind(1)+ages(1);
  fin = start_date_ind(1)+ages(2);
  plot(Data.Age(deb:fin),log(Data.mx(deb:fin)),'DisplayName', 'Crude ' +string(dates(1)))
  hold on
  t = dates(2)-dates(1)+1;
  plot(ages(1):ages(2), log_mxt(:,t), 'DisplayName', 'LeeCar '+ string(dates(2)));
  xlabel('Age'); ylabel('log(\mu_{x})'); legend
  
  
end
