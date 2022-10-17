function varargout = bird(X)
% Bird function
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-2*pi, -2*pi]; % LB
varargout{3} = [+2*pi, +2*pi]; % UB
varargout{4} = [4.701055751981055e+000, +3.152946019601391e+000
-1.582142172055011e+000  -3.130246799635430e+000]; % solution
varargout{5} = -1.067645367198034e+002; % function value at solution
% otherwise, output function value
else
% keep values in the search interval
X(X < -2*pi) = inf;     X(X > 2*pi) = inf;
% split input vector X into x1, x2
if size(X, 1) == 2
x1 = X(1, :);        x2 = X(2, :);
else
x1 = X(:, 1);        x2 = X(:, 2);
end
% output function value
varargout{1} = sin(x1).*exp((1-cos(x2)).^2) + cos(x2).*exp((1-sin(x1)).^2) + (x1-x2).^2;
end
end