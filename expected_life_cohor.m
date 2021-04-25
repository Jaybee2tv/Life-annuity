function[e_xt] =  expected_life_cohor(alp,bet,kap,kap_p,B) %max age = 109
  %-----Evaluate death rates for each bootstrap sample---
  m_xt = zeros(length(kap(:,1))+length(kap_p(:,1)), B);
  %----compute non projected death rate----
  for sim = 1:B 
    for t = 1:length(kap(:,1)) %length(kap(:,1))=length(kap(:,2))=...
      m_xt(t,sim) = exp(alp(t,sim) +bet(t,sim)*kap(t,sim)); %LEECAR FORMULAE     
    end
  end
  %----compute projected death rate----
  for sim = 1:B 
    for t = 1:length(kap_p(:,1)) %length(kap(:,1))=length(kap(:,2))=...
      m_xt(t+length(kap(:,1)),sim) = exp(alp(t+length(kap(:,1)),sim) +bet(t+length(kap(:,1)),sim)*kap_p(t,sim)); %LEECAR FORMULAE     
    end
  end
  %----Compute expected life cohort---
  e_xt = zeros(1,B);
  
  for sim = 1:B
    cumul_mu = 0;
    a = 0;
    for t = 1:length(m_xt(:,1))-1
      cumul_mu = cumul_mu + m_xt(t,sim);
      a = a+ exp(-cumul_mu)*((1-exp(-m_xt(t+1,sim)))/(m_xt(t+1,sim)));
    end
    e_xt(sim) = a + (1-exp(-m_xt(1,sim)))/m_xt(1,sim);
  end
  figure('name','Expected');
  hist(e_xt);
end
      
      
      
      
   