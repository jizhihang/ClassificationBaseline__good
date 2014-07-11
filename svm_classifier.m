function [model,prob] = svm_classifier(trainData,trainLabel,testData,testLabel)
%%  Use one against all strategies to make classification using libsvm
%   this file assume that all the four dataset
%	trainData, trainLabel, testData, testLabel
%   have been successfully collected

numInst = size(trainData,1) + size(testData, 1);
numLabels = max(max(trainLabel), max(testLabel));
numTest = size(testData,1);

%   train one-against-all models
% model = 
% svmtrain(train_label, train_matrix, ['libsvm_options']);
%  
% -train_label:
%             An m by 1 vector of training labels (type must be double).
% -train_matrix:
%             An m by n matrix of m training instances with n features.
%             It can be dense or sparse (type must be double).
% -libsvm_options:
%             A string of training options in the same format as that of LIBSVM.
% model = cell(numLabels,1);
for k=1:numLabels
    disp(num2str(k));
    model{k} = svmtrain(double(trainLabel==k), trainData, '-q -h 0 -c 1 -g 0.2 -b 1');
end

%	get probability estimates of test instances using each model
% [predicted_label, accuracy, decision_values/prob_estimates] = svmpredict(test_label, test_matrix, model, ['libsvm_options']);
%  
% -test_label:
%             An m by 1 vector of prediction labels. If labels of test
%             data are unknown, simply use any random values. (type must be double)
% -testmatrix:
%             An m by n matrix of m testing instances with n features.
%             It can be dense or sparse. (type must be double)
% -model:
%             The output of svmtrain.
% -libsvm_options:
%             A string of testing options in the same format as that of LIBSVM.
prob = zeros(numTest,numLabels);
for k=1:numLabels
    disp(num2str(k));
    [~,~,p] = svmpredict(double(testLabel==k), testData, model{k}, '-b 1');
    prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
end

