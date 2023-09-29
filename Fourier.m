% Fourier Transformation of a Cosine Pulse
% This script performs the Fourier transformation of a cosine pulse using
% both MATLAB's built-in FFT function and numerical integration of Fourier
% transformation's mathematical equation. Its goal is to provide insights 
% into the Fourier transformation of analytical expressions and to compare 
% the efficiency and accuracy of different methods.

% Clear the workspace and close all figures
clear;
close all;

% ===== Define Parameters =====

% Define the time vector
t = linspace(-1000, 1000, 10000);  % Time vector spanning from -1000 to 1000 with 10000 points

% Define the parameters of the cosine pulse
Fo = 0.05;   % Amplitude of the Pulse
tau = 15;    % Duration of the Pulse
omega = 1;   % Frequency of the Pulse

% Define the cosine pulse
Fx = @(t) Fo .* exp(-((t ./ tau) .^ 2)) .* cos(omega .* t);  % Analytical expression for a cosine pulse

% Numerical values of the pulse
X = Fx(t);

% ===== Plotting the Original Cosine Pulse =====

figure(1)
plot(t, X, 'LineWidth', 2)
title('Original Cosine Pulse')
xlabel('Time (s)')
ylabel('Amplitude')
xlim([-60, 60]);
grid on
ax = gca;
ax.FontSize = 15;
ax.FontWeight = 'bold';
ax.LineWidth = 2;

% ===== Fourier Transformation using MATLAB's built-in FFT function =====

L = length(t);
Y = fft(X);                      % Fast Fourier Transform of the cosine pulse
P2 = abs((Y) ./ L);
P1 = P2(1:L/2 + 1);
P1(2:end - 1) = 2 * P1(2:end - 1);  % Choosing only positive half of frequencies
F_w = (abs(P1));

% Frequency vector for the FFT results
Fs = length(t) / (t(end) - t(1));
f = 2 * pi * Fs * (0:(L / 2)) / L;

% Plot the Frequency spectrum obtained using FFT
figure(2)
plot(f, ((F_w) .* (t(end) - t(1))), 'LineWidth', 2)
title('FFT Function')
xlim([0 10])  % Limit x-axis to display 0 Hz to 10 Hz for clarity
xlabel('\omega / \omega_{fx}')
ylabel('|F_x (w)|^2 ')
ax = gca;
ax.FontSize = 15;
ax.FontWeight = 'bold';
ax.LineWidth = 2;

% ===== Fourier Transformation using Numerical Integration =====

% Integration limits for numerical integration units
W = linspace(-5, 5, 1000);

% Loop over all possible frequencies
for i = 1:length(W)
    w = W(i);
    FX = furier(Fo, tau, omega, w);
    F_x(i) = real(FX);
end

% Plot the power spectrum obtained using numerical integration
figure(3)
plot(W, F_x, 'LineWidth', 2)
title('Integration')
xlabel('Frequency (f)')
ylabel('|f|')
ax = gca;
ax.FontSize = 15;
ax.FontWeight = 'bold';
ax.LineWidth = 2;

function FX = furier(F_o, tau, omega, w)
% This function calculates the output of numerical integration for each 
% input of frequency in the exponential of Fourier transformation.

    fx = @(t) F_o .* exp(-((t ./ tau) .^ 2)) .* cos(omega .* t) .* exp(1i .* w .* t);
    % Integration performed over a specified range which ideally should be from -Inf to +Inf.
    FX = integral(fx, -60, 60);
end
