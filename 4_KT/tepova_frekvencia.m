load data_KT1.mat
%
% 3.
% Tepova frekvencia
%

HR = zeros(1, 65267);
T_KT = zeros(1, 65267);
step = 41; i = 1;
while step < (size(p0, 2) - 106)
    window = p0(step+1:step+105);
    [pks, locs] = findpeaks(window, 'MinPeakDistance', 30, ...
        'NPeaks', 2);
    if locs(1) > locs(2)
        next = locs(1);
    else
        next = locs(2);
    end
%    if (size(pks, 2) > 1) 
        %test_two = test_two + 1;
        T_KT(i) = abs( t0(step+locs(2)) - (t0(step+locs(1))) );
        HR(i) = 1/T_KT(i);
        step = step + next - 5; i = i + 1;
%     elseif (size(pks, 2) == 1)
%         %test_one = test_one + 1;
%         step = step + next - 5;
%     else
%         %test_none = test_none + 1;
%         step = step + 105;
%    end
end