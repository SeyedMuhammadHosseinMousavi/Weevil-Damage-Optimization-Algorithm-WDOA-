function varargout = booth(X)
% Booth function
% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else

% keep values in the search interval
X(X < -10) = inf;     X(X > 10) = inf;

% split input vector X into x1, x2
if size(X, 1) == 2
x1 = X(1, :);        x2 = X(2, :);
else
x1 = X(:, 1);        x2 = X(:, 2);
end

% output function value
varargout{1} = (x1 + 2*x2 - 7).^2 + (2*x1 + x2 - 5).^2;

end

end