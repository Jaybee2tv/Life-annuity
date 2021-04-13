function [prob] = p(age,t,alp,bet,kap_p,ages,dates,index_hist,date_of_age,gama)%ages=[age1 ages2]=range of ages
%We are considering people aging "age" at date_of_age
%give index of historical data,
%gama = percentage of death rate
  global Data
  index_age = age-ages(1);
  index_t = date_of_age-dates(1)+1;
  histo_data = dates(2)-date_of_age;
  i = 1;
  prop = 1;
  for ag= 1:t
    index_age = index_age+1;
    if ag<=histo_data %use historique kappa!!!!YOU MUST USE TRUE DATA, NOT MODEL FOR HISTORIC
      %prob = prop*exp(-exp(alp(index_age)+bet(index_age)*kap(index_t)));
      prob = prop*exp(-gama*Data.mx(index_hist(ag)+ag-1));
      index_t = index_t+1;
    else
      prob = prop*exp(-gama*exp(alp(index_age)+bet(index_age)*kap_p(i)));
      i = i+1;
    end
  end    
end