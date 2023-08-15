function [ B , V ] = DAS_beamformer( S , f  , c , Z , th )
%DAS_beamformer DAS beamformer (unweighted)
%Outputs [ Beampattern , Phase Delays ]
%   S   - A vector of signals recevied at the hydrophones located at Z
%   k   - Target frequency
%   c   - wavespeed
%   Z   - The coordinates Z = [ X , Y ] of the hydrophones
%   th  - Bearing
%   sth - Bearing of steering vector (where are we looking)

% Calculate wavenumber
k = 2.*pi.*f./c;

% Preallocate output vector
B = NaN.*ones( length( th ) , 1 );

% Estimate covariance matrix
R = S*S'/size( S , 2 );

for thn = 1:length( th )
    % Compute scanning vector (as column vector)
    V = exp( 1i.*( k*[ cos( th( thn ) ) , sin( th( thn ) ) ]*Z ) ).';
    % Beamform
    B( thn ) = abs( V'*R*V );
end


B = 10*log10( B./max( B ) );


end