classdef Heavisideproj
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
% class for Heaviside projection
% How to use:
%   Type Heavisideproj.[function name] on MATLAB command window. 
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

methods (Static)

%/////////////////////////////// class function ////////////////////////////////
function [H, Hs] = setfilter(param, tmp)
%-------------------------------------------------------------------------------
% Set filter function. 
% Input:
%   param : structure of parameters
%   tmp   : structure of tmporary parameters
% Output:
%   H     : filter matrix
%   Hs    : filter vector
%-------------------------------------------------------------------------------

gx = tmp.xmeshinfo.dofs.coords(1, tmp.ind.x);
gy = tmp.xmeshinfo.dofs.coords(2, tmp.ind.x);
radius = param.radius; 
iH = cell(length(tmp.ind.x), 1); jH = iH; kH = iH;
for ii = 1:length(tmp.ind.x)
    dist = sqrt((gx-gx(ii)).^2+(gy-gy(ii)).^2)';
    jH{ii} = find(dist <= radius);
    kH{ii} = max(0, radius-dist(jH{ii}));
    iH{ii} = ii*ones(length(kH{ii}), 1);
end
iH = cell2mat(iH); jH = cell2mat(jH); kH = cell2mat(kH);
H = sparse(iH, jH, kH);
Hs = sum(H, 2);

end

%/////////////////////////////// class function ////////////////////////////////
function [xFilt, xPhys] = apply(param, tmp)
%-------------------------------------------------------------------------------
% Apply filter and Heaviside projection. 
% Input:
%   param : structure of parameters
%   tmp   : structure of tmporary parameters
% Output:
%   xFilt : filtered design variables
%   xPhys : projected design variables
%-------------------------------------------------------------------------------

xFilt = (param.H*tmp.x(:))./param.Hs;
xPhys = (tanh(param.pb*param.pe)+tanh(param.pb*(xFilt-param.pe)))/...
    (tanh(param.pb*param.pe)+tanh(param.pb*(1-param.pe)));

end

%/////////////////////////////// class function ////////////////////////////////
function [dFdx, dGdx] = modsens(param, tmp)
%-------------------------------------------------------------------------------
% Modify sensitivities. 
% Input:
%   param  : structure of parameters
%   tmp    : structure of tmporary parameters
% Output:
%   dFdx : modified sensitivity of objective function
%   dGdx : modified sensitivity of constraint function
%-------------------------------------------------------------------------------

dgamma = (param.pb*sech(param.pb*(tmp.xFilt-param.pe)).^2)/ ...
    (tanh(param.pb*param.pe)+tanh(param.pb*(1-param.pe)));
dFdx = param.H*((tmp.dFdxPhys.*dgamma)./param.Hs);
dGdx = param.H*((tmp.dGdxPhys.*dgamma)./param.Hs);

end

%///////////////////////////// end class function //////////////////////////////

end % methods(static)

end