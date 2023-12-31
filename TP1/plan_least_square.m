close all;clear;clc
n=100;

%on g�n�re les donn�es 
x = rand(1,n);
y = rand(1,n);
z = 2*x-5*y+3 + randn(1,n); %�quation du plan z=2x-5y+3 et on ajoute du bruit blanc gaussien(mu=0 std=1)
% c'est cette �quation qu'on veut retrouver malgr� le bruit pr�sent dans les donn�es
% on cherche donc � estimer a,b et c tel que a*X + b*Y + c soit le plus proche de Z possible

%on affiche les donn�es
L=plot3(x,y,z,'ro'); % affiche les points (x,y,z) (donn�es)
set(L,'Markersize',2*get(L,'Markersize')) % augmente la taille des cercles
set(L,'Markerfacecolor','r') % remplit les cercles

pause %appuyez sur une touche pour continuer

Xcolv = x(:); % on transforme en vecteur colonne
Ycolv = y(:); 
Zcolv = z(:); 
Const = ones(size(Xcolv)); %vecteur de 1 pour le terme constant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Coefficients = [Xcolv Ycolv Const]\Zcolv; % Trouve les coefficients (moindre carr�)
%help \   -->  
%     If A is an M-by-N matrix with M < or > N and B is a column
%     vector with M components, or a matrix with several such columns,
%     then X = A\B is the solution in the least squares sense to the
%     under- or overdetermined system of equations A*X = B.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XCoeff = Coefficients(1); % coefficient dvt le terme en X (a)
YCoeff = Coefficients(2); % coefficient dvt le terme en Y (b)
CCoeff = Coefficients(3); % terme constant (c)
% avec les variables ci-dessus on a z " � peu pr�s �gal �" XCoeff * x + YCoeff * y + CCoeff
% il s'agit du plan qui "explique" le mieux les donn�es.

% On affiche le plan pour v�rifier
hold on
[xx, yy]=meshgrid(0:.1:1,0:.1:1); % g�n�re une grille r�guli�re pour l'affichage du plan estim�
zz = XCoeff * xx + YCoeff * yy + CCoeff;
surf(xx,yy,zz) % affiche le plan donn� par l'�quation estim�e
title(sprintf('Plan z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff)) %�quation du plan estim� (doit �tre proche de z=2x-5y+3)
% En tournant autour de la surface on voit que les points (x,y,z) sont "� peu pr�s" sur le plan estim�