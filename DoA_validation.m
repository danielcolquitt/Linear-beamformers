% A simple script to estimate DoA of a temporally random plane wave.
% The script incorporates uncorrelated AWGN sensor noise. Bartlett and
% Capon beamformers are compared.

clear

d  = 1/2;                % Element spacing (normalised by wavelength)
N  = 4;                  % Number of receivers
th = 40*pi/180;          % DoA for signal [ rad ]
sn = 2^12;               % Signal sample size

% Create array
[ X , Y ] = linear_array( d , N );

% Compute array response vectors
A = UARV( X , Y , th );

% Create test signal (random gaussian)
Sig = randn( 1 , sn );

% Add some uncorrelated noise
Noi = sqrt(0.1)*randn( N , sn );

% Total signal at receivers
RS = A.'*Sig + Noi;

% Estimate correlation matrix
R = RS*RS';

% Define scanning angles
Th = (-pi/2:pi/300:pi/2).';

% Compute scanning vectors
V = UARV( X , Y ,  Th );

% Estimate DoA using Bartlett
B = Bartlett_DOA( R , V );

% Estimate DoA using Capon
C = Capon_DOA( R , V );

% Plot it
ax = axes(); hold on;
plot_DOA( Th , B , ax )
plot_DOA( Th , C , ax )
% Check if peak is in the right-half of the plot
[ ~ , th0n ] = max( C );
lgd = legend('Bartlett','Capon');
if th0n > round( length( Th )/2 )
    % If it is, place the legend on the LHS
    lgd.Location = 'northwest';
end
axis tight;
box on;
xlabel('Direction of Arrival [rad]');
ylabel('dB');
title('DoA estimation');
hold off;
