% TP - Communications 
% Code developed by the following students:
% Lucas TRAMONTE
% Vitor OPSFELDER ESTANISLAU
% Max LEE

% TP - Communications 
% Given information:

Pt = 30; % Transmit power in dBm
W = 10 * 10^6; % Bandwidth in Hz
s = 5; % System loss in dB
SNR_min = 30; % Minimum Signal-to-Noise Ratio in dB
A = 41; % Constant A in dB
B = 22.7; % Constant B in dB

% Calculate the noise using the expression:

N = -174 + 10 * log10(W); % Noise power in dBm

% Calculate the maximum distance:

d = 10^((Pt - A - s - N - SNR_min) / B); % Maximum distance in meters

% To prevent disconnection, the vehicle must be located between two access points. 
% Thus, the maximum distance D will be 2*d.

D = 2 * d;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ALOHA: 

% Assume ALOHA transmission can be modeled as a Poisson process. 
% The transmission occurs for 1 packet every 100 ms, 
% therefore, the parameter <<lambda>> is calculated as follows: 

lambda = 1 / (100 * 10^-3); % Arrival rate in packets per second

% Calculate the parameter T_f, which is the transmission time for each packet.
% Each packet is 500 bytes (500*8 = 4000 bits). 
% With a spectral efficiency of 1 bit/s/Hz and a bandwidth of 10 MHz, 
% the transmission time is:

Tf = (500 * 8) / (10^7); % Transmission time in seconds

% The probability that packets do not overlap is given by:
% P_success = exp(-2*(N-1)*lambda*Tf)
% Therefore, the probability of overlap will be the complement:

% Generate a range of vehicles from 2 to 50 for graphing:

N = 2:1:50; % Number of vehicles
P = 1 - exp(-2 * (N - 1) * lambda * Tf); % Probability of overlap
semilogy(N, P) % Logarithmic plot
title('Probability of Overlap by Number of Vehicles (ALOHA)')
xlabel('Number of Vehicles')
ylabel('Probability')
grid on;

% Variables for CSMA:

W = 5; % Updated bandwidth for CSMA
q = 1 - exp(-lambda * Tf); % Transmission probability

tol = 1e-4; % Stopping criterion for the iterative method
dif = 10; % Difference initialization
pc = 0; % Initial probability of collision
it = 0; % Iteration counter

% Compute collision probabilities for different values of m:
pc_calc1 = compute_CSMA(2, tol, q, W);
pc_calc2 = compute_CSMA(3, tol, q, W);
pc_calc3 = compute_CSMA(4, tol, q, W);

% Comparison between ALOHA and CSMA
figure()
semilogy(N, P, N, pc_calc1.^2, N, pc_calc2.^3, N, pc_calc3.^4)
legend('ALOHA', 'CSMA (m = 2)', 'CSMA (m = 3)', 'CSMA (m = 4)')
title('Probability of Overlap by Number of Vehicles')
xlabel('Number of Vehicles')
ylabel('Probability')
grid on;

% Function to compute CSMA collision probabilities:
function [pc_calc] = compute_CSMA(m, tol, q, W)
    pc_calc = []; % Initialize collision probability array
    pc = 0; % Initial probability of collision
    for k = 2:1:50 
        dif = 10; % Initialize difference for iteration
        while (abs(dif) > tol)
            pc_ant = pc; % Previous probability of collision
            pc = 1 - (1 - q * (1 - pc_ant^m) / (1 - pc_ant) * ...
                (1 / (1 + q * (1 - pc_ant^m) / (1 - pc_ant) * ...
                (1 + (W - 1) / (2 * (1 - pc_ant))))))^k;
            dif = pc - pc_ant; % Calculate difference
        end
        pc_calc = [pc_calc, pc]; % Append to the results
    end
end
