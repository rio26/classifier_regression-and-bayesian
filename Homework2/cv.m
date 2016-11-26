%%use 5-fold cross validation to compare among these 4 classifiers.
load cbt2data;

%disease_train = diseased(:,:)'; % training data for class diseased (size 25)
%healthy_train = healthy(:,:)'; % training data for class healthy (size 475)

diseased = diseased';
healthy = healthy';

%Since the training data of desease and healthy are sampled separately
%the priors maintain the same.
classPrior_D = 25/500;  %Class Prior for diseased
classPrior_H = 475/500; %Class Prior for healthy

errors_ML_naive = [];
errors_ML_notnaive = [];
errors_MAP_naive = [];
errors_MAP_notnaive = [];

for k = 1:5
    disease_train = diseased;
    healthy_train = healthy;
    
    startIndexH = 95*(k-1)+1;
    endIndexH = 95*k;
    startIndexD = 5*(k-1)+1;
    endIndexD = 5*k;
    
    disease_train(startIndexD:endIndexD,:) = [];
    healthy_train(startIndexH:endIndexH,:) = [];
    
    disease_test = diseased(startIndexD:endIndexD,:);
    healthy_test = healthy(startIndexH:endIndexH,:);
    
    errorSum_ML_naive = 0;
    errorSum_ML_notnaive = 0;
    errorSum_MAP_naive = 0;
    errorSum_MAP_notnaive = 0;
    
    %%train ML + nanive and test.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %train ML + naive
    class_meanD = (mean(disease_train))'; % class-wise & attribute-wise mean for diseased
    class_varD = cov(disease_train);      % class-wise & attribute-wise variance for diseased

    class_meanH = (mean(healthy_train))'; % class-wise & attribute-wise mean for healthy
    class_varH = cov(healthy_train);      % class-wise & attribute-wise variance for healthy
    
    %test ML + naive
    %go through deseased data
    sigma_D = diag(diag(class_varD));
    sigma_H = diag(diag(class_varH));
    for j = 1:5
        diff_D = (disease_test(j,:))'-class_meanD;
        ML_D = (1/sqrt((2*pi)^2 * det(sigma_D)))*exp(-0.5*diff_D'*inv(sigma_D)*diff_D)* classPrior_D;
        
        diff_H = (disease_test(j,:))'-class_meanH;
        ML_H = (1/sqrt((2*pi)^2 * det(sigma_H)))*exp(-0.5*diff_H'*inv(sigma_H)*diff_H)* classPrior_H;
        
        if ML_D < ML_H %the new data is incorrectly labelled as Healthy.
            errorSum_ML_naive = errorSum_ML_naive + 1;
        end
        
    end
    
    %go through the healthy data
    for j = 1:95
        diff_D = (healthy_test(j,:))'-class_meanD;
        ML_D = (1/sqrt((2*pi)^2 * det(sigma_D)))*exp(-0.5*diff_D'*inv(sigma_D)*diff_D)* classPrior_D;
        
        diff_H = (healthy_test(j,:))'-class_meanH;
        ML_H = (1/sqrt((2*pi)^2 * det(sigma_H)))*exp(-0.5*diff_H'*inv(sigma_H)*diff_H)* classPrior_H;
        
        if ML_D > ML_H %the new data is incorrectly labelled as dease.
            errorSum_ML_naive = errorSum_ML_naive + 1;
        end
        
    end
   
    errors_ML_naive = [errors_ML_naive;errorSum_ML_naive];
    
    
    
    
    
    
    
end
