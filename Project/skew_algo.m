cpselect('sckew.jpg','unsckew.jpg');
%Start Control Point Selection tool with images and control points stored in variables in the workspace.
I = checkerboard;
J = imrotate(I,30);
fixedPoints = [243,4.155000000000000e+02;337,126;561,163;647,416];
movingPoints = [285,198;671,275;625,452;288,520]; 
cpselect(J,I,movingPoints,fixedPoints);
%Register an aerial photo to an orthophoto. Specify the 'wait' parameter to block until control point selection is complete.
aerial = imread('sckew.jpg');
figure, imshow(aerial)
ortho = imread('unsckew.jpg');
figure, imshow(ortho)
load westconcordpoints % load some points that were already picked     
% Ask cpselect to wait for you to pick some more points
[aerial_points,ortho_points] = ...
       cpselect(aerial,'unsckew.jpg',...
                movingPoints,fixedPoints,...
                'Wait',true);
 
t_concord = fitgeotrans(aerial_points,ortho_points,'projective');
Rortho = imref2d(size(ortho));
aerial_registered = imwarp(aerial,t_concord,'OutputView',Rortho);
figure, imshowpair(aerial_registered,ortho,'blend')     