# Linear-beamformers
 
A collection of MATLAB scripts and functions to simulate simple linear acoustic beamformers.

[!IMPORTANT]
This is a complete rewrite of the original code, which was unnecessarily complicated and unstable in certain regimes (multiple sources).

These new scripts have been written from the ground up with simplicity and clarity in mind and have been validated against existing libraries.

## Script descriptions

We use the standard mathematical angle convention (i.e., $\theta=0$ corresponds to $x\geq0$).
Angles are in radians.
The array separation $d$ is assumed to be normalised by the (local) wavelength.

### Bartlett_DOA.m

Implements a simple Bartlett[^1]/DAS DoA estimator.
In this case, the estimator is simply the maximal power output
$$P = \mathbf{V}^\mathrm{H}(\theta)\underline{\underline{R}}\mathbf{V}(\theta),$$
where $\mathbf{V}(\theta)$ is the steering/scanning vector of the array and $\underline{\underline{R}}$ is the (sample) covariance matrix.

### Capon_DOA.m

Implements the Capon beamformer.
In this case, the estimator is the maximal SNR/metric
$$M = \frac{1}{\mathbf{V}^\mathrm{H}(\theta)\underline{\underline{R}}^+\mathbf{V}(\theta)},$$
where $(\cdot)^+$ indicates the Moore---Penrose Pseudoinverse.

### plot_DOA.m

Simply compute the SPL of the beamformer outputs and plots it as a function of scanning angle, $\theta$.

### linear_array.m

Computes the position vectors of the elements in a linear array.
The elements are distributed along the line $x=0$ and symmetrically about $y=0$.

### UARV.m

Computes the array response vector, given the position of the receivers.
Assumes that the array is uniform (i.e., that the receivers are distributed uniformly in space).

### DoA.m

A simple script to estimate DoA of a temporally random plane wave.
The script incorporates uncorrelated AWGN sensor noise.
Bartlett and Capon beamformers are compared.
Calls all of the above functions.

### DoA_validation.m

Identical to `DoA.m`, except with parameters chosen in order to validate performance against the existing [pyArgus](https://github.com/petotamas/pyArgus) library.

## Theory

Relevant Theory can be found in  Van Trees, H. *Optimum Array Processing*. New York: Wiley, 2002.

## To do
1. Stress-test code for multiple uncorrelated signals
2. Implement spatial smoothing for multiple correlated signals
3. Stress-test code for extreme parameter values


[^1]: I have change from using Delay-And-Sum to Bartlett when referring to this type of beamerformer because I am a massive fan of [The West Wing](https://en.wikipedia.org/wiki/Jed_Bartlet).