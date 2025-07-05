% Parameters
true_lambda = 2;  % True lambda
n_values = [10, 20, 50, 100];  % Sample sizes
m = 5000;  % Number of repetitions
% For all sample sizes
for j = 1:length(n_values)
    n = n_values(j);
    % Initialize arrays
    mle_lambdas = zeros(m, 1);
    mvue_lambdas = zeros(m, 1);
    % For each sample, calculate MLE and MVUE
    for i = 1:m
        % Sample from exponential distribution
        sample = exprnd(1/true_lambda, n, 1);
        % Mle calculation
        mle_lambda = n / sum(sample);
        mle_lambdas(i) = mle_lambda;
        % CRLB calculation
        variance_crlb = (true_lambda^2) / n;
        % MVUE calculation (using normal distribution)
        mvue_lambda = normrnd(true_lambda, sqrt(variance_crlb));
        mvue_lambdas(i) = mvue_lambda;
    end
    %Calculation and print of expected value and variance for MLE and MVUE for each
    %sample size
    mean_mle = mean(mle_lambdas);
    mean_mvue=mean(mvue_lambdas);
    var_mle=var(mle_lambdas);
    var_mvue=var(mvue_lambdas); 
    fprintf('sample size:%d\n mean mle = %f\n mean mvue=%f\n var mle=%f\n var mvue=%f\n',n_values(j),mean_mle,mean_mvue,var_mle,var_mvue);
    % Histogram of the MLEs
    figure;
    subplot(2, 1, 1);  % Create a subplot for the MLE histogram
    histogram(mle_lambdas, 50);  % 50 bins for the histogram
    title(sprintf('Histogram of the MLE for \\lambda for n=%d', n));
    xlabel('MLE of \lambda');
    ylabel('Frequency');
    grid on;
    % Histogram of the MVUEs
    subplot(2, 1, 2);  % Create a subplot for the MVUE histogram
    histogram(mvue_lambdas, 50);  % 50 bins for the histogram
    title(sprintf('Histogram of the MVUE for \\lambda for n=%d', n));
    xlabel('MVUE of \lambda');
    ylabel('Frequency');
    grid on;
end
