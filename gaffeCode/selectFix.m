function [fix_x,fix_y] = selectFix(true_pred_map,fix_x_list,fix_y_list)

% Function to implement inhibition of return to previous fixations points
% and to select the maximum of the saliency map as the next fixation

% Author    : Umesh Rajashekar
% Date      : 4 Jan. 2008

gauss_mask = make_gauss_masks(fix_x_list,fix_y_list, size(true_pred_map));
inv_gauss_mask = max(gauss_mask(:)) - gauss_mask;
pred_map = true_pred_map.*inv_gauss_mask;

%Find the point of maximum prediction
max_prediction = max((pred_map(:)));
[fix_y fix_x] = find(pred_map == max_prediction);
fix_x = fix_x(1); fix_y=fix_y(1);