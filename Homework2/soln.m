clear all; close all;
%% Load the data
load cbt2data;

disease_train = diseased(:,:)'; % training data for class diseased (size 25)
healthy_train = healthy(:,:)'; % training data for class healthy (size 475)
newpts_test = newpts(:, :); % test data (without label)
N = size(newpts_test,2); %number of new data points 

classPrior_D = 25/500;  %Class Prior for diseased
classPrior_H = 475/500; %Class Prior for healthy
%%
class_meanD = (mean(disease_train))'; % class-wise & attribute-wise mean for diseased
class_varD = cov(disease_train);    % class-wise & attribute-wise variance for diseased

class_meanH = (mean(healthy_train))'; % class-wise & attribute-wise mean for healthy
class_varH = cov(healthy_train);      % class-wise & attribute-wise variance for healthy
%% 1.1 Maximum Likelihood(with Naive assumption)
sigma_D = diag(diag(class_varD));    %
 % the class conditional likelihood w.r.t. "disease" for the patient c.
for c = 1:N     
    diff_D = newpts_test(:,c)-class_meanD;
    L_D_naive(c) = (1/sqrt((2*pi)^2 * det(sigma_D)))*exp(-0.5*diff_D'*inv(sigma_D)*diff_D);
end

sigma_H = diag(diag(class_varH));
 % the class conditional likelihood w.r.t. "healthy" for the patient c.
for c = 1:N
    diff_H = newpts_test(:,c)-class_meanH;
    L_H_naive(c) = (1/sqrt((2*pi)^2 * det(sigma_H)))*exp(-0.5*diff_H'*inv(sigma_H)*diff_H);
end

% assign labels to the points
for c = 1:N
	if L_D_naive(c) >= L_H_naive(c)
		prediction_ML_naive(c) = 1; %label diseased
	else
		prediction_ML_naive(c) = 0; %label health
	end
end
%% 1.1 Plot the data and predictions for Maximum Likelihood(with Naive assumption)
color_train = {'ro','bo'};
color_test = {'rx','bx'};
figure(1);
hold on
for c = 1:N
    if prediction_ML_naive(c) == 1;
        plot(newpts_test(1,c), newpts_test(2,c), color_test{1});
    else
        plot(newpts_test(1,c), newpts_test(2,c), color_test{2});
    end
end

sum(prediction_ML_naive == 1)
sum(prediction_ML_naive == 0)

for d = 1:25
    plot(disease_train(d,1), disease_train(d,2), color_train{1});
end

for h = 1:475
    plot(healthy_train(h,1), healthy_train(h,2), color_train{2});
end
