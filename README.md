BacTMAP
================

## BacTMAP - Bacteria Tool for Microscopy Analysis & Plotting

![](figure/logo_bactmap_pink.PNG)

This package is meant to make it easier for microbiologists to combine
and analyse segmentation & fluorescence data derived from custom
software like Oufti, Morphometrics, MicrobeJ or Supersegger. There are
standard functions for importing several popular programs, but also
options for importing CSVs or Matlab files with a specific structure. If
your favorite segmentation or spot detection program is missing, don’t
hesitate to ask\!

I use ggplot and many ggplot-extensions to make visual summaries of the
segmentation & fluorescence data, show the cell genealogy, plot protein
trajectories in the cell and many other things. This can give you a
quick overview of your data to make a decision on further analysis and
custom visualization.

In the [wiki](https://github.com/vrrenske/BactMAP/wiki) you will find a
manual and some examples on how to use BactMAP as a gateway between your
segmentation & fluorescence data.

**BactMAP is still in development. Not all functions listed below are
fully tested & documented yet. If you have any comments, requests,
please let me know\!**

## Download and install package

    #install devtools if not done yet
    install.packages("devtools")
    
    #install bactmap from my github repository
    devtools::install_github("vrrenske/bactMAP")
    
    #or install it with all dependencies
    devtools::instal_github("vrrenske/bactMAP", dependencies=TRUE)
    
    #load package
    library(bactMAP)
