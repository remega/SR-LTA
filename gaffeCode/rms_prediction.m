function pred_map = rms_prediction(my_image,x_center, y_center)

% Function to compute luminance of an image

% Author    : Umesh Rajashekar
% Date      : 4 Jan. 2008 

my_image = double(my_image);
[R C] = size(my_image);

down_image = my_image(1:2:R,1:2:C); %Downsample for speed
image_rms = my_rms(down_image,96/2+1);
pred_map = imresize(image_rms,[R C],'bilinear'); %Upsample back to original size


%%%%%%%

function fin = my_rms(my_image , len)

%first pad the image
orig_image = my_image; 

[R C] = size(my_image);
my_image = pad_it(my_image,len);
[my_mask, invalid_ind] = make_raised_cos(len);

%Compute the mean of the mask
my_mask(invalid_ind) = []; %Remove points outside the circle
my_mask = my_mask/sum(my_mask);

%doing the filtering
filt_size = (len-1)/2;
for row = 1:R
    for col = 1:C
        temp_patch = my_image(row:row+len-1,col:col+len-1);
        temp_patch(invalid_ind) = [];

        %Compute the mean of the masked patch
        patch_mean = sum(temp_patch.*my_mask);
        my_contrast = my_mask.*((temp_patch - patch_mean).^2 ./ (patch_mean^2 + eps));
        my_contrast = sqrt(sum(my_contrast));
        patches_rms = my_contrast;

        fin(row,col) = patches_rms;
    end
end

return;

