%% Init
clear, clc;
close all

%% Farmakokinetika
DATA = csvread("Dat_FK.csv",2,0);

TI = 44.55;
ki = 0.1645;
VI = 138.8;

DATA_t = DATA(:,1);
DATA_I = DATA(:,2)/6;
 
v_b = 281.218;
S1b = v_b * TI;
S2b = S1b;
I_b = S2b/(TI*ki*VI);


%% Farmakodynamika

V_G = 1.467;

p2 = 0.0106;
S_I = 0.00159;
S_G = 0;
G_INIT = 153;

global G_b

G_b = 8.5;

DATA = csvread("Dat_FD.csv",2,0);

DATA_t = DATA(:,1);
DATA_RA = DATA(:,2)/64.5;

time = 0:1:DATA_t(end);
DATA_RA_inter = interpn(DATA_t,DATA_RA,time);

RA = timeseries(DATA_RA_inter, time);

figure(1), hold on, grid on;
plot(DATA_t, DATA_RA,'o')
plot(time, DATA_RA_inter,'-')
title('Prisun glukozy')
ylabel('Glukoza')
xlabel('Cas')

plot(DATA_t,DATA_RA,'o',time,DATA_RA_inter,':.');

fun = @find_params;
x0 = [p2 S_I];

options = optimset('PlotFcns',@optimplotfval);
x = fminsearch(fun, x0, options);

p2B = x(1);
S_IB = x(2);

out = sim('cv5_model');
figure;
plot(G, ':.');
hold on;
plot(time,G_b, '.');
title('Glykemia')
ylabel('Glukoza')
xlabel('Cas')

