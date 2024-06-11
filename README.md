# Using Physics Knowledge for Learning Rigid-body Forward Dynamics with Gaussian Process Force Priors

Code related to the [paper "Using Physics Knowledge for Learning Rigid-body Forward Dynamics with Gaussian Process Force Priors"](https://openreview.net/pdf?id=50523z0PALg) accepted at the Conference on Robot Learning (CoRL) 2021.

![image](./doc/images/intro_image-v3.png)

The `Main S-GP` implementation can be found here: [sgp/sgp.py](sgp/sgp.py).

## How to execute the experiments

### Generate Dataset

Before starting to train the models, it is necessary to generate the dataset, obtained from simulation.

To do that, execute the script [01_simulate_KUKA_robot_arm.py](KUKA-experiment/01_simulate_KUKA_robot_arm.py), which requires, among other libraries, the pyBullet library installed.

This will execute the simulation and save the simulation results to ```KUKA-experiment/results/KUKA-surf-dataset/simdata_raw.dat```. The name and location of the file, as well as many other simulation settings, can be changed in the configuration file [config_KUKA.py](KUKA-experiment/results/KUKA-surf-dataset/config_KUKA.py).

![image](/doc/images/pyBulletMovie.gif)

![image](/doc/images/planned-OpSp-trajectory-projected-surf.png)

Next, execute the script [02_generate_dataset.py](KUKA-experiment/02_generate_dataset.py) which generates a dataset file ```KUKA-experiment/results/KUKA-surf-dataset/simdata.dat```. We are now ready to train the proposed learning methods.

### Mean Absolute Error vs. Number of training points

In this experiment, we compare the performance of a vanilla GP to the proposed Structured-GP w.r.t. to the number of training points used. Optionally, an analytical model is used as a mean function to the S-GP.
Execute the following main scripts to train the models

- [03_train_S-GP.py](KUKA-experiment/03_train_S-GP.py)
- [03_train_GP.py](KUKA-experiment/03_train_GP.py)

At the top of each script, you find the path to the model configuration file. Please, make sure you find the following path

```python
cfg_model = importlib.import_module('results.KUKA-surf-dataset.exp_MAEvsTrainpoints.config_ML')
```

which points to [exp_MAEvsTrainpoints/config_ML.py](KUKA-experiment/results/KUKA-surf-dataset/exp_MAEvsTrainpoints/config_ML.py).

Inside the config_ML file, there is an option ```s_gp.use_Fa_mean = False```, which lets you change whether the ```S-GP``` will use the analytical model or the zero mean as a mean function.

In addition, the option ```ds.datasetsize_train = 600``` lets you change the number of training points to be used by the different ```GP``` approaches during training.

![image](/doc/images/MAE-vs-nbr_training_samples-with-38.png)

![image](/doc/images/const_viol-vs-nbr_training_samples-with-38.png)

### Learning end-effector mass and CoG alongside unmodeled forces

Here, compare how the S-GP method performs when using an analytical multi-body dynamics model as a mean function, whose end-effector mass and CoG parameters are initially wrongly estimated. The S-GP approach aims at learning unmodeled friction forces alongside the analytical model parameters.

Execute the following main scripts to generate the results

- [03_train_S-GP_n_analytical-model.py](KUKA-experiment/03_train_S-GP_n_analytical-model.py)
- [03_train_analytical-model.py](KUKA-experiment/03_train_analytical-model.py)

and make sure the configuration file [exp_learn_massCoG_alongside/config_ML.py](KUKA-experiment/results/KUKA-surf-dataset/exp_learn_massCoG_alongside/config_ML.py) is set in the first lines of each code:

```python
cfg_model = importlib.import_module('results.KUKA-surf-dataset.exp_learn_massCoG_alongside.config_ML')
```

![image](/doc/images/kin-param-learning-progress-mean.png)

### Compare GP vs. S-GP vs Analytical Model vs. Neural Network

Execute the following main scripts to generate the results

- [03_train_S-GP.py](KUKA-experiment/03_train_S-GP.py)
- [03_train_GP.py](KUKA-experiment/03_train_GP.py)
- [03_train_NN.py](KUKA-experiment/03_train_NN.py)
- [03_run_analytical-model.py](KUKA-experiment/03_run_analytical-model.py)

and make sure each code points to the right configuration file [exp_comp_gp-sgp-nn-mbd/config_ML.py](KUKA-experiment/results/KUKA-surf-dataset/exp_comp_gp-sgp-nn-mbd/config_ML.py):

```python
cfg_model = importlib.import_module('results.KUKA-surf-dataset.exp_comp_gp-sgp-nn-mbd.config_ML')
```

![image](/doc/images/compare-approaches.png)

![image](/doc/images/compare-approaches-error.png)

## Installation

This project is written 100% in Python. The user is only required to install all Python libraries used in this project, given in [requirements.txt](requirements.txt)

Some useful links:

- [addict](https://github.com/mewwts/addict)

- [pybullet](https://github.com/bulletphysics/bullet3)

- [pytorch](https://pytorch.org/)

- [gpytorch](https://gpytorch.ai/)

- [pytorch_cluster](https://github.com/rusty1s/pytorch_cluster)

## External Softwares

### urdf_parser_py

- [http://wiki.ros.org/urdfdom_py](http://wiki.ros.org/urdfdom_py)

- [https://github.com/ros/urdf_parser_py](https://github.com/ros/urdf_parser_py)

License: BSD

Author(s): Thomas Moulard, David Lu, Kelsey Hawkins, Antonio El Khoury, Eric Cousineau, Ioan Sucan, Jackie Kay

### KUKA robot arm model

- [https://github.com/bulletphysics/bullet3/tree/master/data/kuka_iiwa](https://github.com/bulletphysics/bullet3/tree/master/data/kuka_iiwa)

- [https://github.com/bulletphysics/bullet3](https://github.com/bulletphysics/bullet3)

License: Zlib
