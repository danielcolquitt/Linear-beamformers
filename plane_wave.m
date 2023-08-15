function P = plane_wave( a , th , f , c  , X , Y , t )
%plane_wave Pressure field resulting from an acoustic plane wave
%propagating to/from infinity
%   a  - Amplitude
%   th - Angle of attack
%   c  - wavespeed
%   X  - x-coordinate
%   Y  - y-coordinate
%   t  - time

% Compute wave vector
k = 2.*pi.*f./c.*[ cos( th ) , sin( th ) ];

P = a.*exp( 1i.*( k(1)*X + k(2)* Y) ).'*exp( -1i.*2.*pi.*f.*t );

end