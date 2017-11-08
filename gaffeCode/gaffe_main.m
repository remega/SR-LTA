%A program to demonstrate fixation selection by GAFFE. The program
%reads an image from the van Hateren database and predicts 15 fixations

% Author    : Umesh Rajashekar
% Date      : 4 Jan. 2008


clear; close all;

%DIRECTORIES
IMAGES_DIR          = '../VanhatImages/';

NUM_FIXATIONS = 15; %Select the number of fixations

%Set the relative weighting of the maps
w = [1.04 1.12 1.23 1.3];
wt = w./sum(w);

%Read in an image from the Van Hateren Database
image_name = 'imk01019.iml'; %A simple example image with a bright Flower
im = uint8(read_vanhat_foranalysis([IMAGES_DIR image_name]));

%%  Start by foveating the center of the image
[R C] = size(im);
fix_x = C/2; fix_y = R/2;
fix_x_list = fix_x; fix_y_list = fix_y; %Keep a list of fixations

%Make a rectangular mask to avoid edge artifacts of filtering
butter_mask = make_butter_rect(C, R, C*0.35, R*0.35, 10);

%% Begin predicting the fixations
for num_fix = 1:NUM_FIXATIONS 

    %First foveate the image about current fixation point
    fov_image = double(gaffe_foveate_image(im,fix_x,fix_y));
    figure(1); clf; imagesc(fov_image.^0.9); colormap gray; axis image;

    %Create the four saliency maps
    lum_pred_map = lum_prediction(fov_image,fix_x,fix_y);
    rms_pred_map = rms_prediction(fov_image,fix_x,fix_y);
    lum_dog_pred_map = lum_dog_prediction(fov_image,fix_x,fix_y);
    rms_gradient_pred_map = gradient_rms_prediction(fov_image,fix_x,fix_y);


    %Mask the edge artifacts
    lum_pred_map = lum_pred_map.*butter_mask;
    rms_pred_map = rms_pred_map.*butter_mask;
    lum_dog_pred_map = lum_dog_pred_map.*butter_mask;
    rms_gradient_pred_map = rms_gradient_pred_map.*butter_mask;


    %Normalize all maps
    lum_pred_map = lum_pred_map./max(lum_pred_map(:));
    rms_pred_map = rms_pred_map./max(rms_pred_map(:));
    lum_dog_pred_map = lum_dog_pred_map./max(lum_dog_pred_map(:));
    rms_gradient_pred_map = rms_gradient_pred_map./max(rms_gradient_pred_map(:));

    %Combine the four maps
    true_pred_map =wt(1)*lum_pred_map + wt(2)*rms_pred_map + ...
        wt(3)*lum_dog_pred_map + wt(4)*rms_gradient_pred_map;

    %Select the new fixation and add to the list
    [fix_x, fix_y] = selectFix(true_pred_map,fix_x_list, fix_y_list);

    fix_x_list = [fix_x_list; fix_x]; fix_y_list = [fix_y_list; fix_y]; %Update list of fix

    figure(2);  clf; imagesc(double(im).^0.8); colormap gray; axis image; 
    hold on; plot(fix_x_list,fix_y_list,'ro-');
    drawnow
    display('Please hit any key to continue');
    pause; 
 end % for num_fix = 1:5



