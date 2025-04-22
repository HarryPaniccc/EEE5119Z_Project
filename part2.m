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

range_compressed_data = zeros(size(data,1), size(data,2) + length(S_bb) - 1); % The number of columns is dictated by the output length of the convolutions

for i = 1:size(range_compressed_data,1)
%    reverse_conj_signal = conj(flip(data(i,:)));
    range_compressed_data(i,:) = conv(data(i,:), reverse_conj_signal(:)); % definition in the project pdf doesn't reverse and conjugate Tx, just normal convolution of Rx and Tx
end

mesh(abs(data))
