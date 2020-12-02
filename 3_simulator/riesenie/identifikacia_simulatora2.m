close all;
clear;
clc;


%--------------------------------------------------------------------------
DATA_sensor = csvread("CGM_data_den1_D00/Dat_D01_sensor.csv");
sensor_t = DATA_sensor(:,1);
sensor_vt = DATA_sensor(:,2);

%sensor_time = 0:1:sensor_t(end);
sensor_time = 0:1:1440;
%sensor_t(end+1) = 1441;
%sensor_vt(end+1) = sensor_t(end); 
dt_interpol = interpn(sensor_t, sensor_vt, sensor_time);

%dt = timeseries(dt_interpol, sensor_time);
% figure(1);
% hold on;
% grid on;
% plot(sensor_t, sensor_vt, 'bo');
% plot(sensor_time, dt_interpol,'.');

%--------------------------------------------------------------------------
% sacharidy
%--------------------------------------------------------------------------
DATA_sensor = csvread("CGM_data_den1_D00/Dat_D01_carb.csv");
carb_t = DATA_sensor(:,1);
%carb_vt = DATA_sensor(:,2)/0.00646/5;
carb_vt = DATA_sensor(:,2)/0.00646;
%bar(carb_t, carb_vt, 0.05);

%dt_time = 0:1:1440;
dt_time = 0:1:1040;
dt_data = zeros(1,1441);

dt_data(496) = carb_vt(1);
dt_data(577) = carb_vt(2);
dt_data(766) = carb_vt(3);
dt_data(937) = carb_vt(4);
dt_data(1150) = carb_vt(5);
dt_data(1337) = carb_vt(6);


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

%--------------------------------------------------------------------------

DATA_bolus = csvread("CGM_data_den1_D00/Dat_D01_bolus.csv");
sensor_bolus_t = DATA_bolus(:,1);
%sensor_bolus_vt = DATA_bolus(:,2)*1e6/(64.6*5);
sensor_bolus_vt = DATA_bolus(:,2)*1e6/64.6;

%bar(sensor_bolus_t, sensor_bolus_vt, 0.1);

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
 
%--------------------------------------------------------------------------
%TD = 33.474;
%SG = 0.032;
%--------------------------------------------------------------------------

AG = 0.95;

%--------------------------------------------------------------------------

% Farmakokinetika
%DATA = csvread("Dat_FK.csv",2,0);

TI = 42.8216;
ki = 0.1939;
VI = 110.599;
kI = ki;


%DATA_t = DATA(:,1);
%DATA_I = DATA(:,2)/6;
 
%v_b = 281.218;
%S1b = v_b * TI;
%S2b = S1b;
%I_b = S2b/(TI*ki*VI);


% Farmakodynamika

%V_G = 0.1467;
V_G = 1.467;
VG = V_G;
p2 = 0.0097;
S_I = 0.0014;
SI = S_I;
%S_G = 0.032;
%SG = S_G;
G_INIT = 153;
IB_INIT = 6.5;
%G_INIT= 0;
global G_b

G_b = 8.5;
GB = G_INIT;
time = 0:1:1040;

space=[0.0001 0.1 ; 0.1 100];
pop = genrpop(50,space);
generacie = 30; 
delta = [0.1 0.1 0.1];
evolution = ones(generacie,1)*100000000000;
%--------------------------------------------------------------------------
for i=1:generacie
    i
    for j = 1:size(pop,1)
    SG = pop(j,1);
    TD = pop(j,2);
    p3 = p2;

    length = 0;
        try
            tout = sim('sim_cv3');
            fit(j) = sum(abs(dt_interpol(402:end-6)' - Gt(2:end-6)).^2);   
        catch
           fit(j)=100000000000;
        end     
    end
    evolution(i) = min(fit);

    best=selbest(pop,fit,5);

    pop1=selsus(pop,fit,15);
    pop1=crossov(pop1,1,0);
    pop1=mutx(pop1,0.5,space);

    pop2=seltourn(pop,fit,15);
    pop2=crossov(pop2,1,0);
    pop2=mutx(pop2,0.1,space);

    pop3=selrand(pop,fit,15);
    pop3=muta(pop3,0.2,delta,space);

    pop=[best;pop1;pop2;pop3];

end  
    
SG = pop(1,1)
TD = pop(1,2)

figure(1)
plot(evolution)
xlabel('generácia');
ylabel('fitness');
legend('hodnota účelovej funkcie');

TI = 42.8216
kI = 0.1939
VI = 110.599
SI = 0.0014
p2 = 0.0097
SG = 0.0159
TD = 41.1727
time2 = time;
out = sim('sim_cv3');
figure(2);hold on;
plot(Gt, 'b.');
plot(time2, dt_interpol(401:end), 'ro');
plot(time,G_b, 'y.');
title('Glykémia')
ylabel('[mmol/l]')
xlabel('Čas [min]')
legend('G(t)', 'CGM', 'G_b');
set(gca, 'XTickLabel', [400 600 800 1000 1200 1400 1600])





