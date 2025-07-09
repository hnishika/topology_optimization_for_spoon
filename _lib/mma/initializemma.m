function opt = initializemma(param, tmp)

opt.m = numel(param.gmax);
opt.n = numel(tmp.ind.x);
opt.xmin = zeros(opt.n, 1);
opt.xmax = ones(opt.n, 1);
opt.x = tmp.u(tmp.ind.x);
opt.xold1 = opt.x;
opt.xold2 = opt.x;
opt.low = opt.xmin;
opt.upp = opt.xmax;
opt.c = 10000*ones(opt.m, 1);
opt.d = zeros(opt.m, 1);
opt.a0 = 1;
opt.a = zeros(opt.m, 1);

return