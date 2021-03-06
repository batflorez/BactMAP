BacTMAP
================

## BacTMAP - Bacteria Tool for Microscopy Analysis & Plotting

<img src="man//figures//logo_bactmap_pink.png" width="200" height="200" />

This package is meant to make it easier for microbiologists to combine
and analyse segmentation & fluorescence data derived from custom
software like Oufti, Morphometrics, MicrobeJ or Supersegger. There are
standard functions for importing several popular programs, but also
options for importing CSVs or Matlab files with a specific structure. 

BactMAP uses ggplot and many ggplot-extensions to make visual summaries of the
segmentation & fluorescence data, show the cell genealogy, plot protein
trajectories in the cell and many other things. This can give you a
quick overview of your data to make a decision on further analysis and
custom visualization.

## Manual & Tutorials

In the [wiki](https://github.com/veeninglab/BactMAP/wiki) you will find a
manual and some examples on how to use BactMAP as a gateway between your
segmentation & fluorescence data.

If you have any comments, requests or find bugs, please report it on the [Issues page](https://github.com/veeninglab/bactmap/issues).**

## Download and install package

    #install devtools if not done yet
    install.packages("remotes")
    
    #install bactmap from the veeninglab github repository
    remotes::install_github("veeninglab/bactMAP")
    
    #or install it with all dependencies
    remotes::install_github("veeninglab/bactMAP", dependencies=TRUE)
    
    #load package
    library(bactMAP)

## Development version

Find the development version [here](https://github.com/vrrenske/bactMAP).
