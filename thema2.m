% Parameters
num_experiments = 500;
max_observations = 50;
H = 0.5; 
sigma2_theta = 1;
mu_theta = 4;
sigma2_w = 4;

%a and b for uniform to have same expected value same as prior
b=2*mu_theta;
a=0;

% True theta value (uncomment one distrivbution each time!)
% Normal distribution
true_theta = mu_theta + sqrt(sigma2_theta) * randn(num_experiments, 1);

% Uniform distribution
%true_theta = a + (b - a) * rand(num_experiments, 1);

% Exponential distribution
%true_theta = mu_theta * exprnd(1,num_experiments,1);

% Initialize arrays
MSE_MMSE = zeros(max_observations, 1);
MSE_MLE = zeros(max_observations, 1);

for n = 1:max_observations
    % Initialize arrays
    squared_error_mmse = zeros(num_experiments, 1);
    squared_error_mle = zeros(num_experiments, 1);
    
    for i = 1:num_experiments
        % Generate observations
        w = sqrt(sigma2_w) * randn(n, 1);
        x = H * true_theta(i) + w;
        x_bar = mean(x);  % Sample mean of observations
         % MMSE estimate
        theta_hat_mmse = mu_theta + (sigma2_theta * H * (x_bar - H * mu_theta)) / (H^2 * sigma2_theta + sigma2_w / n);
        %MLE estimate
        theta_hat_mle = (H' * (sigma2_w \ x_bar)) / (H' * (sigma2_w \ H));
        % Calculate squared error
        squared_error_mmse(i) = (theta_hat_mmse - true_theta(i))^2;
        squared_error_mle(i) = (theta_hat_mle - true_theta(i))^2;
    end
    % Compute MSE for this number of observations
    MSE_MMSE(n) = mean(squared_error_mmse);
    MSE_MLE(n)=mean( squared_error_mle);
end
% Plot MSE as a function of number of observations
figure;
plot(1:max_observations, MSE_MMSE, 'LineWidth', 2,'Color','r');
hold on;
plot(1:max_observations, MSE_MLE,'LineWidth', 2,'Color','b');
xlabel('Number of Observations');
ylabel('Mean Squared Error (MSE)');
title('MSE of MMSE and MLE Estimator vs. Number of Observations');
legend('MMSE','MLE');
grid on