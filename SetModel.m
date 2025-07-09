classdef SetModel
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
% class for Model
% How to use:
%   Type SetModel.[function name] on MATLAB command window. 
%-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

methods (Static)

%/////////////////////////////// class function ////////////////////////////////
function model = param(model)
%-------------------------------------------------------------------------------
% Set parameters for model structure. 
% Input:
%   model : structure of model
% Output:
%   model : structure of model
%-------------------------------------------------------------------------------

model.param.set('maxitr', '50');
model.param.set('g1max', '2.0e-6');
model.param.set('nn', '1');
model.param.set('radius', '4.0');
model.param.set('pnl', '3');
model.param.set('pb', '4');
model.param.set('pe', '0.5');
model.param.set('init_dsn', '0.5');
model.param.set('E0', '1');
model.param.set('E1', '4e9');

end

%/////////////////////////////// class function ////////////////////////////////
function model = modelfile(model)
%-------------------------------------------------------------------------------
% Import specific model to the structure. 
% Input:
%   model: structure of model
% Output:
%   model: structure of model
%-------------------------------------------------------------------------------
model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.result.table.create('evl3', 'Table');

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').lengthUnit('mm');
model.component('comp1').geom('geom1').geomRep('comsol');
model.component('comp1').geom('geom1').create('elp1', 'Ellipsoid');
model.component('comp1').geom('geom1').feature('elp1').set('semiaxes', [25 16 7]);
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').set('size', [50 32 7]);
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('pos', [0 0 3.5]);
model.component('comp1').geom('geom1').create('dif1', 'Difference');
model.component('comp1').geom('geom1').feature('dif1').selection('input').set({'elp1'});
model.component('comp1').geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.component('comp1').geom('geom1').create('elp2', 'Ellipsoid');
model.component('comp1').geom('geom1').feature('elp2').set('semiaxes', [24 15 6]);
model.component('comp1').geom('geom1').create('dif2', 'Difference');
model.component('comp1').geom('geom1').feature('dif2').selection('input').set({'dif1'});
model.component('comp1').geom('geom1').feature('dif2').selection('input2').set({'elp2'});
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').set('size', [100 20 2]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('pos', {'75-2' '0' '-1'});
model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp1').set('quickplane', 'zx');
model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
model.component('comp1').geom('geom1').create('par1', 'Partition');
model.component('comp1').geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.component('comp1').geom('geom1').feature('par1').selection('input').set({'blk2'});
model.component('comp1').geom('geom1').create('wp2', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp2').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp2').set('quickx', 28);
model.component('comp1').geom('geom1').feature('wp2').set('unite', true);
model.component('comp1').geom('geom1').create('par2', 'Partition');
model.component('comp1').geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.component('comp1').geom('geom1').feature('par2').selection('input').set({'par1'});
model.component('comp1').geom('geom1').create('wp3', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp3').set('quickplane', 'zx');
model.component('comp1').geom('geom1').feature('wp3').set('quicky', -5);
model.component('comp1').geom('geom1').feature('wp3').set('unite', true);
model.component('comp1').geom('geom1').create('parf1', 'PartitionFaces');
model.component('comp1').geom('geom1').feature('parf1').set('partitionwith', 'workplane');
model.component('comp1').geom('geom1').feature('parf1').selection('face').set('par2(1)', 19);
model.component('comp1').geom('geom1').create('wp4', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp4').set('quickplane', 'zx');
model.component('comp1').geom('geom1').feature('wp4').set('quicky', 5);
model.component('comp1').geom('geom1').feature('wp4').set('unite', true);
model.component('comp1').geom('geom1').create('parf2', 'PartitionFaces');
model.component('comp1').geom('geom1').feature('parf2').set('partitionwith', 'workplane');
model.component('comp1').geom('geom1').feature('parf2').selection('face').set('parf1(1)', 21);
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').variable.create('var1');
model.component('comp1').variable('var1').set('obj1', '-w');
model.component('comp1').variable('var1').set('EE', 'E0+(E1-E0)*xPhys^pnl');

model.component('comp1').view('view1').clip.create('plane1', 'ClipPlane');

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1]);
model.component('comp1').material('mat1').propertyGroup.create('Enu', 'Enu', [native2unicode(hex2dec({'30' 'e4'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'b0'}), 'unicode')  native2unicode(hex2dec({'73' '87'}), 'unicode')  native2unicode(hex2dec({'30' '4a'}), 'unicode')  native2unicode(hex2dec({'30' '88'}), 'unicode')  native2unicode(hex2dec({'30' '73'}), 'unicode')  native2unicode(hex2dec({'30' 'dd'}), 'unicode')  native2unicode(hex2dec({'30' 'a2'}), 'unicode')  native2unicode(hex2dec({'30' 'bd'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'6b' 'd4'}), 'unicode') ]);
model.component('comp1').material('mat2').selection.set([2 3 4 5 6 7 8 9]);
model.component('comp1').material('mat2').propertyGroup.create('Enu', 'Enu', [native2unicode(hex2dec({'30' 'e4'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'b0'}), 'unicode')  native2unicode(hex2dec({'73' '87'}), 'unicode')  native2unicode(hex2dec({'30' '4a'}), 'unicode')  native2unicode(hex2dec({'30' '88'}), 'unicode')  native2unicode(hex2dec({'30' '73'}), 'unicode')  native2unicode(hex2dec({'30' 'dd'}), 'unicode')  native2unicode(hex2dec({'30' 'a2'}), 'unicode')  native2unicode(hex2dec({'30' 'bd'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'6b' 'd4'}), 'unicode') ]);

model.component('comp1').physics.create('sens', 'Sensitivity', 'geom1');
model.component('comp1').physics('sens').create('cvar1', 'ControlVariableField', 3);
model.component('comp1').physics('sens').feature('cvar1').set('fieldVariableName', 'xPhys');
model.component('comp1').physics('sens').feature('cvar1').selection.set([2 3 4 5 6 7 8 9]);
model.component('comp1').physics('sens').create('iobj1', 'IntegralObjective', 0);
model.component('comp1').physics('sens').feature('iobj1').selection.set([6]);
model.component('comp1').physics('sens').create('iobj2', 'IntegralObjective', 3);
model.component('comp1').physics('sens').feature('iobj2').selection.set([2 3 4 5 6 7 8 9]);
model.component('comp1').physics.create('solid', 'SolidMechanics', 'geom1');
model.component('comp1').physics('solid').create('fix1', 'Fixed', 1);
model.component('comp1').physics('solid').feature('fix1').selection.set([67 70 73 76]);
model.component('comp1').physics('solid').create('fix2', 'Fixed', 2);
model.component('comp1').physics('solid').feature('fix2').selection.set([45 46]);
model.component('comp1').physics('solid').create('disp1', 'Displacement0', 0);
model.component('comp1').physics('solid').create('pl1', 'PointLoad', 0);
model.component('comp1').physics('solid').feature('pl1').selection.set([6]);

model.component('comp1').mesh('mesh1').create('map1', 'Map');
model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').feature('map1').selection.set([35 36 37 38 39 41 42 43 44 45 46 47]);
model.component('comp1').mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').create('dis4', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').feature('dis1').selection.set([53 55 58 60]);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis2').selection.set([54 56 59 61 63 64]);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis3').selection.set([17 45 52 57 62 65 68 71 74 77]);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis4').selection.set([66 67 69 70 72 73 75 76]);

model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').comments([native2unicode(hex2dec({'30' 'a4'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'bf'}), 'unicode')  native2unicode(hex2dec({'30' 'e9'}), 'unicode')  native2unicode(hex2dec({'30' 'af'}), 'unicode')  native2unicode(hex2dec({'30' 'c6'}), 'unicode')  native2unicode(hex2dec({'30' 'a3'}), 'unicode')  native2unicode(hex2dec({'30' 'd6'}), 'unicode') '3D' native2unicode(hex2dec({'50' '24'}), 'unicode') ]);

model.component('comp1').view('view1').set('scenelight', false);
model.component('comp1').view('view1').set('clippingactive', false);
model.component('comp1').view('view1').clip('plane1').set('translationamount', 0.002180000000000004);
model.component('comp1').view('view1').clip('plane1').set('position', [0.029979396262206137 0 -0.0010000000474974496]);
model.component('comp1').view('view1').clip('plane1').set('orientationaxes', [-1 0 0; 0 -1 0; 0 0 1]);
model.component('comp1').view('view2').axis.set('xmin', -0.13023312389850616);
model.component('comp1').view('view2').axis.set('xmax', 0.1232331246137619);
model.component('comp1').view('view2').axis.set('ymin', -0.03240001201629639);
model.component('comp1').view('view2').axis.set('ymax', 0.13040001690387726);
model.component('comp1').view('view3').axis.set('xmin', -16.983537673950195);
model.component('comp1').view('view3').axis.set('xmax', 16.983537673950195);
model.component('comp1').view('view3').axis.set('ymin', -14.40843677520752);
model.component('comp1').view('view3').axis.set('ymax', 7.4084367752075195);
model.component('comp1').view('view4').axis.set('xmin', -130.23309326171875);
model.component('comp1').view('view4').axis.set('xmax', 123.23310089111328);
model.component('comp1').view('view4').axis.set('ymin', -32.40000534057617);
model.component('comp1').view('view4').axis.set('ymax', 130.39999389648438);

model.component('comp1').material('mat1').propertyGroup('Enu').set('E', '4e9');
model.component('comp1').material('mat1').propertyGroup('Enu').set('nu', '0.3');
model.component('comp1').material('mat2').propertyGroup('Enu').set('E', 'EE');
model.component('comp1').material('mat2').propertyGroup('Enu').set('nu', '0.3');

model.component('comp1').physics('sens').feature('cvar1').set('initialValue', 'init_dsn');
model.component('comp1').physics('sens').feature('cvar1').set('shapeFunctionType', 'shdisc');
model.component('comp1').physics('sens').feature('cvar1').set('order', 0);
model.component('comp1').physics('sens').feature('iobj1').set('objectiveExpression', 'obj1');
model.component('comp1').physics('sens').feature('iobj2').set('objectiveExpression', 'xPhys');
model.component('comp1').physics('solid').feature('lemm1').set('E', 'EE');
model.component('comp1').physics('solid').feature('lemm1').set('nu', 0.3);
model.component('comp1').physics('solid').feature('lemm1').set('rho_mat', 'userdef');
model.component('comp1').physics('solid').feature('lemm1').set('rho', 1000);
model.component('comp1').physics('solid').feature('fix1').active(false);
model.component('comp1').physics('solid').feature('disp1').set('Direction', {'free'; 'free'; 'prescribed'});
model.component('comp1').physics('solid').feature('disp1').set('U0', [0; 0; -0.002]);
model.component('comp1').physics('solid').feature('disp1').active(false);
model.component('comp1').physics('solid').feature('pl1').set('forcePoint', [0; 0; -0.1]);

model.component('comp1').mesh('mesh1').feature('size').set('hauto', 4);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis1').set('numelem', 10);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis2').set('numelem', 95);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis3').set('numelem', 2);
model.component('comp1').mesh('mesh1').run;

%******************************************************************************* 
model.study.create('std1');
model.study('std1').create('sens', 'Sensitivity');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'sens' 'off' 'solid' 'off'});

%******************************************************************************* 
model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('sn1', 'Sensitivity');
model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('sn1').set('sensfunc', 'all_obj_contrib');
model.sol('sol1').feature('s1').feature('sn1').set('control', 'sens');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study('std1').feature('sens').set('gradientStep', 'stat');
model.study('std1').feature('sens').set('objectiveActive', {'off' 'off'});
model.study('std1').feature('stat').set('useinitsol', true);
model.study('std1').feature('stat').set('usesol', true);

model.study('std1').feature('stat').set('initmethod', 'sol');
model.study('std1').feature('stat').set('initstudy', 'std1');
model.study('std1').feature('stat').set('notsolmethod', 'sol');
model.study('std1').feature('stat').set('notstudy', 'std1');

model.result.dataset.create('filt1', 'Filter');
model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', 'solid.misesGp');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', 'w');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('expr', 'xPhys');

model.study('std1').feature('sens').set('objectiveActive', {'off' 'off'});
model.study('std1').feature('stat').set('useinitsol', true);
model.study('std1').feature('stat').set('initmethod', 'sol');
model.study('std1').feature('stat').set('initstudy', 'std1');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('usesol', true);
model.study('std1').feature('stat').set('notsolmethod', 'sol');
model.study('std1').feature('stat').set('notstudy', 'std1');
model.study('std1').feature('stat').set('notsol', 'sol1');
model.study('std1').feature('stat').set('notsolnum', 'auto');

model.sol('sol1').createAutoSequence('std1');

model.study('std1').runNoGen;

model.result.dataset('filt1').set('expr', 'xPhys');
model.result.dataset('filt1').set('unit', '1');
model.result.dataset('filt1').set('descr', [native2unicode(hex2dec({'52' '36'}), 'unicode')  native2unicode(hex2dec({'5f' 'a1'}), 'unicode')  native2unicode(hex2dec({'59' '09'}), 'unicode')  native2unicode(hex2dec({'65' '70'}), 'unicode') ' xPhys']);
model.result.dataset('filt1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6b'}), 'unicode')  native2unicode(hex2dec({'95' 'a2'}), 'unicode')  native2unicode(hex2dec({'30' '59'}), 'unicode')  native2unicode(hex2dec({'30' '8b'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (x ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpnty' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6b'}), 'unicode')  native2unicode(hex2dec({'95' 'a2'}), 'unicode')  native2unicode(hex2dec({'30' '59'}), 'unicode')  native2unicode(hex2dec({'30' '8b'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (y ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpntz' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6b'}), 'unicode')  native2unicode(hex2dec({'95' 'a2'}), 'unicode')  native2unicode(hex2dec({'30' '59'}), 'unicode')  native2unicode(hex2dec({'30' '8b'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (z ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']});
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result('pg1').label([native2unicode(hex2dec({'5f' 'dc'}), 'unicode')  native2unicode(hex2dec({'52' '9b'}), 'unicode') ' (solid)']);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature('vol1').set('unit', 'MPa');
model.result('pg1').feature('vol1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (x ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpnty' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (y ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpntz' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (z ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']});
model.result('pg1').feature('vol1').set('colortabletype', 'discrete');
model.result('pg1').feature('vol1').set('bandcount', 12);
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').set('threshold', 'manual');
model.result('pg1').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg1').feature('vol1').set('resolution', 'custom');
model.result('pg1').feature('vol1').set('refine', 2);
model.result('pg1').feature('vol1').feature('def').set('scale', 0.5220256688405349);
model.result('pg1').feature('vol1').feature('def').set('scaleactive', false);
model.result('pg2').feature('vol1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (x ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpnty' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (y ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpntz' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (z ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']});
model.result('pg2').feature('vol1').set('colortabletype', 'discrete');
model.result('pg2').feature('vol1').set('bandcount', 12);
model.result('pg2').feature('vol1').set('smooth', 'none');
model.result('pg2').feature('vol1').set('resolution', 'normal');
model.result('pg3').feature('vol1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (x ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpnty' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (y ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpntz' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (z ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']});
model.result('pg3').feature('vol1').set('colortabletype', 'discrete');
model.result('pg3').feature('vol1').set('bandcount', 12);
model.result('pg3').feature('vol1').set('resolution', 'normal');

end

%/////////////////////////////// class function ////////////////////////////////
function [model, tmp] = sens(model, tmp)
%-------------------------------------------------------------------------------
% Conduct sensitivity analysis. 
% Input:
%   model: structure of model
%   tmp  : structure of tmporary parameters
% Output:
%   model: structure of model
%   tmp  : structure of tmporary parameters
%-------------------------------------------------------------------------------
model.study('std1').feature('stat').set('activate', {'solid' 'on'});
model.study('std1').feature('sens').setIndex('objectiveActive', 'on', 0);
model.study('std1').feature('sens').setIndex('objectiveActive', 'off', 1);
model.study('std1').feature('sens').setIndex( ...
    'controlVariableActive', 'on', 0);
model.sol('sol1').runAll();
tmp.f = mphevalglobalmatrix(model, 'sens.iobj1', 'dataset', 'dset1');
tmp.dFdxPhysRaw = mphgetu(model, 'solname', 'sol1', 'type', 'fsens');
tmp.dFdxPhys = tmp.dFdxPhysRaw(tmp.ind.x);
model.study('std1').feature('stat').set('activate', {'solid' 'off'});
model.study('std1').feature('sens').setIndex('objectiveActive', 'off', 0);
model.study('std1').feature('sens').setIndex('objectiveActive', 'on', 1);
model.sol('sol1').runAll();
tmp.g(1, 1) = mphevalglobalmatrix(model, 'sens.iobj2', 'dataset', 'dset1');
tmp.dGdxPhysRaw = mphgetu(model, 'solname', 'sol1', 'type', 'fsens');
tmp.dGdxPhys(:, 1) = tmp.dGdxPhysRaw(tmp.ind.x);

end
%///////////////////////////// end class function //////////////////////////////

end % methods(static)

end