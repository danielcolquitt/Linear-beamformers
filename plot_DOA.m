function plot_DOA( Th , M , paxis )
%plot_DoA Produces DoA plots
%   M     - Metric (output from beamformer)
%   Th    - Scanning angles
%   paxis - Axis on which to plot

% Compute power in dB
P = 10.*log10( abs( M )./ max( abs( M ) ) );

% Plot power against scanning angle
axes( paxis )
plot( Th , P );

end