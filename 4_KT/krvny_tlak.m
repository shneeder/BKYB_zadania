load data_KT1.mat;
% 1.
% Stredny arterialny tlak
%
% 105 = 1.5 periody
MAP = zeros(1,size(p0,2));
for step = 0:size(p0,2)-106
    window = p0(step+1:step+105);
    STK = max(window);
    DTK = min(window);
    MAP(step+1) = DTK + (STK - DTK)/3;
end
%plot(t0(1:size(MAP,2)), p0(1:size(MAP,2)), t0(1:size(MAP,2)), MAP);

% Klzavy priemer
B = 1/2000 * ones(2000, 1);
A = 1;
av_MAP = filter(B, A, MAP);
figure(1);
plot(...
    t0(1:size(MAP,2)), p0(1:size(MAP,2)), ...
    t0(1:size(MAP,2)), MAP, ...    
    t0(1:size(MAP,2)), av_MAP);
legend('KT', 'MAP','MAP_{filt}');

% 2.
% Identifikacia dymanickeho modelu
%
% Odhad zaciatku
ident_start = size(p0, 2) * (4.75/7);
% Vystup systemu
map_ident_data = av_MAP(ident_start:end);
% Zistenie zaciatku odozvy na podanie latky
[start_val, start_ind] = min(map_ident_data);
% Vstup do systemu
input_signal = [zeros(1, start_ind), ones(1, size(map_ident_data, 2) - start_ind)];
% Identifikacia
data = iddata(map_ident_data', input_signal', 0.0025);
sys = ssest(data, 2);
figure(2)
compare(data, sys);






