load data_KT1.mat
load map_filt.mat
% 2.
% Identifikacia dymanickeho modelu
%
% Odhad zaciatku
ident_start = size(p0, 2) * (4.75/7);
map_ident_data = av_MAP(ident_start:end);
% Zistenie zaciatku odozvy na podanie latky
[start_val, start_ind] = min(map_ident_data);
input_signal = [zeros(1, start_ind), ones(1, size(map_ident_data, 2) - start_ind)];
%identifikacia
data = iddata(map_ident_data', input_signal', 0.0025);
sys = ssest(data, 3);
compare(data, sys);