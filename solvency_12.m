function [scr,m_d_BOF] = solvency_12(apv_nd,apv)
%apv_nd is from undifferenciation
% To calculate BE_t, note that "ce qui reste à recevoir" has 5000 values
% bcoz of different simulation
% apv is a list containing PV of future benefits outgo: "ce qui reste à
% payer en t". 
  capital = 1+0.005;
  actual = 1/(1+0.01);
  
  A_12 = mean(apv_nd).*(capital^(12)) - (1+capital+capital^2);
  BE_12 =  apv(1,:)-0; % a62
  BOF_12 = A_12 - BE_12;
  
  A_13 = mean(apv_nd).*(capital^(13)) - (1+capital+(capital^2)+(capital^3));
  BE_13 = apv(2,:); % a63
  BOF_13 = A_13 - BE_13;
  % DELTA BOF
  m_d_BOF = BOF_12 - BOF_13./actual;
  m_d_BOF(m_d_BOF<0) = 0;
  
  scr = quantile(m_d_BOF,0.995);
  
end
