%% data format: feature1, feature2, ..., featureN, classlabel
raw = dlmread('wine.data');
raw = raw(randperm(size(raw, 1)), :);

TRAIN_SET_RATIO = 0.5;           %% ratio of test data
nTrain = size(raw, 1) * TRAIN_SET_RATIO;

rawTrain = raw(1: nTrain, :);
sTrain = getClassConstrains(rawTrain);        %% prepare training set

rawTest = raw(nTrain + 1: size(raw, 1), :);
sTest = getClassConstrains(rawTest);                %% prepare test set

nfeatures = size(sTrain(1).mustlink, 2); 
theta = rand(nfeatures, 1);         %% randomly intialize theta
%%%% fflush(stdout);
fprintf('================================\n');

MAX_ITERATIONS = 5000;
%% optimization setting for gradient descent
options = optimset('GradObj', 'on', 'MaxIter', 400);
for i = 1: MAX_ITERATIONS
  fprintf('iteration: %d\n', i);
  
  fprintf("******** stage1 ********\n");
  %% key part, call resample() to generate positve and negetive samples for
  %% logistic regression with respect to current theta
  [XTrain, yTrain, ~] = resample(sTrain, theta, nfeatures);
  %% get value of cost function
  [cost, ~] = costFunction(theta, XTrain, yTrain);
  fprintf('cost: %f\n', cost);
  %% classification precision of current theta,
  %% remember that sigmoid function is used for classification in logistic regression
  fprintf('precision: %f\n', sum(sigmoid(XTrain * theta) > 0.5 == yTrain) / numel(yTrain));
  %% call resample() to generate positive and negetive samples for test set
  [XTest, yTest, ~] = resample(sTest, theta, nfeatures);
  %% generalization on test set of current theta
  fprintf('generalization : %f\n', sum(sigmoid(XTest * theta) > 0.5 == yTest) / numel(yTest));
  fprintf('accuracy: %f\n', getAccuracy(sTest, theta));

  
  fprintf("******** stage2 ********\n");
  [theta, cost] = fminunc(@(t)(costFunction(t, XTrain, yTrain)), theta, options); %% optimize cost function 
  fprintf('cost: %f\n', cost); %% value of cost function after stage1
  fprintf('precision: %f\n', sum(sigmoid(XTrain * theta) > 0.5 == yTrain) / numel(yTrain));
  fprintf('generalization : %f\n', sum(sigmoid(XTest * theta) > 0.5 == yTest) / numel(yTest));
  fprintf('accuracy: %f\n', getAccuracy(sTest, theta));
  fprintf('================================\n\n');
  %% comment out this if you are using MATLAB
  fflush(stdout);
end
