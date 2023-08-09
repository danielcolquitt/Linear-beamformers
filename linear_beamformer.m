function Y = linear_beamformer( S , k , Z , th )
%linear_beamformer Linear beamformer with uniform weights
%   S  - A vector of signals recevied at the hydrophones located at Z
%   k  - Local wavenumber
%   Z  - The coordinates Z = [ X , Y ] of the hydrophones
%   th - Bearing of steering vector

% Compute steering vector
V = exp( 1i.*Z*[ k*cos( th ) ; k*sin( th ) ] );

% Compute beamformer output,
Y = V'*S/length( S );

end