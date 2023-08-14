function P = plane_wave( a , th , f , l  , X , Y , t )
%plane_wave Pressure field resulting from an acoustic plane wave
%propagating to/from infinity
%   a  - Amplitude
%   th - Angle of attack
%   l  - Wavelength
%   X  - x-coordinate
%   Y  - y-coordinate
%   t  - time


% Compute wave vector
k = 2.*pi.*[ cos( th ) , sin( th ) ]./l;

P = a.*exp( 1i.*( k(1)*X + k(2)* Y) ).'*exp( -1i.*2.*pi.*f.*t );

end