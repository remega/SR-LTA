function [display_image] = read_vanhat_foranalysis(filename)

%Function to read in an image from the van Hateren database

% Author    : Umesh Rajashekar & Ian van der Linde
% Date      : 4 Jan. 2003

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
% Define Constants                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

w = 1024; h = 768;                                              % W x H of Images(cropped van Hateren) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read van Hateren File                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1              = fopen(filename,'rb','ieee-be');
buf             = fread(f1,[w,h],'uint16');                     % Read 16bpp image data
display_image   = buf';                                         % Note: van Hateren images are flipped
display_image   = display_image+1;
fclose(f1);
display_image = display_image/max(display_image(:))*255;

return

