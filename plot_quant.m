function plot_quant()
  global Data
  
  date = [2000:2019];
  dates_presente = 20;
  start_date_ind = [zeros(0,dates_presente)];
  a = 1;
  for i = date
      start_date_ind(a) =  find(Data.Year == i,1);
      a = a+1;
  end
  med = zeros(1,dates_presente);
  quant = zeros(1,dates_presente);
  for i= 1:length(date)
      deb = start_date_ind(i);
      fin = deb+109;
      quant(i) = quantile(Data.lx(deb:fin),0.75)-quantile(Data.lx(deb:fin),0.25);
      med(i) = median(Data.lx(deb:fin));
  end
  figure('name','Inter Quantile')
  plot(date, quant,'o-')
  xlabel('Periodes'); ylabel('IRQ');
  figure('name','Median');
  plot(date, med,'o-') %find median age as in the course? plot(age,lx) then find put the median
  xlabel('Periodes'); ylabel('Median');

end