clear all; close all
variables; % please run this part before everything
global  date_lc date_cohort ages_lc t1_p k cohor tol max_iter B
%% plotting death rate, Confidence inter, quantile... .Uncomment to see the plot
plot_tau([2000 2019], [0 109]) %remark we can put date as we want Attention. 
plot_quant() 
confidence_inter(date_cohort,cohor);% the person has 50 year in 2000;
%plot_rectan([2000 2019])
%% Leecar
[alp, kap, bet] = leeCar_NR(date_lc, [0 109], max_iter,tol); %if there's problem, plz increase max_iter

%% plotting residual 

[resi, squa] = residual(date_lc, ages_lc, alp, bet, kap); %plot year, age etc...

%% Comparison LeeCar VS real death rate

kap_compare = kap(date_cohort(1)-date_lc(1):end); %will give elem starting from date crude

compare(date_cohort,cohor, alp,bet,kap_compare)

%% BootstrapingSECTION TITLE
% DESCRIPTIVE TEXTSECTION TITLE
% DESCRIPTIVE TEXT
[alp_b,bet_b,kap_b,kap_p_b] = bootstrap(B,date_lc,ages_lc,max_iter, tol,k,t1_p);
%--extract age and time of the cohort------
ag = 65;
alph = alp_b(ag-ages_lc(1):end,:);
betha = bet_b(ag-ages_lc(1):end,:);
date_cohor = (date_lc(2)-date_lc(1)+1)-(-2015+date_lc(2));
kapha = kap_b(date_cohor:end,:);
%% expected life time
ext = expected_life_cohor(alph,betha,kapha,kap_p_b,B); %you have to finish this by adding last sum

%% Projecting
[m_pro, kap_pro] = projection(date_lc,ages_lc,k,t1_p,bet, kap,60);
%% Plot IC for kappa and diff tranjectories
N = 5000;
[ma, kap_pro_n]=multiple_path(date_lc,ages_lc,k,N,t1_p,bet, kap,50); %plus sigma est grand, plus il y'a du bruit
%50 years in 2000
%% Bootstrap vs Projection
[mxt_b_p] = boo_vs_pro(B,date_lc,t1_p,k,cohor,alp,bet,kap,alp_b,bet_b,kap_b);
%[ku ,kd] = boot_vs_proj(date_lc,t1_p,alp,bet,kap,kap_p_b,alp_b,bet_b,kap_b,k,50);
%% TARIFICATIONNNN: Strange The APV for non smoking people is high
%pro =  p(50,10,alp,be,kap_pro,ages_lc,date_lc); %no need for kap bcoz we
%have historical data. YOOOOO. Pay attention, you need to project for
%minimum 35 year
%years
[vap,moy] = rente_diff(0.02,2000,2010,50,alp,bet,kap_pro_n,ages_lc,date_lc,1);
%%
[apv_f,moy_f] = rente_diff(0.02,2000,2010,50,alp,bet,kap_pro_n,ages_lc,date_lc,1.15);
%%
[apv_nf,moy_nf] = rente_diff(0.02,2000,2010,50,alp,bet,kap_pro_n,ages_lc,date_lc,0.90);

%% Solvency: calculate for SCR. You need to calculate the rigth annuity for the right SCR_0 or SCR_12
%apv_nd = tarification(0.02,2000,2010,50,alp,bet,kap_pro,ages_lc,date_lc,1);
apv = [rente_diff(0.02,2012,2012,62,alp,bet,kap_pro_n,ages_lc,date_lc,1.15); rente_diff(0.02,2013,2013,63,alp,bet,kap_pro_n,ages_lc,date_lc,1.15)];
%% SCR_0
[scr, m_dBOF] = solvency(vap,apv);
%% SCR_12
[scr_12, m_dBOF_12] = solvency_12(vap,apv);


