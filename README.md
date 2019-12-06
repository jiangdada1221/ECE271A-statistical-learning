# ECE271A-statistical-learning
Use different methods and probability models to separate cheetah from its background

## Three models:
- __Naive Bayesian__
- __Gaussian classifier with BDR(Bayesian Decision Rule)__
- __Gaussian Mixture Model with BDR and EM algorithm__

__The picture used is shown below and goal is to seperate cheetah from its background.__
![Aaron Swartz](https://raw.githubusercontent.com/jiangdada1221/ECE271A-statistical-learning/master/cheetah.jpg)

## Model 1 - Naive Bayesian
![Aaron Swartz](https://raw.githubusercontent.com/jiangdada1221/ECE271A-statistical-learning/master/naiveBayesian/prediction.jpg)
__The error of this model is 0.171__

## Model 2 - Gaussian classifier
![Aaron Swartz](https://raw.githubusercontent.com/jiangdada1221/ECE271A-statistical-learning/master/GaussianModel/prediction.jpg)
- __The feature dimensions are 64, I pick the 8 best dimension by the extent of separation of the mean in background and foreground.__

__The error of this model is 0.0621__

## Model 3 - GMM 
![Aaron Swartz](https://raw.githubusercontent.com/jiangdada1221/ECE271A-statistical-learning/master/GMM_EM/prediction.jpg)
__In this model, I implement EM algorithm the estimate parameters. Then I try different number of components and dimensions. At last pick the best parameters to make prediction.__

__The error of this model is 0.0476__
