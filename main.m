%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
% Density-based Topology Optimization Using COMSOL & MATLAB
%                          Written by Kentaro Yaji (yaji@mech.eng.osaka-u.ac.jp)
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
clear; clf;
import com.comsol.model.*; import com.comsol.model.util.*;
addpath(genpath('../_lib'));
initItr = 1;
flgOpt = 'mma';
dirResult = 'result/'; mkdir(dirResult);
dirRx = strcat(dirResult, 'x/'); mkdir(dirRx);
dirRu = strcat(dirResult, 'u/'); mkdir(dirRu);
%===============================================================================
% Set COMSOL model.
%===============================================================================
model = ModelUtil.create('Model'); 
model.hist.disable();
model = SetModel.param(model);
model = SetModel.modelfile(model);
%===============================================================================
% Prepare optimization.
%===============================================================================
tmp.xmeshinfo = mphxmeshinfo(model, 'solname', 'sol1');
tmp.ind.x = find(tmp.xmeshinfo.dofs.nameinds ...
    == (find(strcmp(tmp.xmeshinfo.dofs.dofnames, 'comp1.xPhys')) - 1));
tmp.u = mphgetu(model, 'solname', 'sol1');
tmp.list = '%8d,%14.6e';
tmp.header = ' itr    | objective    |';
%===============================================================================
% Set parameters for optimization.
%===============================================================================
param.maxitr = str2double(model.param.get('maxitr'));
param.gmax(1, 1) = str2double(model.param.get('g1max'));
param.radius = str2double(model.param.get('radius'));
param.pb = str2double(model.param.get('pb'));
param.pe = str2double(model.param.get('pe'));
[param.H, param.Hs] = Heavisideproj.setfilter_3d(param, tmp);
%[param.H, param.Hs] = Heavisideproj.setfilter(param, tmp);
%===============================================================================
% Start optimization.
%===============================================================================
opt = Optimizer.init(param, tmp, flgOpt);
tmp.itr = initItr;
for iConst = 1:numel(param.gmax)
    tmp.list = strcat(tmp.list, ',%14.6e');
    tmp.header = strcat(tmp.header, sprintf(' constraint %d |', iConst));    
end
disp(tmp.header)
if initItr == 1
    tmp.idLog = fopen(strcat(dirResult, 'result.log'), 'w');
    fclose(tmp.idLog);
    tmp.idMat = fopen(strcat(dirRx, sprintf('%04d.mat', initItr)), 'w');
    fprintf(tmp.idMat, '%0.6e\n', opt.x); fclose(tmp.idMat);
else
    opt.x = load(strcat(dirRx, sprintf('%04d.mat', initItr)), '-ascii');
    tmp.u(tmp.ind.x) = opt.x;
    model.sol('sol1').setU(tmp.u); model.sol('sol1').createSolution();
end
while 1
    tmp.x = opt.x;
    [tmp.xFilt, tmp.xPhys] = Heavisideproj.apply(param, tmp);
    tmp.u(tmp.ind.x) = tmp.xPhys;
    model.sol('sol1').setU(tmp.u); model.sol('sol1').createSolution();
    %===========================================================================
    % Conduct sensitivity analysis for evaluation functions.
    %===========================================================================
    [model, tmp] = SetModel.sens(model, tmp);
    [tmp.dFdx, tmp.dGdx] = Heavisideproj.modsens(param, tmp);
    %===========================================================================
    % Output current result.
    %===========================================================================
    tmp.u = mphgetu(model, 'solname', 'sol1');
    tmp.disp = sprintf(strcat(tmp.list, '\n'), ...
        tmp.itr, tmp.f, tmp.g./abs(param.gmax));
    fprintf(tmp.disp);
    if tmp.itr > initItr || tmp.itr == 1
        tmp.idLog = fopen(strcat(dirResult, 'result.log'), 'a');
        fprintf(tmp.idLog, tmp.disp); fclose(tmp.idLog);
        save(strcat(dirRu, sprintf('%04d', tmp.itr)), '-struct', 'tmp', 'u')
    end
%    mphplot(model, 'pg3');
%    mphplot(model, 'pg1');
    drawnow;
    %===========================================================================
    % Check convergence (just check iteration number).
    %===========================================================================
    if (tmp.itr == param.maxitr)
        break
    end
    %===========================================================================
    % Update & save design variables.
    %===========================================================================
    opt = Optimizer.update(opt, param, tmp, flgOpt);
    opt.x = opt.xnew;
    tmp.itr = tmp.itr + 1;
    tmp.idMat = fopen(strcat(dirRx, sprintf('%04d.mat', tmp.itr)), 'w');
    fprintf(tmp.idMat, '%0.6e\n', opt.x); fclose(tmp.idMat);
end
