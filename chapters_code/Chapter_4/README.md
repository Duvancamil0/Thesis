# Data Generation for Project Risk Management

This repository contains code and associated data for our research on the application of Deep Generative Models to improve Bayesian Network learning in the context of project risk management.

## Structure
This repository is organized into several folders, each named after the Benchmark Bayesian Networks (BNs) used in this study: `alarm`, `asia`, `insurance`, `sports`, and `prm` (an acronym for Project Risk Management). There is also a folder named `mineros` containing data from a real-world case provided by a mining company.

In each Benchmark BN folder, you will find the following data and code:

- A True Dataset file in CSV format, named after the respective BN (e.g., `alarm.csv`).

- An R Notebook used to sample the small datasets.

- A folder containing the sampled datasets.

- Folders for each of the Deep Generative Models (DGMs) used - `TVAE`, `CTGAN`, and `Mostly AI`. Each DGM sub-folder contains R Notebooks for every possible size of the small dataset (100, 500, or 1000 observations).

- A folder named `Synthetic` with the following files:
  - Synthesized data files.
  - Python scripts (`CTGAN.py`, `TVAE.py`) for creating synthetic data using CTGAN and TVAE.
  - A JSON file with the metadata of the datasets to perform data synthetization.
  - A folder names `Augmented`, which houses all the augmented datasets and Python scripts for calculating the similarities.

## Code
All the code in this repository is written in Python and R, with a focus on clarity and simplicity.

## Data
All the original and synthesized datasets used in the study are provided, as per the structure explained above. 

## Usage
Use the R Notebooks in each benchmark BN folder to recreate the small datasets sampling. The Python files in the Synthetic and Augmented folders can be used to recreate the synthetic and augmented data, as well as compute their similarities. Ensure your execution path aligns with the referenced file structures.
```
