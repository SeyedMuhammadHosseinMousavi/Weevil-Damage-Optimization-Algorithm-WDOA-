function f = Eggholder(z)
f = zeros(size(z,1),1);
for j = 1: size(z,1)
x = z(j,:);
if length(x)==1
x(2)=0;
end
y =0.0;
for i = 1:length(x) -1
x1 = x(i); x2 = x(i+1);
y1 = sin(sqrt(abs(x1-(x2+47))))*(-x1);
y2 = -(x2+47)*sin(sqrt(abs(x2+x1/2+47)));
y = y+y1+y2;
end
f(j) = y;
end
