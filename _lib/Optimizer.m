classdef Optimizer
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
% class for optimizers
% How to use:
%   Type Optimizer.[function name] on MATLAB command window. 
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

methods (Static)

%/////////////////////////////// class function ////////////////////////////////
function opt = init(param, tmp, flgOpt)
%-------------------------------------------------------------------------------
% Intialize for optimizer. 
% Input:
%   param : structure of optimization parameters
%   tmp   : structure of tmporary parameters
%   flgOpt: flag for optimizers
% Output:
%   opt   : structure of optimization parameters
%-------------------------------------------------------------------------------

switch flgOpt
    case 'mma'
        disp('Optimizer is MMA.')
        opt = initializemma(param, tmp);
    otherwise
        error('Check flgOpt in Optimizer.init.')
end

end

%/////////////////////////////// class function ////////////////////////////////
function opt = update(opt, param, tmp, flgOpt)
%-------------------------------------------------------------------------------
% Update design variables. 
% Input:
%   opt   : structure of optimizer's parameters
%   param : structure of optimization parameters
%   tmp   : structure of tmporary parameters
%   flgOpt: flag for optimizers
% Output:
%   opt   : structure of optimizer's parameters
%-------------------------------------------------------------------------------

switch flgOpt
    case 'mma'
        opt = updatemma(opt, param, tmp);
    otherwise
        error('Check flgOpt in Optimizer.update.')
end

end

%///////////////////////////// end class function //////////////////////////////

end % methods(static)

end
