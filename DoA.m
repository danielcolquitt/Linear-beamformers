function [ theta , SPL ] = DoA( Y , Th )
%DoA_plane_wave Estimate DoA assuming plane wave
%   Y  - beamformer output
%   Th - sampled angles

% Compute SPL
SPL = 10*log10( abs( Y ).^2/max( abs( Y ).^2 ) );

% Find the two largest beamformed responses
[ ~ , Id ] = maxk( abs( Y ).^2 , 2 );

% Use the largest two values to estimate the DoA
theta = ( Th( Id(1) ) + Th( Id(2) ) )./2 ;

fprintf( 'Estimated DoA: %g rad or %g rad\n' , theta , theta + pi );

end