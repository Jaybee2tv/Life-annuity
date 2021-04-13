global Data z_alpha Death Expo date_lc date_cohort ages_lc t1_p k cohor tol max_iter B
Data = readtable('vrai_tab.txt');

Death = readtable('death_table.txt');
Expo = readtable('expo_table.txt');
z_alpha = 2.575;

date_cohort = [2000 2019]; cohor = 50; % 50years  in 2000 for cohorte thing 
date_lc = [1950 2019]; ages_lc = [0 104]; % for projection
t1_p = 1951; %date at wich kappa became is linear. for projection purpose. Must be between date_lc
k = 40; %horizon de projection, we are projecting k years. MAX 40years, bcoz if 41 we will consider age until 110

max_iter = 600; tol = 1e-6;
B = 5;