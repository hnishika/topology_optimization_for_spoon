function outputmph(curitr, dirResult)

if nargin < 2
    dirResult = 'result/';
end

import com.comsol.model.*
import com.comsol.model.util.*
model = ModelUtil.create('Model');
model.hist.disable();
model = SetModel.param(model);
model = SetModel.modelfile(model);
load(strcat(dirResult, 'u/', sprintf('%04d', curitr)), 'u')
model.sol('sol1').setU(u);
model.sol('sol1').createSolution();
mphsave(model, strcat(dirResult, sprintf('result%04d', curitr)));

end