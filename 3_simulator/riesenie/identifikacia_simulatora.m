close all;
clear;
clc;


figure(4);
hold on;
yyaxis left;
plot(Ra, 'b.');ylabel('Ra(t) [mg/kg/min]');
yyaxis right;
plot(dt, 'r', 'linewidth', 2);ylabel('d(t) [\muU/kg/min]');
xlabel('čas [min]');
set(gca, 'XTickLabel', [400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600])
%set(gca, 'XTickLabel', [400 600 800 1000 1200 1400 1600])
%--------------------------------------------------------------------------
figure(5);
hold on;
yyaxis left;
plot(It, 'b.');ylabel('I(t) [\muU/ml]');
yyaxis right;
plot(vt, 'r', 'linewidth', 2);ylabel('v(t) [\muU/kg/min]');
xlabel('čas [min]');
set(gca, 'XTickLabel', [400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600])
%--------------------------------------------------------------------------
DATA_sensor = csvread("CGM_data_den1_D00/Dat_D01_sensor.csv");
sensor_t = DATA_sensor(:,1);
sensor_vt = DATA_sensor(:,2);
DATA_calbg = csvread("CGM_data_den1_D00/Dat_D01_CalBG.csv");
calbg_t = DATA_calbg(:,1);
calbg_vt = DATA_calbg(:,2); 

% %sensor_time = 0:1:sensor_t(end);
% sensor_time = 0:1:1440;
dt_interpol = interpn(sensor_t, sensor_vt, sensor_time);
% %dt = timeseries(dt_interpol, sensor_time);
% figure(1);
% hold on;
% grid on;
% plot(sensor_t, sensor_vt, 'bo');
% plot(sensor_time, dt_interpol,'.');

%x = linspace(400,1,1440);
%tiledlayout(2,2) % Requires R2019b or later

sensor_time = 400:1:1440;
% Top plot
%ax1 = nexttile([1 2]);


f1 = figure(1);
grid on;
%hold on;
plot(sensor_t(81:end), sensor_vt(81:end), 'bo',...
    sensor_time, dt_interpol,'k.', ...
    calbg_t, calbg_vt, 'rs');
legend('CGM', 'interpolované CGM', 'Glukomer', 'Location', 'best'); 
xlabel('čas [min]');
ylabel('[mmol/l]');
xlim([400 1440]);

x0=10;
y0=10;
width=250;
height=100;
set(gfc,'Position',[x0 y0 width height])




% scatter(ax2,x,y2)
% title(ax2,'Plot 2')
% grid(ax2,'on')

%--------------------------------------------------------------------------
% sacharidy
%--------------------------------------------------------------------------
DATA_sensor = csvread("CGM_data_den1_D00/Dat_D01_carb.csv");
carb_t = DATA_sensor(:,1);
%carb_vt = DATA_sensor(:,2)/0.00646/5;
carb_vt = DATA_sensor(:,2)/0.00646;

bar(carb_t, carb_vt, 0.05);



%dt_time = 0:1:1440;
dt_time = 400:1:1440;
dt_data = zeros(1,1441);

dt_data(496) = carb_vt(1);
%dt_data(497) = carb_vt(1);
%dt_data(495) = carb_vt(1);

dt_data(577) = carb_vt(2);
%dt_data(578) = carb_vt(2);
%dt_data(576) = carb_vt(2);

dt_data(766) = carb_vt(3);
%dt_data(767) = carb_vt(3);
%dt_data(765) = carb_vt(3);

dt_data(937) = carb_vt(4);
%dt_data(938) = carb_vt(4);
%dt_data(936) = carb_vt(4);

dt_data(1150) = carb_vt(5);
%dt_data(1150) = carb_vt(5);
%dt_data(1149) = carb_vt(5);

dt_data(1337) = carb_vt(6);
%dt_data(1338) = carb_vt(6);
%dt_data(1336) = carb_vt(6);

plot(dt_time, dt_data(401:end));
xlabel('čas [min]');
ylabel('[mg/kg/min]');


%dt = timeseries(dt_data, dt_time);
dt = timeseries(dt_data(401:end), dt_time);


%--------------------------------------------------------------------------
% inzulin
%--------------------------------------------------------------------------

DATA_Basal = csvread("CGM_data_den1_D00/Dat_D01_Basal.csv");
sensor_basal_t = DATA_Basal(:,1);
sensor_basal = DATA_Basal(:,2)*1e6/(64.6*60);

b1 = ones(1, sensor_basal_t(5)) * sensor_basal(5-1);
b2 = ones(1, sensor_basal_t(6) - sensor_basal_t(5)) * sensor_basal(6-1);
b3 = ones(1, sensor_basal_t(8) - sensor_basal_t(6)) * sensor_basal(8-1);
b4 = ones(1, sensor_basal_t(9) - sensor_basal_t(8)) * sensor_basal(9-1);
b5 = ones(1, sensor_basal_t(10) - sensor_basal_t(9)) * sensor_basal(10-1);
b6 = ones(1, sensor_basal_t(14) - sensor_basal_t(10)) * sensor_basal(14-1);
b7 = ones(1, sensor_basal_t(17) - sensor_basal_t(14)) * sensor_basal(17-1);
b8 = ones(1, sensor_basal_t(18) - sensor_basal_t(17)) * sensor_basal(18-1);
b9 = ones(1, sensor_basal_t(22) - sensor_basal_t(18)) * sensor_basal(22-1);
b10 = ones(1, sensor_basal_t(23) - sensor_basal_t(22)) * sensor_basal(23-1);
b11 = ones(1, sensor_basal_t(end) - sensor_basal_t(23) + 1) * sensor_basal(23);
basal_data = [b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11];

%basal_time = 0:1:1440;
basal_time = 0:1:1040;
vb = timeseries(basal_data(401:end), basal_time);
%figure(2);
%hold on;
%grid on;
%loglog(sensor_basal_t, sensor_basal, 'b');
%plot(basal_time, dt_interpol,'.');
%vb = timeseries(basal, basal_time);
plot(basal_data(401:end), basal_time)
yyaxis left
b = bar(days,temp);
yyaxis right
p = plot(days,conc);
%--------------------------------------------------------------------------

DATA_bolus = csvread("CGM_data_den1_D00/Dat_D01_bolus.csv");
sensor_bolus_t = DATA_bolus(:,1);
%sensor_bolus_vt = DATA_bolus(:,2)*1e6/(64.6*5);
sensor_bolus_vt = DATA_bolus(:,2)*1e6/64.6;

basal_data(496) = sensor_bolus_vt(1);basal_data(497) = sensor_bolus_vt(1);
basal_data(495) = sensor_bolus_vt(1);
basal_data(577) = sensor_bolus_vt(2);basal_data(578) = sensor_bolus_vt(2);
basal_data(576) = sensor_bolus_vt(2);
basal_data(766) = sensor_bolus_vt(3);basal_data(767) = sensor_bolus_vt(3);
basal_data(765) = sensor_bolus_vt(3);
basal_data(937) = sensor_bolus_vt(4);basal_data(938) = sensor_bolus_vt(4);
basal_data(936) = sensor_bolus_vt(4);
basal_data(1150) = sensor_bolus_vt(5);basal_data(1151) = sensor_bolus_vt(5);
basal_data(1149) = sensor_bolus_vt(5);
basal_data(1337) = sensor_bolus_vt(6);basal_data(1338) = sensor_bolus_vt(6);
basal_data(1336) = sensor_bolus_vt(6);

%bar(sensor_bolus_t, sensor_bolus_vt, 0.1);
plot(basal_time+401, basal_data(401:end));
xlabel('čas [min]');
ylabel('[mg/kg/min]');

%yyaxis left
b = bar(sensor_bolus_t, sensor_bolus_vt, 0.1);
%yyaxis right
p = plot(basal_time+400, basal_data(401:end));

%bolus_time = 1:1:1440;
%bolus_interpol = interpn(sensor_bolus_t, sensor_bolus, bolus_time);
bolus = zeros(1,1441);
% bolus(496) = sensor_bolus_vt(1);
% bolus(577) = sensor_bolus_vt(2);
% bolus(766) = sensor_bolus_vt(3);
% bolus(937) = sensor_bolus_vt(4);
% bolus(1150) = sensor_bolus_vt(5);
% bolus(1337) = sensor_bolus_vt(6);  

bolus(495) = sensor_bolus_vt(1);
bolus(576) = sensor_bolus_vt(2);
bolus(765) = sensor_bolus_vt(3);
bolus(936) = sensor_bolus_vt(4);
bolus(1149) = sensor_bolus_vt(5);
bolus(1336) = sensor_bolus_vt(6);  

%bolus_time = 0:1:1440;
bolus_time = 0:1:1040;
vB = timeseries(bolus(401:end), bolus_time);
 
% vB = timeseries(bolus_interpol, bolus_time);
% figure(3);
% hold on;
% grid on;
% plot(sensor_bolus_t, sensor_bolus_vt, 'bo');
% plot(bolus_time, dt_interpol,'.');



% x = linspace(400,1,1440);
% tiledlayout(,1) % Requires R2019b or later
% 
% sensor_time = 400:1:1440;
% % Top plot
% ax1 = nexttile;
% grid(ax1,'on');
% plot(sensor_t(81:end), sensor_vt(81:end), 'bo',sensor_time, dt_interpol,'k.');
% title(ax1,'CGM')
% ax1.FontSize = 14;
% 
% % Bottom plot
% ax2 = nexttile;
% %plot(ax1,x,y1)
% grid(ax2,'on');
% plot(sensor_t, sensor_vt, 'bo');
% plot(sensor_time, dt_interpol,'k.');
% title(ax1,'CGM 2')
% ax1.FontSize = 14;



%vb = ;
TD = 33.474;
SG = 0.032;
AG = 0.95;

%--------------------------------------------------------------------------

% Farmakokinetika
DATA = csvread("Dat_FK.csv",2,0);

TI = 44.55;
ki = 0.1645;
VI = 138.8;
kI = ki;


DATA_t = DATA(:,1);
DATA_I = DATA(:,2)/6;
 
%v_b = 281.218;
%S1b = v_b * TI;
%S2b = S1b;
%I_b = S2b/(TI*ki*VI);


% Farmakodynamika

%V_G = 0.1467;
V_G = 1.467;
VG = V_G;
p2 = 0.0106;
S_I = 0.00159;
SI = S_I;
S_G = 0.032;
SG = S_G;
G_INIT = 158.4;
IB_INIT = 6.5;
%G_INIT= 0;
global G_b

G_b = 8.8;
GB = G_INIT;
time = 0:1:1040;
% DATA = csvread("Dat_FD.csv",2,0);
% 
% DATA_t = DATA(:,1);
% DATA_RA = DATA(:,2)/64.6;
% 
% time = 0:1:DATA_t(end);
% DATA_RA_inter = interpn(DATA_t,DATA_RA,time);
% 
% RA = timeseries(DATA_RA_inter, time);
% 
% figure(1), hold on, grid on;
% %plot(DATA_t, DATA_RA,'o')
% plot(time, DATA_RA_inter,'-')
% title('Prisun glukozy')
% ylabel('Glukoza')
% xlabel('Cas')

% plot(DATA_t,DATA_RA,'o',time,DATA_RA_inter,':.');
% 
% fun = @find_params;
% x0 = [p2 S_I];

% options = optimset('PlotFcns',@optimplotfval);
% x = fminsearch(fun, x0, options);
% 
% p2B = x(1);
% S_IB = x(2);

% out = sim('cv5_model');
% figure;
% plot(G, 'b.');
% hold on;
% plot(time,G_b, 'y.');
% title('Glykemia')
% ylabel('Glukoza')
% xlabel('Cas')

out = sim('sim_cv3');
figure;
plot(Gt, 'b.');
hold on;
plot(time,G_b, 'y.');
title('Glykemia')
ylabel('Glukoza')
xlabel('Cas')

