function E = Bartlett_DOA( R , V )
%Bartlett_DOA A simple implementation of the Bartlett/DAS beamformer for
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
E = NaN.*( 1 + 1i ).*ones( 1 , size( V , 1 ) );

% Loop over the scanning vectors and compute the power output
for thn = 1:length( E )
    E( thn ) = conj( V( thn , : ) )*R*V( thn , : ).';
end


end