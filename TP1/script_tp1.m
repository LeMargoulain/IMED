clear all 
close all

%% ======Partie Sans biais======%

%% Exercice1 %%
irm_cerveau_mat = load('IRM_cerveau.mat');
m_0 = irm_cerveau_mat.M0;

% Vue axiale
figure;
title("axiale")
visu_coupe('axiale', m_0);

% Vue sagittale
figure;
title("sagittale")
visu_coupe('sagittale', m_0);

% Vue coronale
figure;
title("coronale")
visu_coupe('coronale', m_0);
%% Exercice 2 %%

% k_moyennes sur IRM_Cerveau.mat
[segmentation, seuils] = k_moyennes(m_0, 3);

%% Exercice 3 %%
figure;
subplot(1,2,1)
imagesc(m_0(:,:,80))
title("image originale");
axis equal;
axis off;

subplot(1,2,2)
imagesc(segmentation(:,:,80))
title("image segment�e");
axis equal;
axis off;

%% Exercice 4 %%

x = 1:1:143;
y = 1:1:198;
z = 1:1:154;
[X,Y,Z] = meshgrid(y,x,z);
moothed_segmentation = smooth3(segmentation);

%Surface corticale
[F,V] = MarchingCubes(X,Y,Z,smoothed_segmentation,1);

% =====Partie avec biais======%

%% Exercice 5 %%

irm_cerveau_avecbiais = load('IRM_cerveau_avecbiais.mat');
m_0_b = irm_cerveau_avecbiais.M0;

[segm1,s1] = k_moyennes(m_0(:,:,80),3);
[segm2,s2] = k_moyennes(m_0_b(:,:,80),3);

figure;
subplot(1,2,1)
imagesc(segm1)
title("segmentation sans biais (IRM premi�re partie)");
axis equal;
axis off;

subplot(1,2,2)
imagesc(segm2)
title("segmentation biais�e (IRM seconde partie)");
axis equal;
axis off;

%% Exercice 6 %%

surf(m_0_b(:,:,80))

%% Exercice 7 %%

size_matrix = size(m_0_b);
[x,y] = ndgrid(1:size_matrix(1),1:size_matrix(2)); % on cr�er un grid pour r�gler le probl�me de dimension
z = m_0_b(:,:,80);
x = x(~isnan(m_0_b(:,:,80))); % on retir les nan
y = y(~isnan(m_0_b(:,:,80)));
z =z(~isnan(z));

Xcolv = x(:); % on transforme en vecteur colonne
Ycolv = y(:); 
Zcolv = z(:); 
Const = ones(size(Xcolv)); %vecteur de 1 pour le terme constant
Coefficients = [Xcolv Ycolv Const]\Zcolv;

XCoeff = Coefficients(1); 
YCoeff = Coefficients(2);
CCoeff = Coefficients(3);

[xx, yy]=meshgrid(1:1:size_matrix(2),1:1:size_matrix(1)); % g�n�re une grille r�guli�re pour l'affichage du plan estim�
zz = XCoeff *  yy + YCoeff * xx + CCoeff;
figure;
surf(xx,yy,zz) % affiche le plan donn� par l'�quation estim�e
hold on
surf(m_0_b(:,:,80))
hold on
grid on
title(sprintf('Plan z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff)) %�quation du plan estim� (doit �tre proche de z=2x-5y+3)
% En tournant autour de la surface on voit que les points (x,y,z) sont "� peu pr�s" sur le plan estim�
hold off

coupe = m_0_b(:,:,80);
coupeCorrige = coupe-zz; % (XCoeff * yy + YCoeff * xx + CCoeff); %on enl�ve le plan a la coupe pour �galiser

figure;
subplot(1,2,1)
imagesc(coupe)
axis equal;
axis off;
title("avant correction de biais")

subplot(1,2,2)
imagesc(coupeCorrige);
axis equal;
axis off;
title("apr�s correction de biais")


[segmentation_b, seuils_b] = k_moyennes(coupeCorrige,3);
[segmentation_c, seuils_c] = k_moyennes(coupe,3);

figure;
subplot(1,2,1)
imagesc(segmentation_c);
axis equal;
axis off;
title("Segmentation biais");

subplot(1,2,2)
imagesc(segmentation_b);
axis equal;
axis off;
title("Segmentation correction biais")




