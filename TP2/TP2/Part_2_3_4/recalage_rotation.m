function [ recalee, SSD_vec ] = recalage_rotation( I,J,epsilon )

theta = 0;
theta_old = theta+1;

[X,Y] = ndgrid(1:size(J,1),1:size(J,2));
pause;

SSD_vec = [];
nb_iter = 0;

while(abs(theta-theta_old)>1e-7)
    
    nb_iter = nb_iter+1;
    
    [I_x,I_y] = grad_centre(I);
    
    I_r = rotation(I,-theta);
    I_rx = rotation(I_x,-theta);
    I_ry = rotation(I_y,-theta);
       
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);

    d_theta = 2 * sum((I_r(:) - J(:)) .* (I_rx(:) .* A(:) + I_ry(:) .* B(:)));
        
    SSD_temp = sum((I_r(:)-J(:)).^2);
    SSD_vec = [SSD_vec SSD_temp];
    
    theta_old = theta;
    theta = theta - epsilon*d_theta;
    
    subplot(1,4,1);
    imshow(J,[]);
    subplot(1,4,2);
    imshow(I_r, []);
    subplot(1,4,3);
    plot(1:1:nb_iter,SSD_vec);
    subplot(1,4,4);
    imshow(abs(J - I_r), []);
    drawnow
    
end

end

