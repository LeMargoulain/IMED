function [] = visu_coupe( type_vue, matrice_volume )
%Cette fonction permet l'affichage de coupes d'un volume pass� en entr�e

matrice_volume(isnan(matrice_volume))=0;
shape_matrice = size(matrice_volume);

if(strcmp(type_vue, 'sagittale') == 1)
    for i = 1:1:shape_matrice(1)
        coupe = squeeze(matrice_volume(i,:,:));
        imagesc(coupe)
        title("sagittale")
        drawnow;
    end
end
if(strcmp(type_vue, 'coronale') == 1)
    for i = 1:1:shape_matrice(1)
        coupe = squeeze(matrice_volume(:,i,:));
        imagesc(coupe)
        title("coronale")
        drawnow;
    end 
end
if(strcmp(type_vue, 'axiale') == 1)
    for i = 1:1:shape_matrice(1)
        coupe = squeeze(matrice_volume(:,:,i));
        imagesc(coupe)
        title("axiale")
        drawnow;
    end 
end
end

