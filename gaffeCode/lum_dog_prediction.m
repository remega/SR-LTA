function pred_map = lum_dog_prediction(my_image,x_center, y_center)

% Function to filter a foveated image using the center-surround of
% luminance

% Author    : Umesh Rajashekar
% Date      : 4 Jan. 2008

load all_gabors_params_fft_results; %Load center-surround filters

my_image = double(my_image);[R C] = size(my_image);
%Create mask to supress edge artifacts
butter_mask = make_butter_rect(C, R, C*0.35, R*0.35, 10);

%% Space variying filtering depending on saccade size

%Filter using  FFT
FFT_SIZE  = size(my_image) + size(final_gabors(:,:,1)) - 1;
image_fft = fft2(my_image, FFT_SIZE(1), FFT_SIZE(2));

for gabs_ind = 1:size(final_gabors,3)
    use_gabor = final_gabors(:,:,gabs_ind);
    temp_filtered = abs(ifft2( image_fft .* fft2(use_gabor, FFT_SIZE(1), FFT_SIZE(2))));

    %Pick out the valid entries
    start_ind = size(final_gabors(:,:,1),1)/2;
    temp_valid = temp_filtered(start_ind:start_ind+R-1,start_ind:start_ind+C-1);
    temp_valid = temp_valid.*butter_mask;
    temp_valid = temp_valid./sqrt(mean(temp_valid(:).^2));
    valid_filtered(:,:,gabs_ind) = (temp_valid);   
end

%% Make the final filtered image by combining the space varying filtered outputs according to saccade magnitudes

[IMAGE_HEIGHT, IMAGE_WIDTH] = size(my_image);
x_center = floor(x_center - IMAGE_WIDTH /2);
y_center = floor(y_center - IMAGE_HEIGHT /2);
[fx fy] = meshgrid(linspace(-IMAGE_WIDTH/2,IMAGE_WIDTH/2,IMAGE_WIDTH), linspace(-IMAGE_HEIGHT/2,IMAGE_HEIGHT/2,IMAGE_HEIGHT));
shift_radial_freq = round(abs((fx - x_center) + j*(fy - y_center)));
shift_radial_freq = shift_radial_freq + 1; % 0 eccen is mapped into array index =1

SACC_RANGE = [0.0300 1.6800 2.4500 3.4500 4.9800 14.9900];
PIXEL_RANGE = round(SACC_RANGE *60); %Convert from degrees to pixels
PIXEL_RANGE(1) =1; PIXEL_RANGE(end) = max(shift_radial_freq(:));

pred_map = ones(IMAGE_HEIGHT,IMAGE_WIDTH)*-1; %Initialize to -1

for sacc_ind = 1:length(PIXEL_RANGE)-1
    use_eccen = shift_radial_freq;
    start_eccen = PIXEL_RANGE(sacc_ind);
    end_eccen = PIXEL_RANGE(sacc_ind+1);
    
    %Remove patches that do not satisy eccentricity criterion
    use_eccen(shift_radial_freq < start_eccen) = -1;
    use_eccen(shift_radial_freq > end_eccen) = -1;
    use_index = find(use_eccen ~= -1);
    use_filtered = valid_filtered(:,:,sacc_ind);
    
    pred_map(use_index) = use_filtered(use_index);

end


