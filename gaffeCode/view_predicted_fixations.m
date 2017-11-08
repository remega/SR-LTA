% Function to view the true fixations (as a pseudo-dense map) with overlay
% of fixations predicted by GAFFE

%To run this program, you will need the images and true fixations from the
%DOVES database (http://live.ece.utexas.edu/research/doves and the set of
%predicted fixations provided with GAFFE (http://live.ece.utexas.edu/research/GAFFE)

% Author    : Umesh Rajashekar
% Date      : 4 Jan. 2008

clear; close all;

%% DIRECTORY LOCATIONS
IMAGES_DIR          = '../VanhatImages/'; %van Hateren Images
PREDICTED_FIXATIONS_DIR = '../PredictedFixations/'; %Fixations predicted by GAFFE
RECORDED_FIXATIONS_DIR = '../RecordedFixations/'; %Recorded Fixations

%% Load in the image
image_name = 'imk01019.iml'; %Flower
im = (read_vanhat_foranalysis([IMAGES_DIR image_name]));
[R C] = size(im);

%% Read in recorded fixations for this image

load ([RECORDED_FIXATIONS_DIR image_name '.mat']); %loads subj_names_list, fix_data, eye_data

fixX = []; fixY=[]; %Variables to store (x,y) of fixations for all subjects 

%Collect the fixations for all subjects
for iSubj = 1:length(subj_names_list) %
    %The computed fixations for the subject
    fixData = fix_data{iSubj};
    fixX = [fixX fixData(1,:)]; fixY=[fixY fixData(2,:)]; 
end

%Make the pseudo-dense map by replacing each fixation with a Gaussian
true_fix_pseudo_map = make_gauss_masks(fixX,fixY,[R C]); 

%% Read in predicted fixations for this image
load ([PREDICTED_FIXATIONS_DIR image_name '.mat']); %loads fix_x_list, fix_y_list


%% Plots
figure(1); clf;

%Show the original image
subplot(2,1,1); imagesc(im.^(0.9)); axis image; colormap gray; hold on; title(image_name);

%Show the pseudo-dense map of all fixations for this image
subplot(2,1,2), imagesc(true_fix_pseudo_map.^0.8); axis image; colormap gray; hold on;

%Overlap the fixations predicted by GAFFE
plot(fix_x_list(1:10),fix_y_list(1:10),'ro-');

