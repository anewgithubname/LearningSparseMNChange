# LearningSparseMNChange
The MATLAB code skeleton used in the paper "Support Consistency of Direct Sparse-Change Learning in Markov Networks".

There are only two steps to produce the "probability of success" plot used in the paper. 

1. demo_POS  
It runs the "KLIEP algorithm" and learns the changes between two (lattice) MNs with the difference of 4 edges.   
The script uses "parfor" to run 300 times using different random samples in parallel.   
2. plot_POS:  
With the results generated from the first step, it now plots the "probability of success" curves shown in the paper.   

Reference:
Liu, S., Suzuki, T., Relator R., Sese J., Sugiyama, M., Fukumizu, K.,  
Support Consistency of Direct Sparse-Change Learning in Markov Networks  
Presented at NIPS workshop on Transfer and Multi-task learning: Theory Meets Practice
Proceedings of Twenty-Ninth AAAI Conference on Artificial Intelligence (AAAI2015) 
, pp.2785-2791, 2015.  
To appear in Annals of Statistics, 2016 
