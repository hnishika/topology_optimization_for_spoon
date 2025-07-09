function opt = updatemma(opt, param, tmp)

fval = tmp.g./abs(param.gmax) - sign(param.gmax);
df0dx = tmp.dFdx/max(abs(tmp.dFdx));
dfdx = tmp.dGdx'./abs(param.gmax);
[opt.xnew, ~, ~, ~, ~, ~, ~, ~, ~, opt.low, opt.upp] = ...
    mmasub(opt.m, opt.n, tmp.itr, opt.x, opt.xmin, opt.xmax, ...
    opt.xold1, opt.xold2, tmp.f, df0dx, fval, dfdx, ...
    opt.low, opt.upp, opt.a0, opt.a, opt.c, opt.d);
opt.xold2 = opt.xold1;
opt.xold1 = opt.x;

return