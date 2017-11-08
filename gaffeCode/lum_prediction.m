function pred_map = lum_prediction(my_image,x_center, y_center)

% Function to compute luminance of an image

% Author    : Umesh Rajashekar
% Date      : 4 Jan. 2008


my_image = double(my_image);
[R C] = size(my_image);

use_gabor = make_raised_cos(96); %Luminance computed in a 96x96 pixel window

FFT_SIZE  = size(my_image) + size(use_gabor) - 1;
image_fft = fft2(my_image, FFT_SIZE(1), FFT_SIZE(2));

temp_filtered = abs(ifft2( image_fft .* fft2(use_gabor, FFT_SIZE(1), FFT_SIZE(2))));

%Pick out the valid entries
start_ind = size(use_gabor,1)/2;
pred_map = temp_filtered(start_ind:start_ind+R-1,start_ind:start_ind+C-1);

return

