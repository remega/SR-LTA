function out = make_circle(WINDOW_SIZE,MY_RADIUS)

%This function makes a 2D Butterworth filter of size WINDOW_SIZE * WINDOW_SIZE
%which has a cutoff at PIXEL_CUTOFF in the butterworth sense and steepness of filter
%is decided by the ORDER

%Programmer - Umesh Rajashekar (umesh@ece.utexas.edu)
%Date - May 24,2001



[X Y] = meshgrid(-WINDOW_SIZE/2:WINDOW_SIZE/2-1,-WINDOW_SIZE/2:WINDOW_SIZE/2-1);

R = (X.^2+Y.^2);
out = (R < MY_RADIUS.^2);

