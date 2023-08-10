clear

% Visualisation parameters
nf = -40;                               % Noise floor
                                        % (range of beam pattern response)
dr = 20;                                % Spatial domain to plot
                                        % (no effect on computation)
sr = 1000;                               % Spatial resolution for plotting
                                        % (no effect on computation)
ar = 1e3;                               % Scanning angle resolution
                                        % (AFFECTS DoA estimation)

% Plane wave source characteristics
a  = 1;                                 % amplitude [m]
f  = 1e3;                               % frequency [Hz]
c  = 1.5e3;                             % speed of sound [m/s]
th = pi/4;                              % Direction of arrival [rad]

% Array parameters
N = 36;     % Number of hydrophones


% Compute ancillary quantities
l = c/f;                                % wavelength
k = 2.*pi.* ...
    [ cos( th ) ; sin( th ) ]./l;       % wave vector
d = l/2;                                % Array separation - must be <= l/2


% Calculate hyrdophone positions
Y = ( -ceil( N.*d./2 ):d:ceil( N.*d./2 ) ).';
X = zeros( size( Y ) );

% Signals at hydrophones
S = plane_wave( a , k , X , Y);

% Azimuth
Th = -pi/2:pi/1000:pi/2;

fprintf( 'Wavelength: %g m\n' , l );
fprintf( 'Array lattice spacing: %g m\n' , l/4 );
fprintf( 'Number of array elements: %g\n' , length( Y ) );
fprintf( 'Number of bearing samples: %g\n' , length( Th ) );
fprintf( 'Actual DoA: %g rad\n' , atan2( k(2) , k(1) ) );

% Beamformer output
B = DAS_beamformer( S , norm( k ) , [ X , Y ] , Th );

% Compute SPL and DoA
[ theta , SPL ] = DoA( B , Th );

figure; hold on;
% Source bearing
source_bearing = atan( k(2) / k(1) );
plot( Th , SPL , 'LineWidth' , 1 );
plot( [ source_bearing ; source_bearing ] , ...
    [ min( SPL ) ; max( SPL ) ] , 'LineWidth' , 2 );
plot( [ theta ; theta ] , ...
    [ min( SPL ) ; max( SPL ) ] , 'Linewidth' , 2 , 'LineStyle' , '--' );
axis( [ min( Th ) , max( Th ) , nf , 0 ] );
legend( 'Beamformed response' , 'Actual DoA' , 'Estimated DoA' , ...
    'Location' , 'southoutside' , 'Orientation','horizontal' )
box on;

figure; hold on;
[ XX , YY ] = meshgrid( -ceil( dr ):2*ceil( dr )/sr:ceil( dr ) );
contourf( XX , YY , real( plane_wave( a , k , XX , YY ) ) , ...
    'LineColor' , 'none' );
colormap sky;
axis square;
viscircles( [ X , Y ] , .1 , 'Color' , 'k' );
line( [ -1 , 1 ] , [ -1 , 1 ].*tan( theta ) , 'LineWidth' , 2 , 'Color' , 'r' );
box on;
