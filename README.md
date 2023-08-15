# Linear-beamformers
 
A collection of MATLAB scripts and functions to simulate simple linear acoustic beamformers.

## beam_pattern_wave.m

The top-level script to run and specify the properties of the sources and beamformers.

## plane_wave.m

Simulates a plane wave propagating to/from infinity.

## DAS_beamformer.m

Applies conventional delay-and-sum (DAS) beamerformer --- computes the steering vector for a given bearing; assumes incident plane wave.

## MVDR_beamformer.m

Applies Capon/MVDR beamformer --- computes spatial spectrum for Capon beamformer.

## DoA.m

Estimates the DoA based on the maximum field value. Does not work well for multiple DoAs.

## To do

- Fix MVDR beamformer --- response is not what is expected