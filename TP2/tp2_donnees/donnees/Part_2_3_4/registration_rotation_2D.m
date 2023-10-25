clear;close all;clc;


J = % ?
I = % ?

epsilon = % ?

theta = 0;
theta_old = theta+1;

[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));
pause;

while(abs(theta-theta_old)>1e-7)
    
    J_r = rotation(J,-theta);
    J_rx = rotation(J_x,-theta);
    J_ry = rotation(J_y,-theta);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    d_theta = % ?
    
    theta_old = theta;
    theta = theta - epsilon*d_theta;
    
end
