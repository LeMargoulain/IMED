function [Segmentation,Seuils] = k_moyennes(M0,k)

Moyennes = zeros(k,1);

%initialisation des k seuils
    %% TO DO 

Seuils_old = Seuils+1;

while (norm(Seuils-Seuils_old)>0) %tant que les seuils bougent
    
    
   %Mise a jour des moyennes de chaque classe 
      %% TO DO 
    
   Seuils_old = Seuils;
   %Mise a jour des seuils séparant chaque classe
      %% TO DO 
end

%Construction de la segmentation 
    %% TO DO 