function M = Capon_DOA( R , V )
%Capon_DOA A simple implementation of the Capon/MVDR beamformer for
%DoA estimation.
%   R - Spatial covariance matrix
%   V - Scanning vectors

% Sanity check of input
if size( R , 1 ) ~= size( R , 2 )
    error( 'Covariance matrix should be square' );
elseif size( R , 1 ) ~= size( V , 2 )
    error( 'Number of columns/rows in R should be equal to the number of columns in V');
end

% Initialise output vector
M = NaN.*( 1 + 1i ).*ones( 1 , size( V , 1 ) );

% Compute Moore-Penrose pseudoinverse of covariance matrix --- more
% reliable than direct inverse
Rinv = pinv( R );

% Loop over the scanning vectors and compute the metric (SNR *not* power)
for thn = 1:length( M )
    M( thn ) = 1/( conj( V( thn , : ) )*Rinv*V( thn , : ).' );
end


end