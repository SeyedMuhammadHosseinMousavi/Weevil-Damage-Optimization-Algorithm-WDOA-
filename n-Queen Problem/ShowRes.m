function ShowRes(sol)
X=sol.X-0.5;
Y=sol.Y-0.5;
Hit=sol.Hit;
z=sol.z;
n=numel(X);
for i=1:n-1
for j=i+1:n
if Hit(i,j)==1
plot([X(i) X(j)],[Y(i) Y(j)],'k:','LineWidth',3);
hold on;
end
end
end

plot(X,Y,'k^','MarkerSize',14,'MarkerFaceColor','w');
strTitle=[num2str(n) '-Queens: '];
if z==0
title([strTitle 'No Hits']);
elseif z==1
title([strTitle 'Just one Hit']);
else
title([strTitle num2str(z) ' Hit(s)']);
end
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
set(gca,'Color','c')
grid on;
axis square;

set(gca,'XTick',0:n);
set(gca,'YTick',0:n);

xlim([0 n]);
xlim([0 n]);

hold off;

end