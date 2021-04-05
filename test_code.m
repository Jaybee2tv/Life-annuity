clear all; close all
variables; % please run this part before everything
global  date_lc date_cohort ages_lc t1_p k cohor tol max_iter B
%% plotting death rate, Confidence inter, quantile... .Uncomment to see the plot
plot_tau([2000 2019], [0 109]) %remark we can put date as we want Attention. 
plot_quant() 
confidence_inter(date_cohort,cohor)% the person has 50 year in 2000
%plot_rectan([2000 2019])
%% Leecar
[alp, kap, bet] = leeCar_NR(date_lc, ages_lc, max_iter,tol); %if there's problem, plz increase max_iter

%% plotting residual 

[resi, squa] = residual(date_lc, ages_lc, alp, bet, kap); %plot year, age etc...

%% Comparison LeeCar VS real death rate

kap_compare = kap(date_cohort(1)-date_lc(1):end); %will give elem starting from date crude

compare(date_cohort,cohor, alp,bet,kap_compare)

%% Bootstraping
cd bootstrap
[alp_b,bet_b,kap_b,kap_p_b] = bootstrap(B,date_lc,ages_lc,max_iter, tol,k,t1_p);
%--extract age and time of the cohort------
ag = 65;
alph = alp_b(ag-ages_lc(1):end,:);
betha = bet_b(ag-ages_lc(1):end,:);
date_cohor = (date_lc(2)-date_lc(1)+1)-(-2015+date_lc(2));
kapha = kap_b(date_cohor:end,:);
ext = expected_life_cohor(alph,betha,kapha,kap_p_b,B); %you have to finish this by adding last sum

%% Projecting
[m_pro, k_t] = projection(date_lc,ages_lc,k,t1_p,bet, kap,60);
%% Plot IC for kappa and diff tranjectories
multiple_path(date_lc,ages_lc,k,50,t1_p,bet, kap,50); %plus sigma est grand, plus il y'a du bruit
%50 years in 2000
%% Bootstrap vs Projection
[ku ,kd] = boot_vs_proj(date_lc,t1_p,kap_p_b,kap,k,50);


