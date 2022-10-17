function xhat=CreateRandomSolution(model)
K=model.K;
H=model.H;
xhat=rand(K,H);
end