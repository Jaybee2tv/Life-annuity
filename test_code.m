clear all; close all
variables; % please run this part before everything
global  date_lc date_cohort ages_lc t1_p k cohor
%% plotting death rate, Confidence inter, quantile... .Uncomment to see the plot
plot_tau([1950 2019], [0 109]) %remark we can put date as we want Attention. 
plot_quant() 
confidence_inter(date_cohort,cohor)% the person has 50 year in 2000
%% 
[alp, kap, bet] = leeCar_NR(date_lc, ages_lc, 600, 1e-6); %if there's problem, plz increase max_iter

%% plotting residual 

[resi, squa] = residual(date_lc, ages_lc, alp, bet, kap); %plot year, age etc...

%% Comparison LeeCar VS real death rate

kap_compare = kap(date_cohort(1)-date_lc(1):end); %will give elem starting from date crude

compare(date_cohort,cohor, alp,bet,kap_compare)

%% Projecting
[m_pro, k_t] = projection(date_lc,ages_lc,k,t1_p,bet, kap);

