function [vap,vr] = tarification(taux,sub_year,start_year,age,alp,bet,kap_p,ages,dates,gama)% deferred annuity: subcription on sub_year and start 
%start_year;
%  gama is to consider percentage of death rate: e.g: gama = 0.9 mean
%  people are dying 10% less than normal
%----------
  global Data
  
  v = 1/(1+taux);
  vap = zeros(1,length(kap_p(1,:))); vr = 0;
  t = start_year-sub_year;
  t1 = 109-age;
  date_of_age = start_year;
  histo_data = dates(2)-date_of_age;
  % -----Extract historical death rate-------
  index_hist = zeros(1,histo_data);
  for year=date_of_age:dates(2)
    index_hist(year-date_of_age+1) = find(Data.Year == year,1)+age; %index of peaple aged 50
  end
  %-------Compute APV ----
  for simu = 1:length(kap_p(1,:)) %for all simulation of kappa
    prime = 0;
    for i = t:t1 %bcoz people will not survive at 109
      prime = prime+ (v^i) * p(age,i,alp,bet,kap_p(:,simu),ages,dates,index_hist,date_of_age,gama);
    end
    vap(simu) = prime;
  end
end
