function E = ESPRIT_DOA(R, V, N, th, d)
% ESPRIT_DOA A simple implementation of the esprit (Estimation of signal
% parameters via rotational invariance techniques) beamformer for DoA 
% estimation. Works with Spatial smoothing. Returns estimated DoA value(s).
%   R - Spatial covariance matrix
%   V - Scanning vectors
%   N - Number of Recivers; multi-source use SAL for spatial smoothing 
%   th - Signal DoA; only need to know number of signals
%   d - Element spacing

% Sanity check of input
if size( R , 1 ) ~= size( R , 2 )
    error( 'Covariance matrix should be square' );
elseif size( R , 1 ) ~= size( V , 2 )
    error( 'Number of columns/rows in R should be equal to the number of columns in V');
end

% Compute SVD (Singular Value Decomposition) of R
[U, S, V] = svd(R) ;

% Left signular vectors corresponding to the source
S = U(:, 1:length(th)) ;

% Partion submarticies 
S1 = S(1:N-1,:) ;
S2 = S(2:N, :) ;

% Compute P via LS (Least Squares)
P = S1\S2 ;

% Find the angles of the Eigenvalues of P
W = angle(eig(P)) / (2*pi*d) ;
E = asind(-W) ;


end