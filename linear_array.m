function [ X , Y ] = linear_array( d , N )
%linear_array Returns position vectors X and Y ( as column vectors) for a
% linear array along x=0 and y<=0.
%   d     - Element spacing (rational multiple of wavelength)
%   N     - Number of elements

Y = -( ( ( 0:( N-1 ) ) ).*d ).';
X = zeros( size( Y ) );

end