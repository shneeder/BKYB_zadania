load data_KT1.mat;

test_two = 0;
test_one = 0;
test_none = 0;

step = 41;
while step < (size(p0, 2) - 106)
    window = p0(step+1:step+105);
    %max_temp = maxk(window, 35); % sluzi na kontrolu
    [pks, locs] = findpeaks(window, 'MinPeakDistance', 30, ...
        'NPeaks', 2);
    if locs(1) > locs(2)
        next = locs(1);
    else
        next = locs(2);
    end
        %'MinPeakHeight', max_temp(35));
    if (size(pks, 2) > 1) 
        test_two = test_two + 1;
        step = step + next - 5;
    elseif (size(pks, 2) == 1)
        test_one = test_one + 1;
        step = step + next - 5;
    else
        test_none = test_none + 1;
        step = step + 105;
    end
end