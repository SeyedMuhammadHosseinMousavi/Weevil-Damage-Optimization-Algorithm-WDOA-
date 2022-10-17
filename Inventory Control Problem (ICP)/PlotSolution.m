function PlotSolution(sol,model)

    K=model.K;
    H=model.H;
    I0=model.I0;
    X0=zeros(K,1);
    u=model.u;
    Umax=model.Umax;
    UC0=sum(u.*I0);
    
    X=sol.X;
    I=sol.I;
    UC=sol.UC;

    subplot(3,1,1);
    stairs(0:H,[X X0]','LineWidth',3);
%     xlabel('Time');
    ylabel('Order Amount');
    ax = gca; 
ax.FontSize = 12; 
ax.FontWeight='bold';
% set(gca,'Color','c')
grid on;

    subplot(3,1,2);
    stairs(0:H,[I0 I]','LineWidth',3);
%     xlabel('Time');
    ylabel('Inventory');
ax = gca; 
ax.FontSize = 12; 
ax.FontWeight='bold';
% set(gca,'Color','c')
grid on;
    subplot(3,1,3);
    stairs(0:H,[UC0 UC],'g','LineWidth',3);
    hold on;
    plot([0 H],[Umax Umax],'r:','LineWidth',3);
    hold off;
    xlabel('Time');
    ylabel('Used Capacity');
    ax = gca; 
ax.FontSize = 12; 
ax.FontWeight='bold';
set(gca,'Color','k')
grid on;
end