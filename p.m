function [prob] = p(age,t,alp,bet,kap_p,ages,index_hist,gama)%ages=[age1 ages2]=range of ages
%We are considering people aging "age" at date_of_age
%give index of historical data,
%gama = percentage of death rate
  global Data
  index_age = age-ages(1);
  histo_data = length(index_hist);
  i = 1;
  prob = 1;
  for ag= 1:t
    index_age = index_age+1;
    
    if ag<=histo_data %use historique kappa!!!!YOU MUST USE TRUE DATA, NOT MODEL FOR HISTORIC
      %prob = prop*exp(-exp(alp(index_age)+bet(index_age)*kap(index_t)));
      prob = prob*exp(-gama*Data.mx(index_hist(ag)+ag-1));
    else
       prob = prob*exp(-gama*exp(alp(index_age)+bet(index_age)*kap_p(i)));
      i = i+1;
    end
  end    
end