function theta = DoA( B , Th )
%DoA_plane_wave Estimate DoA assuming plane wave
%   B  - beamformer output
%   Th - sampled angles

% Find the largest beamformed responses
[ ~ , Id ] = max( abs( B ) );

% Use the largest value of input to estimate the DoA
theta = Th( Id );

fprintf( 'Estimated DoA: %g rad or %g rad\n' , theta , pi - theta );

end