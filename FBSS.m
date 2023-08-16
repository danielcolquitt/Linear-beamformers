function Rs = FBSS( S , SAS )
%FBSS Computes the spatially smoothed covariance matrix using
%foward-backward averaging
%   S   - Signal (+noise) received at array elements
%   SAL - Sub-array size

% Compute number of receievers in array
AL = size( S , 1 );

% Compute number of samples
NOS = size( S , 2 );

% Compute number of subarrays
NSA = AL - SAS + 1;

% Sanity check
if NSA <= 0
    error( 'Size of the subarray must be at most the same as the array' );
end

% Initialised output matrix
Rs = zeros( SAS );

for n = 1:NSA

    % Initialise forward and backward covariance matrices
    RF = zeros( SAS );
    RB = zeros( SAS );

    % Average the covariance matrix the subarray in the forward direction
    for sn = 1:NOS
        RF = RF + S( n:n+SAS-1 , sn )*S( n:n+SAS-1 , sn )';
    end

    % Average the covariance matrix the subarray in the backward direction
    for sn = 1:NOS
        SB = conj( flip( S( (AL - n - SAS + 2):( AL - n + 1 ) , sn ) ) );
        RB = RB + SB*SB';
    end

    Rs = Rs + ( RF + RB )./NOS;

end

Rs = Rs./2./NSA;

end

