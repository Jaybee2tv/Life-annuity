function confidence_inter(dates,cohorte) %years of interest[2000 2019], cohorte (birthday at dates[1]
  global Data Death z_alpha
  format short
  death_rate_xt = zeros(1,20);% data from 2000 to 2019
  ages = zeros(1,length(dates(1):dates(2)));
  death = zeros(1,20);
  date1 = dates(1)-1;
  for i = dates(1):dates(2)
    index_year = find(Data.Year==i,i-date1);% retrieve index of year. 
    index_death_year = find(Death.Year==i,i-date1); %this is useless as we can use index_year for same purpose, but we do it in order to separate file 
    death_rate_xt(i-date1) = Data.mx(index_year(i-date1)+cohorte);
    ages(i-date1) = Data.Age(index_year(i-date1)+cohorte);
    death(i-date1) = Death.Female(index_death_year(i-date1)+cohorte);
  end
  
  var_death_rates = (death_rate_xt.^2)./death;
  ic_up = death_rate_xt + sqrt(var_death_rates).*z_alpha;
  ic_down = death_rate_xt - sqrt(var_death_rates).*z_alpha;
  plot(dates(1):dates(2), death_rate_xt,'DisplayName', 'rate')
  hold on
  plot(dates(1):dates(2), ic_up,'DisplayName', 'High')
  hold on 
  plot(dates(1):dates(2), ic_down,'DisplayName', 'down')
  
   
  
end