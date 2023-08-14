function noise = AWGN( a , Sn , Tn )
%AWGN Adds white Gaussian noise to the signal
%propagating to/from infinity
%   a  - Amplitude
%   Sn - Number of spatial elements (equal to number of sensors)
%   t  - Number of temporal elements (equal to number of temporal sampels)

noise = a.*( randn( Sn , Tn ) + 1i.* randn( Sn , Tn ) );

end