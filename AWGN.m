function noise = AWGN( a , Sn , Tn )
%AWGN Adds white Gaussian noise to the received signal
%   a  - Amplitude
%   Sn - Number of spatial elements (equal to number of sensors)
%   t  - Number of temporal elements (equal to number of temporal sampels)

noise = a.*( randn( Sn , Tn ) + 1i.* randn( Sn , Tn ) );

end