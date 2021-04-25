function [vap,moy] = rente_diff(taux,sub_year,start_year,age,alp,bet,kap_p,ages,dates,gama)% deferred annuity: subcription on sub_year and start 
%start_year = start of benefit paiement;
%  gama is to consider percentage of death rate: e.g: gama = 0.9 mean
%  people are dying 10% less than normal
%----------
  global Data
  
  v = 1/(1+taux);
  vap = zeros(1,length(kap_p(1,:)));
  t = start_year-sub_year;
  t1 = ages(2)-age;
  histo_data = dates(2)-sub_year; %2019-2000
  % -----Extract historical death rate-------
  index_hist = zeros(1,histo_data);
  for year=sub_year:dates(2)
    index_hist(year-sub_year+1) = find(Data.Year == year,1)+age; %index of peaple aged 50
  end
  %p(50,aaa,alp,bet,kap_p,ages,dates,index_hist,start_year,gama)
  %-------Compute APV ----
  for simu = 1:length(kap_p(1,:)) %for all simulation of kappa
    prime = 0;
    for i = t:(t1-1) %bcoz people will not survive after 104
        aa = p(age,i,alp,bet,kap_p(:,simu),ages,index_hist,gama);
      prime = prime+ (v^i) * p(age,i,alp,bet,kap_p(:,simu),ages,index_hist,gama);
    end
    vap(simu) = prime;
  end
  moy = mean(vap);
  figure('Name', 'VAP')
  plot(vap)
  xlabel('simulation')
  ylabel('VAP(€)')
end
