function [ SSD ] = ssd( conj_hist)
%This function computes the SSD of two images
SSD = 0;
size_hist = size(conj_hist);
for i=1:1:size_hist(1)
    for j=1:1:size_hist(2)
        SSD = SSD + conj_hist(i,j) * (i - j)^2;
    end
end

end

