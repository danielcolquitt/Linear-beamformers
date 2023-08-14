function M = MVDR_beamformer( S , f , c , Z , th )
%MVDR_beamformer MVDR beamformer with adaptive weights.
%Outputs Metric (Power spectral density) of the beamformer
%   S  - A vector of signals recevied at the hydrophones located at Z
%   f  - Target frequency
%   c  - Local wavespeed
%   Z  - The coordinates Z = [ X , Y ] of the hydrophones
%   th - Bearing of steering vector

% Calculate local wavenumber
k = 2*pi.*f./c;

% Estimate covariance matrix and its inverse
R = S*S'/length( S );
Rinv = pinv( R );

% Preallocate output vectors
M = NaN.*ones( length( th ) , 1 );

for thn = 1:length( th )
    % Compute steering vector (as column vector)
    V = exp( 1i.*( k*[ cos( th( thn ) ) , sin( th( thn ) ) ]*Z ) ).';
    % Compute metric
    M( thn ) = abs( 1/(V'*Rinv*V) );
end

M = 10*log10( M./max( M ) );

end