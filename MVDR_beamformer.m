function [ M , SR ] = MVDR_beamformer( S , f , c , Z , th , sth )
%MVDR_beamformer MVDR beamformer with adaptive weights.
%Outputs [ Power spectrum , Steered response ]
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

% Calculate steering vector (as column vector)
E = exp( 1i.*( k*[ cos( sth ) , sin( sth ) ]*Z ) ).';
% Calculate optimal weights corresponding to steering vector
W = Rinv*E/( E'*Rinv*E );

% Preallocate output vectors
M = NaN.*ones( length( th ) , 1 );
SR = M;

for thn = 1:length( th )
    % Compute scanning vector (as column vector)
    V = exp( 1i.*( k*[ cos( th( thn ) ) , sin( th( thn ) ) ]*Z ) ).';
    % Compute metric
    M( thn ) = abs( 1/(V'*Rinv*V) );
    SR( thn ) = real( W'*V );
end

M = 10*log10( M./max( M ) );

end