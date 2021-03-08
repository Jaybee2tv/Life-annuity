global Data z_alpha Death Expo date_lc date_cohort ages_lc t1_p k cohor
Data = readtable('vrai_tab.txt');

Death = readtable('death_table.txt');
Expo = readtable('expo_table.txt');
z_alpha = 2.575;

date_cohort = [2000 2019]; cohor = 50; % 50years  in 2000 for cohorte thing 
date_lc = [1920 2019]; ages_lc = [0 109]; % for projection
t1_p = 1960; %date at wich kappa became linear. for projection purpose. Must be between date_lc
k = 25; %horizon de projection 
