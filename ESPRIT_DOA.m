function E = ESPRIT_DOA(R, V, N, th, d)
% ESPRIT_DOA A simple implementation of the ESPRIT (Estimation of signal
% parameters via rotational invariance techniques) algorithm for DoA 
% estimation. Works with Spatial smoothing. Returns estimated DoA value(s).
%   R - Spatial covariance matrix
%   V - Scanning vectors
%   N - Number of Recivers; multi-source use SAL for spatial smoothing 
%   th - Signal DoA; need to know number of signals
%   d - Element spacing

% Sanity check of input
if size( R , 1 ) ~= size( R , 2 )
    error( 'Covariance matrix should be square' );
elseif size( R , 1 ) ~= size( V , 2 )
    error( 'Number of columns/rows in R should be equal to the number of columns in V');
end

% Generalised eigendecomposition of R (covariance matrix)
[U, S, V] = svd(R) ; % Using Singular Value Decomposition

% Left signular vectors corresponding to the signal subspace
F = U(:, 1:length(th)) ;

% Partion submatrices
E1 = F(1:N-1,:) ;
E2 = F(2:N, :) ;

% Compute P (Rotation Matrix) via LS (Least Squares) 
P = E1\E2 ;

% Use argument of eigenvalues of P to find DOA (Deg)
E = asind(-(angle(eig(P)) / (2*pi*d))) ;


end
