
%Read Image
normal = (imread('D:\Internships,Projects and Trainings\CSSRI Reasearch Intern\SOMETHINGS\target.jpg'));
figure;
imshow(normal);
text(size(normal,2),size(normal,1)+15, ...
    'normal Image', ...
    'FontSize',7,'HorizontalAlignment','right');

distorted= (imread('D:\Internships,Projects and Trainings\CSSRI Reasearch Intern\SOMETHINGS\1 (3).jpg'));
figure;
imshow(distorted);
text(size(distorted,2),size(distorted,1)+15, ...
    'Distorted Image', ...
    'FontSize',7,'HorizontalAlignment','right');

%Resize and Rotate the Image
scale = 0.90;
J = rgb2gray(imresize(normal, scale)); % Try varying the scale factor.
scale = 0.90;
I = rgb2gray(imresize(distorted, scale)); % Try varying the scale factor.



%theta = 30;
%distorted = imrotate(J,theta); % Try varying the angle, theta.
%figure, imshow(distorted)
%Find Matching Features Between Images

%Detect features in both images.
ptsnormal  = detectSURFFeatures(J);
ptsDistorted = detectSURFFeatures(I);
%Visualize the strongest feature points found in the reference image.
figure;
imshow(normal);
title('500 Strongest Feature Points from normal Image');
hold on;
plot(selectStrongest(ptsnormal, 200));
%Visualize the strongest feature points found in the target image.
figure;
imshow(distorted);
title('500 Strongest Fe ature Points from Scene Image');
hold on;
plot(selectStrongest(ptsDistorted, 200));

%Extract feature descriptors.

[featuresnormal,   validPtsnormal]  = extractFeatures(J,  ptsnormal);
[featuresDistorted, validPtsDistorted]  = extractFeatures(I, ptsDistorted);
%Match features by using their descriptors.

indexPairs = matchFeatures(featuresnormal, featuresDistorted);
%Retrieve locations of corresponding points for each image.

matchednormal  = validPtsnormal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));
%Show point matches. Notice the presence of outliers.

figure;
showMatchedFeatures(normal,distorted,matchednormal,matchedDistorted);
title('Putatively matched points (including outliers)');
%Estimate Transformation
[tform, inlierDistorted, inliernormal] = estimateGeometricTransform(...
    matchedDistorted, matchednormal, 'affine');
%Display matching point pairs used in the computation of the transformation matrix.
figure;
showMatchedFeatures(normal,distorted, inliernormal, inlierDistorted);
title('Matching points (inliers only)');
legend('ptsnormal','ptsDistorted');
%Get the bounding polygon of the reference image.
boxPolygon = [1, 1;...                           % top-left
        size(normal, 2), 1;...                 % top-right
        size(normal, 2), size(normal, 1);... % bottom-right
        1, size(normal, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
%Transform the polygon into the coordinate system of the target image. The transformed polygon indicates the location of the object in the scene.

newBoxPolygon = transformPointsForward(tform, boxPolygon);
%Compute the inverse transformation matrix.
%Tinv  = tform.invert.T;

%ss = Tinv(2,1);
%sc = Tinv(1,1);
%scale_recovered = sqrt(ss*ss + sc*sc)
%theta_recovered = atan2(ss,sc)*180/pi


%Display the detected object.
figure;
imshow(distorted);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');
%Recover the normal Image
%outputView = imref2d(size(normal));
%recovered  = imwarp(distorted,tform,'OutputView',outputView);
%Compare recovered to normal by looking at them side-by-side in a montage.
%figure, imshowpair(normal,recovered,'montage')