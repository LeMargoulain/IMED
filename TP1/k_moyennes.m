function [Segmentation,Seuils] = k_moyennes(M0,k)
%EUH ATTENTION LE K LA IL PREND LES NAN EN COMPTES DONC SI VOUS VOULEZ 4
%CLASSES VOUS METTEZ 3 OK??

Moyennes = zeros(k,1);

%initialisation des k seuils

Seuils = zeros(k-1,1);
for i = 1:k-1
    Seuils(i) = i * max(M0(:))/k;
end

Seuils_old = Seuils+1;

while (norm(Seuils-Seuils_old)>0) %tant que les seuils bougent

   %Mise a jour des moyennes de chaque classe 
   
   Moyennes(1) =  mean(M0(M0 > 0 & M0 < Seuils(1)));
   for i = 2:k-1
       Moyennes(i) = mean(M0(M0 > Seuils(i-1) & M0 < Seuils(i)));
   end
   Moyennes(k) = mean(M0(M0 > Seuils(k-1)));

   Seuils_old = Seuils;
   %Mise a jour des seuils séparant chaque classe
   for i = 1:k-1
       Seuils(i) = (Moyennes(i) + Moyennes(i+1)) / 2;
   end
end

%Construction de la segmentation 
Segmentation = zeros(size(M0));
Segmentation(isnan(M0))=0;

Segmentation(M0 < Seuils(1)) = 1;
for i = 2:k-1
    Segmentation(M0 > Seuils(i-1) & M0 < Seuils(i)) = i;
end
Segmentation(M0 > Seuils(k-1)) =  4;





