%% Load the Olympic data and extract the mens 400m data
%load olympics.mat

x = male400(:,1);
t = male400(:,2);
N = 27;

% Rescale x for numerical reasons
x = (x - x(1))/10;

%plot the data
figure(1);hold on

cv_loss = [];
train_loss = [];

%% Run a cross-validation over model orders
maxorder = 4;
X = [];
testX = [];
K = 10; %10-fold CV

sizes = [3 3 3 3 3 3 3 2 2 2];
sizes(end) = sizes(end) + N - sum(sizes);
csizes = [0 cumsum(sizes)];

for k = 0:maxorder
    X = [X x.^k];
    for fold = 1:K
        foldX = X(csizes(fold)+1:csizes(fold+1),:);
        trainX = X;
        trainX(csizes(fold)+1:csizes(fold+1),:) = [];
        foldt = t(csizes(fold)+1:csizes(fold+1));
        traint = t;
        traint(csizes(fold)+1:csizes(fold+1)) = [];
        
        w = inv(trainX'*trainX)*trainX'*traint;
        fold_pred = foldX*w;
        cv_loss(fold,k+1) = mean((fold_pred-foldt).^2);
        train_pred = trainX*w;
        train_loss(fold,k+1) = mean((train_pred - traint).^2);
    end
end

%% Plot the results
figure(1);
subplot(1,2,1)
plot(0:maxorder,mean(cv_loss,1),'linewidth',2)
xlabel('Model Order');
ylabel('Loss');
title('CV Loss');
subplot(1,2,2)
plot(0:maxorder,mean(train_loss,1),'linewidth',2)
xlabel('Model Order');
ylabel('Loss');
title('Train Loss');
