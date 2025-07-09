function outputobj(maxitr, dirResult)

if nargin < 2
    dirResult = 'result/';
end

clf

obj = load(strcat(dirResult, 'result.log'));
nConst = numel(obj(1, :))-2;

yyaxis left
lnObj = plot(obj(1:maxitr,1), obj(1:maxitr,2), 'r', 'DisplayName', 'Objective');
lnObj.LineWidth = 1;
lnObj.Marker = 'none';
lnObj.LineStyle = '-';

xlabel('Iteration')
ylabel('Objective')

hold on
yyaxis right
for ii = 1:nConst
    lnConst = plot(obj(1:maxitr,1), obj(1:maxitr,2+ii), ...
        'DisplayName', sprintf('Constraint %d', ii));
    lnConst.LineWidth = 1;
    lnConst.Marker = 'none';
    lnConst.LineStyle = '--';
end

ylabel('Constraint')
ax = gca;
ax.YAxis(1).Color = [0 0 0];
ax.YAxis(2).Color = [0 0 0];

if find(obj(:, 3:end) < 0)
    ylim([-2 0])
    if find(obj(:, 3:end) > 0)
        ylim([-2 2])
    end
else
    ylim([0 2])
end

rightcolors = [0 0 1];
for ii = 1:nConst-1 
    rightcolors = cat(1, rightcolors,  [0 ii/(nConst-1) 1]);
end
colororder(rightcolors)

legend('show')
hold off

return