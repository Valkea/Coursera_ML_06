function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% @ is an anonymous function ->  @(argument-list) expression

loopOn = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
bestValues = [100,0,0]; % error,C,sigma

for i = 1:size(loopOn,2)
	C_tmp = loopOn(i);

	for j = 1:size(loopOn,2)
		sigma_tmp = loopOn(j);

		model= svmTrain(X, y, C_tmp, @(x1, x2) gaussianKernel(x1, x2, sigma_tmp)); 
		predictions = svmPredict(model, Xval);
		prediction_error = mean(double(predictions ~= yval));
		%fprintf('C: %0.5f Sigma: %0.5f Error: %0.5f', C_tmp, sigma_tmp, prediction_error);
		if( prediction_error < bestValues(1) )
			bestValues = [prediction_error, C_tmp, sigma_tmp];
		end
	end
end

C = bestValues(2);
sigma = bestValues(3);

% =========================================================================

end
