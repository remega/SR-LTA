function out = make_butter_rect(WINDOW_WIDTH,WINDOW_HEIGHT,X_PIXEL_CUTOFF,Y_PIXEL_CUTOFF,ORDER)

%This function makes a 2D Butterworth filter of size WINDOW_SIZE * WINDOW_SIZE
%which has a cutoff at PIXEL_CUTOFF in the butterworth sense and steepness of filter
%is decided by the ORDER

%Programmer - Umesh Rajashekar (umesh@ece.utexas.edu)
%Date - May 24,2001


x = -WINDOW_WIDTH/2:WINDOW_WIDTH/2-1;
x = x/X_PIXEL_CUTOFF;

y = -WINDOW_HEIGHT/2:WINDOW_HEIGHT/2-1;
y = y/Y_PIXEL_CUTOFF;


%The 1D butterworth filter
H_x = (1 + x.^(2*ORDER)).^-0.5;
H_y = (1 + y.^(2*ORDER)).^-0.5;

%make 2d filter
out = H_y'*H_x;

