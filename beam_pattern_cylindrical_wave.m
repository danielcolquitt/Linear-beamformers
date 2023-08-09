clear

% Set the noise floor (range of beam pattern response)
noise_floor = -40;

% Length of array
L = 20;

% Cylindrical wave source characteristics
x0 = -25;
y0 = 25;
k = 2;
a = 1;

% Wavelength
lambda = 2*pi/norm( k );

% Calculate hyrdophone positions
Y = ( -ceil( L/2 ):lambda/4:ceil( L/2 ) ).';
X = zeros( size( Y ) );

% Signals at hydrophones
S = cylindrical_wave( a , k , X , Y , x0 , y0 );

% Azimuth
Th = -pi/2:pi/1000:pi/2;

fprintf( 'Wavelength: %g m\n' , lambda );
fprintf( 'Array lattice spacing: %g m\n' , lambda/4 );
fprintf( 'Number of array elements: %g\n' , length( Y ) );
fprintf( 'Number of bearing samples: %g\n' , length( Th ) );
fprintf( 'Actual DoA: %g rad\n' , atan( y0 / x0 ) );

% Beamformer output
B = linear_beamformer( S , norm( k ) , [ X , Y ] , Th );

% Compute SPL and DoA
[ theta , SPL ] = DoA( B , Th );

figure; hold on;
% Source bearing
source_bearing = atan( y0 / x0 );
plot( Th , SPL , 'LineWidth' , 1 );
plot( [ source_bearing ; source_bearing ] , ...
    [ min( SPL ) ; max( SPL ) ] , 'LineWidth' , 2 );
plot( [ theta ; theta ] , ...
    [ min( SPL ) ; max( SPL ) ] , 'Linewidth' , 2 , 'LineStyle' , '--' );
axis( [ min( Th ) , max( Th ) , noise_floor , 0 ] );
legend( 'Beamformed response' , 'Actual DoA' , 'Estimated DoA' , ...
    'Location' , 'southoutside' , 'Orientation','horizontal' )
box on;

figure; hold on;
[ XX , YY ] = meshgrid( -2*ceil( L/2 ):2*L/1000:ceil( L/2 )*2 );
contourf( XX , YY , real( cylindrical_wave( a , k , XX , YY , x0 , y0 ) ) , ...
    'LineColor' , 'none' );
colormap sky;
axis square;
viscircles( [ X , Y ] , .1 , 'Color' , 'k' );
line( [ -1 , 1 ] , [ -1 , 1 ].*tan( theta ) , 'LineWidth' , 2 , 'Color' , 'r' );
box on;