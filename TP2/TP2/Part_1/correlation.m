function [ correlation ] = correlation( I,J )
%This function computees the correlation between two images
 
correlation = corr2(I(:),J(:));
end

