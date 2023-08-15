function A = UARV( X , Y , Th )
%UARV Uniform array response vector. Returns a M by N array where M is the
%number of angles and N is the number of receivers
%   [ X , Y ] - Position of receivers; assumed to be distributed uniformly
%   Th        - Steering/Scanning angle or AoA; can be a column vector
%               specifying multiple angles

% Check that Th has correct orientation
if size( Th , 2 ) ~= 1
    error( 'Th must be a column vector or scalar' );
end

% Compute spacing
D = sqrt( diff(X).^2 + diff(Y).^2 );

if diff(D) ~= 0
    error( 'Array elements are not uniformly distributed' );
end

A = exp( 1i.*2.*pi.*[cos( Th ) , sin( Th ) ]*[ X.' ; Y.' ] ); 

end