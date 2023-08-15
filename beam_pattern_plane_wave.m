clear

% Visualisation parameters
nf = -30;                               % Noise floor
                                        % (range of beam pattern response)
dr = 20;                                % Spatial domain to plot
                                        % (no effect on computation)
sr = 1e3;                               % Spatial resolution for plotting
                                        % (no effect on computation)
ar = 1e3;                               % Scanning angle resolution
                                        % (AFFECTS DoA estimation)
est_DoA = false;                        % Estimate DoA from max of metric
                                        % N.B. Does not work well for
                                        % multiple sources

% Plane wave source characteristics
c  = 0.02e6;                            % speed of sound [m/s]
a  = [ 1 , 1 , 1];                   % Vector of wave amplitudes [m]
f  = [ 1e6 , 1e6 , 1e6 ];      % Vector of frequencies [Hz]
th = [ -10 , 5 , 30 ]*pi/180;          % Vector of direction of
                                        % arrivals [rad]

% Array characteristics
sample_r = 1e6;                         % Sampling rate
sample_N = 1e4;                         % Sampling window
noise_a  = 0.04;                        % Amplitude of AWGN
N        = 8;                           % Number of sensors
target_f = 1e6;                      % Target frequency

% Compute ancillary quantities
target_l = c./target_f;                 % wavelength
d = target_l/2;                         % Array separation - must be <= l/2
t = ( 0:(sample_N-1) )./sample_r;       % Time vector 

% Annonymous function describing incoming signal
signal = @(x,y) ( 0 );
for nw = 1:length( a )
    signal = @(x,y) ( signal( x , y ) ...
        + plane_wave( a( nw ) , th( nw ) , f( nw ) , c , x , y , t ) );
end

% Calculate hyrdophone positions
Y = ( ( ( 0:( N-1 ) ) - ( N - 1)./2 ).*d );
X = zeros( size( Y ) );

% Signals at hydrophones
S = signal( X , Y) + AWGN( noise_a , N , sample_N );

% Azimuth
Th = -pi:2*pi/ar:pi;

fprintf( 'Target Wavelength: %g m\n' , target_l );
fprintf( 'Array lattice spacing: %g m\n' , d );
fprintf( 'Number of array elements: %g\n' , length( Y ) );
fprintf( 'Number of bearing samples: %g\n' , length( Th ) );
fprintf( 'Actual DoA: %g rad\n' , th);

% Beamformer output
B = DAS_beamformer( S , target_f , c , [ X ; Y ] , Th );
%B = MVDR_beamformer( S , target_f , c , [ X ; Y ] , Th );

if est_DoA == true
    % Compute SPL and DoA
    theta = DoA( B , Th );
end

% Metric and DoA estimation
figure; hold on;
plot( Th , B , 'LineWidth' , 1 );
for thn = 1:length( th )
    plot( [ th( thn ) ; th( thn ) ] , ...
        [ min( B ) ; max( B ) ] , 'Color' , '#D95319' , 'LineWidth' , 1 );
end
if est_DoA == true
    plot( [ theta ; theta ] , ...
        [ min( B ) ; max( B ) ] , 'Linewidth' , 1 , ...
        'Color' , '#EDB120' , 'LineStyle' , '--' );
    plot( [ pi - theta ; pi - theta ] , ...
        [ min( B ) ; max( B ) ] , 'Linewidth' , 1 , ...
        'Color' , '#EDB120' , 'LineStyle' , '--' );
end
axis( [ min( Th ) , max( Th ) , min( B ) , max( B ) ] );
box on;
hold off;

% Polar plot of Metrics and DoA estimation
figure;
ax = polaraxes; hold on;
polarplot( Th , B , 'LineWidth' , 1);
for thn = 1:length( th )
    polarplot( [ th( thn ) ; th( thn ) ] , ...
        [ min( B ) ; max( B ) ] , 'Color' , '#D95319' , 'LineWidth' , 1 );
end
if est_DoA == true
    polarplot( [ theta ; theta ] , ...
        [ min( B ) ; max( B ) ] , 'Linewidth' , 1 , ...
        'Color' , '#EDB120' , 'LineStyle' , '--' );
    polarplot( [ pi - theta ; pi - theta ] , ...
        [ min( B ) ; max( B ) ] , 'Linewidth' , 1 , ...
        'Color' , '#EDB120' , 'LineStyle' , '--' );
end
rlim( [ min( B )  max( B ) ] )
hold off;