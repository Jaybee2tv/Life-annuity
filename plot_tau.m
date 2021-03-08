function plot_tau(dates,ages) %date = [date1 date2 date3 ...], function will plot date1...daten
  global Data 
  if length(ages) ~= 2
    error('ARRAY AGES MUST LOOK LIKE [age1 age2]')
  end
  start_date_ind = zeros(1,length(dates)); %max 11 dates, populate first to reduce computational cost
  a = 1;
  for i = dates
      start_date_ind(a) =  find(Data.Year == i,1);
      a = a+1;
  end
  figure('name', 'Taux de mortalité')
  for i= 1:length(dates)
      deb = start_date_ind(i)+ages(1);
      fin = start_date_ind(i)+ages(2);
      plot(Data.Age(deb:fin),log(Data.mx(deb:fin)),'DisplayName', string(dates(i)))
      hold on
  end
  xlabel('Age'); ylabel('log(\mu_{x})'); legend
end
