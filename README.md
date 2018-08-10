This repository contains the code and files that are associated with the [paper](https://arxiv.org/abs/1707.07247 ) titled "Chance, long tails, and inference in a non-Gaussian, Bayesian theory of vocal learning in songbirds".



**Folder "code":**

`generate_figures.m` generates all the panels shown in Fig. 2, Fig. 3, Fig. 4, and Fig. 5 of the [paper](https://arxiv.org/abs/1707.07247 ).

`dynamical_Bayesian.m` simulates one iteration of the dynamical Bayesian filter model shown in Fig. 1 of the [paper](https://arxiv.org/abs/1707.07247 ).

`songbird_single_timescale_stable.m` simulates the four constant-shift experiments, and the staircase-shift experiment.

`song_acquisition.m` simulates the song acquisition period during which the bird begins to sing and gradually refines its song until the beginning of the adulthood.

`shift_experiment.m` simulates the shift experiment given the shift size for each day. 

`generate_kernels_likelihoods.m` generates one kernel, and two likelihoods that are used in the Bayesian filter given a set of input parameters.

`get_shifted_likelihood.m` generates shifted likelihood corresponding to the shifted auditory channel.

`stable_distri_laguerre_bergstrom.m` simulates the 1d symmetric stable distribution.

`powerlaw_distribution.m` simulates the 1d symmetric power law distribution.

`histnorm.m` is some helper function adapted from [Arturo Serrano](https://www.mathworks.com/matlabcentral/fileexchange/22802-normalized-histogram?focused=3782097&tab=function).

`test_code.m` is for authors' own usage and can be ignored. But one can use it to test how those learning curves change when parameters change.



**Folder "data":**

In this folder, processed experimental data are stored.



**Folder "figures":**

The Fig. 2, Fig. 3, Fig. 4, and Fig. 5 in the [paper](https://arxiv.org/abs/1707.07247 ), which are generated from `generate_figures.m`, are stored in this folder.



**Folder "variables":**

In this folder, theoretical variables simulated from the model and optimization are stored.



**Folder "stable_distribution_compare":**

Different methods to simulate the stable distribution are compared in this folder.
