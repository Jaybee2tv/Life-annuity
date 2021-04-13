function [scr,d_BOF] = solvency(apv_nd,apv,N)
%apv_nd is from undifferenciation
% To calculate BE_t, note that "ce qui reste à recevoir" has 5000 values
% bcoz of different simulation
% apv is a list containing PV of future benefits outgo: "ce qui reste à
% payer en t". 
  capital = 1+0.04;
  actual = 1/(1+0.01);
  
  A_0 = apv_nd;
  BE_0 =  apv(1:N)-0; % 10|a_50
  BOF_0 = A_0 - BE_0;
  
  A_1 = A_0*capital;
  BE_1 = apv(N+1:end); 
  BOF_1 = A_1 - BE_1;
  % DELTA BOF
  d_BOF = BOF_0 - BOF_1./actual;
  d_BOF(d_BOF<0) = 0;
  
  scr = quantile(d_BOF,0.995);
  
end
