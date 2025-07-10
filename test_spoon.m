function out = model
%
% test_spoon.m
%
% Model exported on Jul 10 2025, 10:21 by COMSOL 6.3.0.290.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('E:\hnishika\2025\Project\03_Topology_Optimization\02_work\250704');

model.label('test_spoon.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').geomRep('comsol');
model.component('comp1').geom('geom1').create('elp1', 'Ellipsoid');
model.component('comp1').geom('geom1').feature('elp1').set('semiaxes', [0.025 0.016 0.007]);
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').set('size', [0.05 0.032 0.007]);
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('pos', [0 0 0.0035]);
model.component('comp1').geom('geom1').create('dif1', 'Difference');
model.component('comp1').geom('geom1').feature('dif1').selection('input').set({'elp1'});
model.component('comp1').geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.component('comp1').geom('geom1').create('elp2', 'Ellipsoid');
model.component('comp1').geom('geom1').feature('elp2').set('semiaxes', [0.024 0.015 0.006]);
model.component('comp1').geom('geom1').create('dif2', 'Difference');
model.component('comp1').geom('geom1').feature('dif2').selection('input').set({'dif1'});
model.component('comp1').geom('geom1').feature('dif2').selection('input2').set({'elp2'});
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').set('size', [0.1 0.02 0.002]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('pos', {'0.075-0.002' '0' '-0.001'});
model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp1').set('quickplane', 'zx');
model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
model.component('comp1').geom('geom1').create('par1', 'Partition');
model.component('comp1').geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.component('comp1').geom('geom1').feature('par1').selection('input').set({'blk2'});
model.component('comp1').geom('geom1').create('wp2', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp2').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp2').set('quickx', '0.030');
model.component('comp1').geom('geom1').feature('wp2').set('unite', true);
model.component('comp1').geom('geom1').create('par2', 'Partition');
model.component('comp1').geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.component('comp1').geom('geom1').feature('par2').selection('input').set({'par1'});
model.component('comp1').geom('geom1').run;

model.component('comp1').view('view1').clip.create('plane1', 'ClipPlane');

model.component('comp1').physics.create('solid', 'SolidMechanics', 'geom1');
model.component('comp1').physics('solid').create('fix1', 'Fixed', 1);
model.component('comp1').physics('solid').feature('fix1').selection.set([67 70]);
model.component('comp1').physics('solid').create('fix2', 'Fixed', 2);
model.component('comp1').physics('solid').feature('fix2').selection.set([44 45]);
model.component('comp1').physics('solid').create('disp1', 'Displacement0', 0);
model.component('comp1').physics('solid').feature('disp1').selection.set([6]);
model.component('comp1').physics('solid').create('pl1', 'PointLoad', 0);
model.component('comp1').physics('solid').feature('pl1').selection.set([6]);

model.component('comp1').mesh('mesh1').create('map1', 'Map');
model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').feature('map1').selection.set([35 36 37 38 39 41 42 43 44 45]);
model.component('comp1').mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').feature('dis1').selection.set([53 55 58 60 66 67 69 70]);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis2').selection.set([54 56 59 61 63 64]);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis3').selection.set([17 45 48 52 57 62 65 68 71]);

model.component('comp1').view('view1').set('scenelight', false);
model.component('comp1').view('view1').set('clippingactive', false);
model.component('comp1').view('view1').clip('plane1').set('translationamount', 0.002180000000000004);
model.component('comp1').view('view1').clip('plane1').set('position', [0.029979396262206137 0 -0.0010000000474974496]);
model.component('comp1').view('view1').clip('plane1').set('orientationaxes', [-1 0 0; 0 -1 0; 0 0 1]);
model.component('comp1').view('view2').axis.set('xmin', -0.13023312389850616);
model.component('comp1').view('view2').axis.set('xmax', 0.1232331246137619);
model.component('comp1').view('view2').axis.set('ymin', -0.03240001201629639);
model.component('comp1').view('view2').axis.set('ymax', 0.13040001690387726);

model.component('comp1').physics('solid').feature('lemm1').set('E_mat', 'userdef');
model.component('comp1').physics('solid').feature('lemm1').set('E', '4E9');
model.component('comp1').physics('solid').feature('lemm1').set('nu_mat', 'userdef');
model.component('comp1').physics('solid').feature('lemm1').set('nu', 0.3);
model.component('comp1').physics('solid').feature('lemm1').set('rho_mat', 'userdef');
model.component('comp1').physics('solid').feature('lemm1').set('rho', 1000);
model.component('comp1').physics('solid').feature('fix1').active(false);
model.component('comp1').physics('solid').feature('disp1').set('Direction', {'free'; 'free'; 'prescribed'});
model.component('comp1').physics('solid').feature('disp1').set('U0', [0; 0; -0.002]);
model.component('comp1').physics('solid').feature('disp1').active(false);
model.component('comp1').physics('solid').feature('pl1').set('forcePoint', [0; 0; -0.1]);

model.component('comp1').mesh('mesh1').feature('size').set('hauto', 4);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis2').set('numelem', 30);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis3').set('numelem', 2);
model.component('comp1').mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', 'solid.misesGp');
model.result('pg1').feature('vol1').create('def', 'Deform');
model.result('pg2').create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('expr', 'w');

model.sol('sol1').createAutoSequence('std1');

model.study('std1').runNoGen;

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
model.result('pg1').feature('vol1').feature('def').set('scale', 4.074119778843596);
model.result('pg1').feature('vol1').feature('def').set('scaleactive', false);
model.result('pg2').feature('vol1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (x ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpnty' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (y ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']; 'solid.refpntz' '0' [native2unicode(hex2dec({'30' 'e2'}), 'unicode')  native2unicode(hex2dec({'30' 'fc'}), 'unicode')  native2unicode(hex2dec({'30' 'e1'}), 'unicode')  native2unicode(hex2dec({'30' 'f3'}), 'unicode')  native2unicode(hex2dec({'30' 'c8'}), 'unicode')  native2unicode(hex2dec({'8a' '08'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'30' '6e'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'71' '67'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' (z ' native2unicode(hex2dec({'5e' 'a7'}), 'unicode')  native2unicode(hex2dec({'6a' '19'}), 'unicode') ')']});
model.result('pg2').feature('vol1').set('colortabletype', 'discrete');
model.result('pg2').feature('vol1').set('bandcount', 12);
model.result('pg2').feature('vol1').set('smooth', 'none');
model.result('pg2').feature('vol1').set('resolution', 'normal');

out = model;
