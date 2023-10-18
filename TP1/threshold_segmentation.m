function [Segmentation, Seuils] = threshold_segmentation(M0, k)
    % Calculate the optimal thresholds using Otsu's method
    thresholds = multithresh(M0, k - 1);
    
    % Initialize class means
    class_means = zeros(k, 1);

    % Initialize the old thresholds to ensure the loop runs at least once
    old_thresholds = thresholds + 1;

    % While thresholds are changing
    while norm(thresholds - old_thresholds) > 0
        % Update the old thresholds
        old_thresholds = thresholds;

        % Update class means
        class_means(1) = mean(M0(M0 > 0 & M0 < thresholds(1)));
        for i = 2:k - 1
            class_means(i) = mean(M0(M0 > thresholds(i - 1) & M0 < thresholds(i)));
        end
        class_means(k) = mean(M0(M0 > thresholds(k - 1)));

        % Update the thresholds
        for i = 1:k - 1
            thresholds(i) = (class_means(i) + class_means(i + 1)) / 2;
        end
    end

    % Create the segmentation based on the thresholds
    Segmentation = zeros(size(M0));
    Segmentation(isnan(M0)) = 0;

    Segmentation(M0 < thresholds(1)) = 1;
    for i = 2:k - 1
        Segmentation(M0 > thresholds(i - 1) & M0 < thresholds(i)) = i;
    end
    Segmentation(M0 > thresholds(k - 1)) = k;
    
    % Assign the calculated thresholds to the output variable "Seuils"
    Seuils = thresholds;
end
