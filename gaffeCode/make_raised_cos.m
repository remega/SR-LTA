function [out, invalid_ind] = make_raised_cos(WINDOW_SIZE)

%This function makes a 2D Raised Cosine filter of size WINDOW_SIZE * WINDOW_SIZE

%Programmer - Umesh Rajashekar (umesh@ece.utexas.edu)
%Date - May 24,2001


[X Y] = meshgrid(-WINDOW_SIZE/2:WINDOW_SIZE/2-1,-WINDOW_SIZE/2:WINDOW_SIZE/2-1);
PATCH_RADIUS =  max(X(:));
R = (X.^2+Y.^2).^0.5;
H = 0.5*(cos(pi/PATCH_RADIUS*R)+1);

%Need to delete points outside radius. Else Cosine rises above zero
my_circle = make_circle(WINDOW_SIZE,WINDOW_SIZE/2);

invalid_ind = find(my_circle == 0);
out = H .*my_circle;


