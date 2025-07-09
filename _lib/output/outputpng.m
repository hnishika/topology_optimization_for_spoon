function outputpng(maxitr, pg, dirResult)

if nargin < 2
    dirResult = 'result/';
    pg = 'pg1';
elseif nargin < 3
    dirResult = 'result/';
end

dirPng = strcat(dirResult, 'png_', pg, '/'); mkdir(dirPng);
import com.comsol.model.*
import com.comsol.model.util.*
model = ModelUtil.create('Model');
model.hist.disable();
model = SetModel.param(model);
model = SetModel.modelfile(model);
model.result.export.create('img1', 'Image');
model.result.export('img1').set('sourceobject', pg);
model.result.export('img1').set('size', 'presentation');
model.result.export('img1').set('unit', 'mm');
model.result.export('img1').set('height', '200');
model.result.export('img1').set('width', '200');
model.result.export('img1').set('lockratio', 'off');
model.result.export('img1').set('resolution', '192');
model.result.export('img1').set('antialias', 'on');
model.result.export('img1').set('zoomextents', 'off');
model.result.export('img1').set('fontsize', '12');
model.result.export('img1').set('colortheme', 'globaltheme');
model.result.export('img1').set('customcolor', [1 1 1]);
model.result.export('img1').set('background', 'color');
model.result.export('img1').set('gltfincludelines', 'on');
model.result.export('img1').set('title1d', 'on');
model.result.export('img1').set('legend1d', 'on');
model.result.export('img1').set('logo1d', 'on');
model.result.export('img1').set('options1d', 'on');
model.result.export('img1').set('title2d', 'on');
model.result.export('img1').set('legend2d', 'on');
model.result.export('img1').set('logo2d', 'on');
model.result.export('img1').set('options2d', 'off');
model.result.export('img1').set('title3d', 'on');
model.result.export('img1').set('legend3d', 'on');
model.result.export('img1').set('logo3d', 'on');
model.result.export('img1').set('options3d', 'off');
model.result.export('img1').set('axisorientation', 'on');
model.result.export('img1').set('grid', 'on');
model.result.export('img1').set('axes1d', 'on');
model.result.export('img1').set('axes2d', 'on');
model.result.export('img1').set('showgrid', 'on');
model.result.export('img1').set('target', 'file');
model.result.export('img1').set('qualitylevel', '92');
model.result.export('img1').set('qualityactive', 'off');
model.result.export('img1').set('imagetype', 'png');
model.result.export('img1').set('lockview', 'off');

for ii = 1:maxitr
    fprintf('outputpng: %d/%d\n', ii, maxitr);
    load(strcat(dirResult, 'u/', sprintf('%04d', ii)), 'u')
    model.sol('sol1').setU(u);
    clear u
    model.sol('sol1').createSolution();
    model.result.export('img1').set('pngfilename', strcat(dirPng, sprintf('%04d.png', ii)));
    model.result.export('img1').run;
end

