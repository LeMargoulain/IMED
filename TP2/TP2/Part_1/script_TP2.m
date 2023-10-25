close all; 
clear all;
hold on;

I = imread('I1.jpg');
J = imread('J1.jpg');

conj_hist = hist2(I,J);

figure(1)
title('Histogramme joint entre I et J')
xlabel('I')
ylabel('J')
imagesc(conj_hist)

sum_hist = sum(sum(conj_hist));
disp('Sum of the histogram : ');
disp(sum_hist);

disp('taille des images');
size_image = size(I);
disp(size_image(1) * size_image(2));

SSD_I_J = ssd(conj_hist);
disp('SSD');
disp(SSD_I_J);

correlation_I_J = correlation(I,J);
disp('correlation');
disp(correlation_I_J);

mutual_information_I_J = mutual_information(conj_hist);
disp('mutual information');
disp(mutual_information_I_J);



