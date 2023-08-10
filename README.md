# Linear-beamformers
 
A collection of MATLAB scripts and functions to simulate simple linear acoustic beamformers.

## beam_pattern_*_wave.m

The top-level scripts to run and specify the properties of the sources and beamformers.

## plane_wave.m

Simulates a plane wave propagating to/from infinity.

## linear_beamformer.m

Does the beamforming (DAS) --- computes the steering vector for a given bearing; assumes incident plane wave.

## DoA.m

Computes the SPL of the beamformed field and estimates the DoA based on the means of the two bearings with the highest SPLs.

## To do

- Code up MV beamformer
- Add noise