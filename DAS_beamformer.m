function [ B , V ] = DAS_beamformer( S , k , Z , th )
%DAS_beamformer DAS beamformer (unweighted)
%Outputs [ Beampattern , Phase Delays ]
%   S  - A vector of signals recevied at the hydrophones located at Z
%   k  - Local wavenumber
%   Z  - The coordinates Z = [ X , Y ] of the hydrophones
%   th - Bearing of steering vector


% Preallocate output vector
B = NaN.*ones( length( th ) , 1 );

% Estimate covariance matrix
R = S*S'/size( S , 2 );

for thn = 1:length( th )
    % Compute steering vector (as column vector)
    V = exp( 1i.*( k*[ cos( th( thn ) ) , sin( th( thn ) ) ]*Z ) ).';
    % Beamform
    B( thn ) = abs( V'*R*V );
end


B = log10( B )./log10( max( B ) );


end