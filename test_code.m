clear all;
variables; % please run this part before everything
%% plotting death rate, Confidence inter, quantile... .Uncomment to see the plot
plot_tau([2000 2018], [0 109]) %remark we can put date as we want [2000 2018 2003]
%plot_quant()

%confidence_inter([2000,2018],50)% the person has 50 year in 2000
%%
date = [2000 2018]; 
age = [0 109]; %consider ages between [0 109] and dates [1920 2018] We can clearly see a linear trend starting from 1941 for kappa
%[f,fp] = f_alpha(0,k,1, date, age, 20); 
[alp, kap, bet] = leeCar_NR(date, age, 600, 1e-6); %if there's problem, plz increase max_iter

%% plotting residual 

[resi, squa] = residual(date, age, alp, bet, kap); %plot year, age etc...

%% Comparison LeeCar VS real death rate
compare(date,age, alp,bet,kap)