
theta = 0;
theta_old = theta+1;

SSD = [];

[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));
pause;

while(abs(theta-theta_old)>1e-7)

    [J_x,J_y] = grad_centre(J);
    
    J_r = rotation(J,-theta);
    J_rx = rotation(J_x,-theta);
    J_ry = rotation(J_y,-theta);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    d_theta = 2 * sum(J(B,-A) - J(:) .* (J_x(A) + J_y(B)));
    
    theta_old = theta;
    theta = theta - epsilon*d_theta;
        
    SSD_temp = sum((I_t(:)-J(:)).^2);
    SSD_vec = [SSD_vec SSD_temp];
    
    subplot(1,4,1);
    imshow(I,[]);
    subplot(1,4,2);
    imshow(J, []);
    subplot(1,4,3);
    plot(1:1:nb_iter,SSD_vec);
    subplot(1,4,4);
    imshow(abs(J - I_t), []);
    drawnow
    
end
