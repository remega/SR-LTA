function img = gaffe_foveate_image(img,col,row)
% FOVEATE_GS_IMAGE   Realtime foveation of a static, grayscale image
%
% Press ESC to end the demo and close the window.

% Copyright (C) 2004-2006
% Center for Perceptual Systems
% University of Texas at Austin
%
% jsp Wed Sep 20 17:24:30 CDT 2006

% Prompt for parameters
%fn_list={'c17.jpg','lu.jpg','spacewalk.jpg'};
%[fn,halfres]=get_params(fn_list);
halfres = 2;

% Read in the file
%fprintf('Reading %s...\n',fn);
%img=imread(fn);
rows=size(img,1);
cols=size(img,2);

% Initialize the library
svisinit

% Create a resmap
%fprintf('Creating resolution map...\n');
resmap=svisresmap(rows*2,cols*2,'halfres',halfres);

% Create 3 codecs for r, g, and b
%fprintf('Creating codec...\n');
c=sviscodec(img);

% The masks get created when you set the map
%fprintf('Creating blending masks...\n');
svissetresmap(c,resmap)

img=svisencode(c,row,col);

return;

