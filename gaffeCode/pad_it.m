function pad_image = pad_it ( image , fil_size)

%function to replicate the edges of an image before filtering

%========================================================================

%Copyright (c) 1999-2000 The University of Texas
%All Rights Reserved.
 
%This program is free software; you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation; either version 2 of the License, or
%(at your option) any later version.
 
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
 
%The GNU Public License is available in the file LICENSE, or you
%can write to the Free Software Foundation, Inc., 59 Temple Place -
%Suite 330, Boston, MA 02111-1307, USA, or you can find it on the
%World Wide Web at http://www.fsf.org.

 %Demo ideas : Dr.Alan C Bovik
 %Programmer :	Umesh Rajashekar 
 %Version:        %W%	%G%

%The authors are with the Department of Electrical and Computer
%Engineering, The University of Texas at Austin, Austin, TX.
%They can be reached at bovik@ece.utexas.edu and umesh@ece.utexas.edu

%Kindly report any suggestions or corrections to the demos to 
%umesh@ece.utexas.edu

%========================================================================

temp = size(image);
n_rows = temp(1);
n_cols = temp (2);

%pad the image 

xcess = ( fil_size -1 )/2;

%extract the edges of the images
%--------------------------------
top = image ( 1 ,:);
bottom = image ( n_rows , : );
left = image ( : , 1 );
right = image ( : , n_cols);
%---------------------------------

%replicate the matrix to form the req number of excess data

top = repmat ( top , xcess , 1 );
bottom = repmat ( bottom , xcess ,1 );
left = repmat ( left , 1 , xcess );
right = repmat ( right , 1 , xcess );
%--------------------------------------

top_left = ones (xcess) * image (1,1);
top_right = ones (xcess) * image (1,n_cols);
bottom_left = ones (xcess) * image (n_rows,1);
bottom_right = ones (xcess) * image (n_rows,n_cols);
%----------------------------

% the final padded image

pad_image = [
   			 top_left   , top    , top_right;
             left 	   , image  , right ;
             bottom_left, bottom , bottom_right;
          ];
          
          
%------------------------          
   









