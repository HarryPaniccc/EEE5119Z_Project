%% PPNHAR001 EEE5119Z
% Course project: SAR Radar Part 2

clear
cd /home/harry/Documents/uni/2025F/EEE5119Z/EEE5119Z_Project/
load('sim_data_single.mat');
c = 3e8; % m/s
delta = p.B / p.ts; % rate of frequency change
base_frequency = c/p.lambda; % Around 10 GHz


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 1 - Apply ranged compression
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generating Sbb
f_sample = p.B;

dt = 1/f_sample; % Time divisions for our time domain
t = -5*10^-6 : dt : 5*10^-6 - dt;
rect_width = p.ts;
S_bb = exp(1j*pi*delta*t.^2) .* transpose(rect_function(t, 0, rect_width)); % Define signal. The length should be the same length as the received data.
reverse_conj_signal = conj(flip(S_bb));

range_compressed_data  = zeros(size(data,1) + length(S_bb) - 1, size(data,2));
for i = 1:size(range_compressed_data,2)
    range_compressed_data(:,i) = conv(data(:,i).', reverse_conj_signal(:)).'; 
end

plotted_data = pow2db(abs(range_compressed_data));

figure
imagesc(plotted_data)
colorbar
xlabel('Range Bins')
ylabel('Slow Time / Pulses')
title('Range Compressed Data (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 2 - Estimate 3dB range resolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dont actually know what they want here?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 3 - Take a Doppler fft and plot the RDM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range_doppler_map = zeros(size(range_compressed_data));
for i = 1:size(range_doppler_map,1)
    range_doppler_map(i,:) = fft(range_compressed_data(i,:));
end

plotted_data = pow2db(abs(range_doppler_map));

figure
imagesc(plotted_data)
colorbar
xlabel('Range Bins')
ylabel('Slow Time / Pulses')
title('Doppler fftd data (dB)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 4 - Azimuth compression
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range_over_time = sqrt(p.vec_range.^2 + p.vec_azimuth.^2);
azimuth_phase_variation = exp(-1j * 4 * pi * range_over_time / p.lambda);
azimuth_compressed_data  = zeros(size(range_doppler_map, 1), size(range_doppler_map, 2) + length(reverse_conj_signal) - 1);



for i = 1:size(azimuth_compressed_data,1)
    azimuth_compressed_data(i,:) = conv(range_doppler_map(i,:), reverse_conj_signal(:)); % This is wrong. Use the description of the process in the handout.
end

plotted_data = pow2db(abs(azimuth_compressed_data));

figure
imagesc(plotted_data)
colorbar
xlabel('Range Bins')
ylabel('Slow Time / Pulses')
title('Range Compressed Data (dB)')
