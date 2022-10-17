%% Weevil Damage Optimization Algorithm (WDOA) Portfolio Problem
% Paper:
% http://www.growingscience.com/jfs/Vol2/jfs_2022_17.pdf
%%----------------------------------------------------------
% Developer: Seyed Muhammad Hossein Mousavi   (Oct 2022)
% Contact: mosavi.a.i.buali@gmail.com 
%%----------------------------------------------------------

% Portfolio is a definition in finance which is based on receiving some values (prices) 
% as stock or any other financial assets and converting them into returns by aiming to 
% increase the return and decreasing the risk. Finally, those solutions which have highest
% return and lowest risk, would be considers as a vector called efficient frontier. 
% Normally, portfolio solves by traditional methods such as mean-variance, mean semi 
% variance, and mean absolute deviation but not always guaranteed the best solution.

clc;
clear;
close all;

%% Run App

data=load('mydata');
R=data.R;
nAsset=size(R,2);
MinRet=min(mean(R,1));
MaxRet=max(mean(R,1));

nSol=10;

DR=linspace(MinRet,MaxRet,nSol);
model.R=R;
model.method='cvar';
model.alpha=0.95;

W=zeros(nSol,nAsset);
WReturn=zeros(nSol,1);
WRisk=zeros(nSol,1);

for k=1:nSol
model.DesiredRet=DR(k);
disp(['Running for Solution #' num2str(k) ':']);
%-----------------------------------
out = RunWDOA(model);
%-----------------------------------
disp('__________________________');
disp('');
W(k,:)=out.BestSol.Out.w;
WReturn(k)=out.BestSol.Out.ret;
WRisk(k)=out.BestSol.Out.rsk;
end

EF=find(~IsDominated(WRisk,WReturn));

%% Results
figure;
plot(WRisk,WReturn,'y','LineWidth',2);
hold on;
plot(WRisk(EF),WReturn(EF),'r','LineWidth',4);
legend('','Efficient Frontier');
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
set(gca,'Color','w')
grid on;
xlabel('Risk');
ylabel('Return');

figure;
plot(out.BestCost,'k', 'LineWidth', 2);
xlabel('ITR');
ylabel('Cost Value');
ax = gca; 
ax.FontSize = 14; 
ax.FontWeight='bold';
set(gca,'Color','c')
grid on;

out.BestSol.Out

