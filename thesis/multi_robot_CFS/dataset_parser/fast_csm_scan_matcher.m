function [R, T, covariance] = fast_csm_scan_matcher(timestamp_1, range_1, timestamp_2, range_2, initial_guess)

% Return if no LIDAR data is recorded while logging a odom data.
if isempty(range_1) || isempty(range_2)
    R = [];
    T = [];
    return
end

% Function to prepare data and call ICP.
nrays = 181;
min_angle = -pi/2;
max_angle = pi/2;
angle_increment = pi/181;

[T, theta, covariance] = mex_csm_caller(timestamp_1, range_1, timestamp_2, range_2, ...
                            initial_guess, nrays, min_angle, max_angle, angle_increment);
%     mex_csm_caller(timestamp_1, range_1, timestamp_2, range_2, ...
%                                 nrays, min_angle, max_angle, angle_increment);
                        
R = [cos(theta), -sin(theta), 0;
     sin(theta), cos(theta), 0;
     0, 0, 1];
