function P = plane_wave( a , k , X , Y)
%plane_wave Pressure field resulting from an acoustic plane wave
%propagating to/from infinity
%   a - Amplitude
%   k - Wave vector [ k1 ; k2 ]
%   X - x-coordinate
%   Y - y-coordinate

P = a.*exp( 1i.*( k(1).*X + k(2).*Y ) );

end