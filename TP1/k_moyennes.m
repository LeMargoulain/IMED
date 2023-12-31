function [Segmentation,Seuils] = k_moyennes(M0,k)
% Le fond compte comme une classe de base donc k = k+1 en r�alit�

Moyennes = zeros(k,1);

%initialisation des k seuils

Seuils = linspace(min(M0(:)),max(M0(:)),k+1);


Seuils_old = Seuils+1;

while (norm(Seuils-Seuils_old)>0) %tant que les seuils bougent

   %Mise a jour des moyennes de chaque classe 
  
   for i = 1:k
       Moyennes(i) = mean(M0(M0 > Seuils(i) & M0 <= Seuils(i+1)));
   end

   Seuils_old = Seuils;
   %Mise a jour des seuils s�parant chaque classe
   for i = 2:k
       Seuils(i) = (Moyennes(i-1) + Moyennes(i)) / 2;
   end
end

%Construction de la segmentation 
Segmentation = zeros(size(M0));
% Segmentation(isnan(M0))=0;

% Segmentation(M0 < Seuils(1)) = 1;
for i = 1:k
    Segmentation(M0 > Seuils(i) & M0 <= Seuils(i+1)) = i;
end
% Segmentation(M0 > Seuils(k-1)) =  4;





