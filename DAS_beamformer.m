function [ B , SR ] = DAS_beamformer( S , f  , c , Z , th , sth )
%DAS_beamformer DAS beamformer (unweighted)
%Outputs [ Matric , Steered response ]
%   S   - A vector of signals recevied at the hydrophones located at Z
%   k   - Target frequency
%   c   - wavespeed
%   Z   - The coordinates Z = [ X , Y ] of the hydrophones
%   th  - Bearing
%   sth - Bearing of steering vector (where are we looking)

% Calculate wavenumber
k = 2.*pi.*f./c;

% Compute the steering vector (as column vector)
E = exp( 1i.*( k*[ cos( sth ) , sin( sth ) ]*Z ) ).';

% Preallocate output vector
B = NaN.*ones( length( th ) , 1 );
SR = B;

% Estimate covariance matrix
R = S*S'/size( S , 2 );

for thn = 1:length( th )
    % Compute scanning vector (as column vector)
    V = exp( 1i.*( k*[ cos( th( thn ) ) , sin( th( thn ) ) ]*Z ) ).';
    % Beamform
    B( thn ) = abs( V'*R*V );
    SR( thn ) = real( E'*V );
end


B = 10*log10( B./max( B ) );


end