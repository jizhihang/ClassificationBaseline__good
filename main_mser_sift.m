%%  


%% Initialization
clear ; close all; clc;

run('vlfeat-0.9.18/toolbox/vl_setup');
addpath(genpath('libsvm-3.18'));

addpath('testdata');

%% parameter setting
height = 300;
width = 300;

skip_resize_image = true;

skip_calculate_mser = true;

skip_calculate_image_mser_r = false;

skip_calculate_dsift = true;

%Resize images
if (~skip_resize_image)
    mkdir('testdata/train_resize');
    mkdir('testdata/test_resize');
    ResizeImage(height,width,'testdata/train','testdata/train_resize');
    ResizeImage(height,width,'testdata/test','testdata/test_resize');
end

%Extract feature

if (~skip_calculate_mser)
    CalculateMSER('testdata/train_resize','feature/train/MSER')
    CalculateMSER('testdata/test_resize','feature/test/MSER')    
end

if (~skip_calculate_image_mser_r)
    CalculateImageMSER_r('feature/train/MSER','testdata/train_resize','testdata/train_mser_r')
    CalculateImageMSER_r('feature/test/MSER','testdata/test_resize','testdata/test_mser_r')
end

if (~skip_calculate_dsift)
    CalculateDSIFT('testdata/train_mser_r','feature/train/MSER_DSIFT_R')
    CalculateDSIFT('testdata/test_mser_r','feature/test/MSER_DSIFT_R')
end

%Dimensionality reduction


% feature pooling parameters
% pyramid = [1, 2, 4];               % spatial block number on each level of the pyramid
% num_category = 7; 

%Calculate probobility
%DSIFT
% [train_data, train_label, train_label_name] = LoadData('feature/train/DSIFT');
% [test_data, test_label, test_label_name] = LoadData('feature/test/DSIFT');
%MSER
[train_data, train_label, train_label_name] = LoadData('feature/train/MSER_DSIFT_R');
[test_data, test_label, test_label_name] = LoadData('feature/test/MSER_DSIFT_R');


% if(CompareLabelName( train_label_name, test_label_name))
%     disp('Label is not the same');
% end

%DSIFT
% [dsift_model,prob_dsift] =  svm_classifier(train_data,train_label,test_data, test_label);
% save(['model\','model_dsift.mat'],'dsift_model','prob_dsift');
% disp('dsift has been done!');
%MSER
[mser_r_model,prob_mser_r] =  svm_classifier(train_data,train_label,test_data, test_label);
save(['model\','model_sift_mser_r.mat'],'-7.3','mser_r_model','prob_mser_r');
disp('sift mser r has been done!');

%Show accuracy
%DSIFT
% [~,pred_dsift] = max(prob_dsift,[],2);
% acc_dsift = sum(strcmp(train_label_name(pred_dsift) ,test_label_name(test_label)) ./ numel(test_label))  
%MSER
[~,pred_mser_r] = max(prob_mser_r,[],2);
acc_mser = sum(strcmp(train_label_name(pred_mser) ,test_label_name(test_label)) ./ numel(test_label))  

