%% PPNHAR001 EEE5119Z
% Course project: SAR Radar Part 1

clear
cd /home/harry/Documents/uni/2025F/EEE5119Z/EEE5119Z_Project/
load('sim_data_single.mat');
c = 3e8; % m/s
delta = p.B / p.ts; % rate of frequency change
base_frequency = c/p.lambda; % Around 10 GHz

% Parameters for testing
signal_is_noise = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 1
% - [x]sampling freq for no range ambiguities
% - [ ]prf for no azimuth ambiguities due to sub-sampling
% - [x]theoretical range resolution
% - [x]theoretucal azimuth resolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beam_center_length = p.h / sin(p.theta); % The range of the middle of the beam

% If aperture is in the direction of motion, then p.L informs beamwidth and which informs the max range
beamwidth = (0.886 * p.lambda) / p.L;
max_range = p.h / sin(p.theta - beamwidth/2); % Simple trig if the depression angle gets smaller by half the beamwidth
PRF_min = c / (2 * max_range); % Increasing Rmax means decreasing PRF

% range resolution
p.delta_R = c/(2*p.B); % I mean this makes sense

% azimuth resolution - equation 21.1 - 3 in PoMR
p.delta_Az = (max_range * p.lambda) / p.L;


% PRF gives us max range (unambiguous)
% PRF gives max measurable doppler
% Can sample at B because of downsampling and IQ

f_sample = p.B;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generating Sbb
%dt = 1 * 10^-9; % Time divisions for our time domain
dt = 1/f_sample; % This might make more sense
t = -5*10^-6 : dt : 5*10^-6 - dt;

rect_width = p.ts; % This ensures the length of the chirp is correct
S_bb = exp(1j*pi*delta*t.^2) .* transpose(rect_function(t, 0, rect_width)); % Define signal

if signal_is_noise == true
    noise = randn(length(t));
    S_bb = noise(1, :);
end

% Plotting the envelope of the chirp, I think it should just be the rect function so whatever
figure
plot(t, transpose(rect_function(t, 0, rect_width)), LineWidth=2);

figure
plot(t, real(S_bb), LineWidth=2);

figure
plot(t, imag(S_bb), linewidth = 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 3
%-[x]Ambiguity function of Sbb
%-[x]0 range cut
%-[x]0 doppler cut
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PoMR 801: AF seems to be just AF(t, fd) = |S(t)*shift convolved with S(t)|

% Normalizing the chirp
S_bb_u = S_bb / sqrt(sum(abs(S_bb).^2));


% Defining doppler ranges
d_doppler = 10; % should be doppler res
f_doppler = -500: d_doppler : 500 - d_doppler;

% Normalizing the time axis
time_axis = t/(5000*dt);
doppler_modifier = exp(1j * 2 * pi * f_doppler' .* t); % As desired its time wide x doppler tall

shifted_signal = S_bb_u .* doppler_modifier; % <<< might blow up matlab
conv_signal = zeros(length(f_doppler), 2*length(S_bb_u) - 1);

% For loop method for this
for i = 1:length(f_doppler)
    conv_signal(i,:) = conv(shifted_signal(i,:), conj(flip(S_bb_u))); % conv makes it 2x-1 sized?
end

AF = pow2db(abs(conv_signal)); % db measurements
decimation_factor = 10;
AF_decimated = AF(1:decimation_factor:end, 1:decimation_factor:end);
figure
mesh(AF_decimated); % Can decimate the plot by a factor of 10 or 100

zero_range_cut = AF(round(size(AF,1)/2), :);
figure
plot(zero_range_cut);

zero_doppler_cut = AF(:, round(size(AF,2)/2));
figure
plot(zero_doppler_cut);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beam_angles = -pi : 1/1000 : pi;
x = pi * p.L * sin(beam_angles) / p.lambda; % Im restarted I think
antenna_pattern = (p.L .* sinc_function(x)).^2;

figure
plot(beam_angles, pow2db(abs(antenna_pattern)));

% Coffee cup example, what would you see at a target not the shape of the pattern 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Question 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the 3dB range one, Q4 is across all angles

% beamwidth is the -3dB point, and is 0.0266 radians
target_angles = -beamwidth/2: 1/10000 : beamwidth/2; % Beamwidth is in radians
x = pi * p.L * sin(target_angles) / p.lambda; % Im restarted I think
target_appearance = (p.L .* sinc_function(x)).^2;

figure
plot(target_angles, pow2db(abs(target_appearance)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%