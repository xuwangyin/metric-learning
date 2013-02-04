Metric Learning Algorithm for Single-linkage Clustering
================

Introduction
----------------
[Single-linkage](http://en.wikipedia.org/wiki/Single-linkage_clustering)
clustering belongs to the family of
[Hierarchical clustering](http://en.wikipedia.org/wiki/Hierarchical_clustering).
In single-linkage clustering, assume that a distance
threshold is specified such that once the distance
between nearest clusters are greater than the threshold, the
cluster merging process will terminate and the resulting clusters
will form a forest. The forest has the property that
distance between root clusters of trees are greater than the
specified threshold and distance between clusters in the
same tree are less or equal to the specified threshold.
This property enable us to design an algorithm than can
learn a distance function and threshold with respect to
original clusters.

Experimental Method
----------------
Datasets for classification
([iris dataset](http://archive.ics.uci.edu/ml/datasets/Iris)
for example) can be used to test the effectiveness of the
proposed algorithm.
In such a dataset, a class corresponds to a
cluster.
The dataset used in experiments are splitted into training set
and test set.
The training set is used to learn a distance function and
threshold using the metric learning algorithm; the test set
is used to test the effectiveness of the learned parameters.
The metric learning algorithm is a iterative process, it
helps to profile the accuracy of the parameters in each
iteration.
The accuracy of learned parameters is defined as the portion
of data pairs (include must-link and cannot-link data pairs)
that are correctly clustered using the learned parameters.

Run metricLearning.m in matlab or octave to see the experimental 
results (the default dataset is [wine](http://archive.ics.uci.edu/ml/datasets/wine)).





