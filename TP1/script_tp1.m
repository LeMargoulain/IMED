clear all 
close all

%% ======Partie Sans biais======%

%% Exercice1 %%
irm_cerveau_mat = load('IRM_cerveau.mat');
m_0 = irm_cerveau_mat.M0;

coupe_axiale = squeeze(m_0(:,:,80));
imshow(coupe_axiale, [])
visu_coupe('axiale', m_0);


%% Exercice 2 %%

[segmentation, seuils] = k_moyennes(m_0, 3);

%% Exercice 3 %%

smoothed_segmentation = smooth3(segmentation);
visu_coupe('coronale', smoothed_segmentation)

%% Exercice 4 %%

x = 1:1:143;
y = 1:1:198;
z = 1:1:154;
[X,Y,Z] = meshgrid(y,x,z);

[F,V] = MarchingCubes(X,Y,Z,smoothed_segmentation,1.5);

% =====Partie avec biais======%

%% Exercice 5 %%

irm_cerveau_avecbiais = load('IRM_cerveau_avecbiais.mat');
m_0_b = irm_cerveau_avecbiais.M0;

[segm1,s1] = k_moyennes(m_0(:,:,80),3);
[segm2,s2] = k_moyennes(m_0_b(:,:,80),3);

[segmentation_b, seuils_b] = k_moyennes(m_0,3);
%visu_coupe('axiale',segmentation_b)

%% Exercice 6 %%

surf(m_0_b(:,:,80))

%% Exercice 7 %%
%ndgrid
size_matrix = size(m_0_b);
[x,y] = ndgrid(1:size_matrix(1),1:size_matrix(2));
z = m_0_b(:,:,80);
x = x(~isnan(m_0_b(:,:,80)));
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

[xx, yy]=meshgrid(0:1:size_matrix(2),0:1:size_matrix(1)); % g�n�re une grille r�guli�re pour l'affichage du plan estim�
zz = XCoeff * yy + YCoeff * xx + CCoeff;
figure(1)
surf(xx,yy,zz) % affiche le plan donn� par l'�quation estim�e
hold on
surf(m_0_b(:,:,80))
hold on
grid on
title(sprintf('Plan z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff)) %�quation du plan estim� (doit �tre proche de z=2x-5y+3)
% En tournant autour de la surface on voit que les points (x,y,z) sont "� peu pr�s" sur le plan estim�


