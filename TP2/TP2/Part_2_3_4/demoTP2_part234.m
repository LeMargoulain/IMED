clear all;
close all;

TP2_donnees = load('TP2_donnees.mat');

J = TP2_donnees.Brain_MRI_2;
I = translation(J, 20,10);

figure(1)
subplot(1,2,1)
imshow(J, [])
subplot(1,2,2)
imshow(I, [])

%recalage_2D(I,J, 5e-3);
I = rotation(J,pi/32);
imshow(I,[])
recalage_rotation(I,J,5e-3);