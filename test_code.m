%plot_tau([2000 2010])
%plot_quant()
clear all;
variables;
%confidence_inter([2000,2018],50)% the person has 50 year in 2000
date = [1920 2018]; 
age = [0 109]; %consider ages between [0 109] and dates [1920 2018] We can clearly see a linear trend starting from 1941 for kappa
%[f,fp] = f_alpha(0,k,1, date, age, 20); 
[alp, kap, bet] = leeCar_NR(date, age, 600, 1e-6); %if there's problem, plz increase max_iter

%% plotting residual 

[resi, squa] = residual(date, age, alp, bet, kap); %plot year, age etc...