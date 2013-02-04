Metric Learning Algorithm for Single-linkage Clustering
================

Introduction
----------------
[single-linkage](http://en.wikipedia.org/wiki/Single-linkage_clustering)
clustering belongs to the family of
[Hierarchical clustering](http://en.wikipedia.org/wiki/Hierarchical_clustering).
In single-linkage clustering, assume that a distance
threshold is specified such that once the distance
between nearest clusters are greater than the threshold, the
cluster merging process terminated, the resulting clusters
will form a forest. The forest has the property that
distance between root clusters of trees are greater than the
specified threshold and distance between clusters in the
same tree are less or equal to the specified threshold.
This property enable us to design an algorithm than can
learn a distance function and threshold with respect to
original clusters.

Experimental Method
----------------




