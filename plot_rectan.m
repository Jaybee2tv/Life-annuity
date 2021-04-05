function plot_rectan(date)
  global Data
  dates_presente = 20;
  start_date_ind = zeros(1,dates_presente); %max 11 dates, populate to reduce computation cos 
  a = 1;
  for i = date
      start_date_ind(a) =  find(Data.Year == i,1);
      a = a+1;
  end
  for i= 1:length(date)
      deb = start_date_ind(i);
      fin = deb+109;
      plot(Data.Age(deb:fin),Data.lx(deb:fin),'DisplayName', string(date(i)))
      hold on
  end
  xlabel('Age'); ylabel('lx'); legend
  hold off
end