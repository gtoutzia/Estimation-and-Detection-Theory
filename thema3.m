data=load('data.mat');

x=data.data;
x=x';
figure;
subplot(3,1,1);
histogram(x,20,'Normalization','pdf');
title('original data')
hold on;

%Exponential distribution check
mle_lambda_exp = length(x) / sum(x);
x_exp = exprnd(1/mle_lambda_exp,length(x),1);
subplot(3,1,2);
histogram(x_exp,20,'Normalization','pdf');
title('data of Exponential')

%Rayleigh distribution check
mle_lambda_ray = sqrt(sum(x.^2)/(2*length(x)));
x_ray = raylrnd(mle_lambda_ray,length(x),1); 
subplot(3,1,3);
histogram(x_ray, 20,'Normalization','pdf');
title('data of Rayleigh');
