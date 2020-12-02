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
% ident_start = size(p0, 2) * (4.75/7);
% map_ident_data = av_MAP(ident_start:end);
% % Zistenie zaciatku odozvy na podanie latky
% [start_val, start_ind] = min(map_ident_data);
% input_signal = [zeros(1, start_ind), ones(1, size(map_ident_data, 2) - start_ind)];

%figure(2);
%plot(t0(ident_start:size(MAP,2)), input_signal, t0(ident_start:size(MAP,2)), map_ident_data);
%legend('input', 'MAP_{filt}');

%system2 = tf([b2 b1 b0], [a3 a2 a1 a0]);

% 2.
% Tepova frekvencia
% %
% pks = findpeaks(p0);
% figure(3);
% plot(pks);
% 
% %HRvector = zeros(1,size(p0,2));
% HRvector = zeros(1,500);
% %for step = 41:size(p0,2)-106
% % for step = 41:541    
% % %for step = 1   
% %     window = p0(step+1:step+105);
% %     [pks, locs] = findpeaks(window, 'MinPeakDistance', 50);
% %     if size(pks, 2) > 1
% %         HRvector(step-40) = 1/abs(locs(2) - locs(1));
% %     else
% %         HRvector(step-40) = HRvector(step-41);
% %     end
% % end
% HR = zeros(1, 65267);
% step = 41; i = 1;
% while step < (size(p0, 2) - 106)
%     window = p0(step+1:step+105);
%     [pks, locs] = findpeaks(window, 'MinPeakDistance', 30, ...
%         'NPeaks', 2);
%     if locs(1) > locs(2)
%         next = locs(1);
%     else
%         next = locs(2);
%     end
%     if (size(pks, 2) > 1) 
%         %test_two = test_two + 1;
%         T_KT = abs(locs(2) - locs(1));
%         HR(i) = 1/T_KT;
%         step = step + next - 5; i = i + 1;
%     elseif (size(pks, 2) == 1)
%         %test_one = test_one + 1;
%         step = step + next - 5;
%     else
%         %test_none = test_none + 1;
%         step = step + 105;
%     end
% end
% 
% 
% 
% 
% plot(HRvector, '*')
% hold on
% 
% plot(locs, pks, '*')
% hold on
% plot(window)





