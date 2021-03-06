%plot_tau([2000 2010])
%plot_quant()
clear all;
variables;
%confidence_inter([2000,2018],50)% the person has 50 year in 2000
date = [1960 1961];
age = [0 1];
%[f,fp] = f_alpha(0,k,1, date, age, 20);
[alp, kap, bet] = leeCar_NR(date, age, 1, 1e-6); 

%Fkappa gradit trop vite