I1 = imread('image_left.png');
I2 = imread('image_right.png');

subplot(2, 2, 1);
imshow(I1);
title("Left");

subplot(2, 2, 2);
imshow(I2);
title("Right");

grayImage1 = rgb2gray(I1);
grayImage2 = rgb2gray(I2);

points1 = detectSURFFeatures(grayImage1);
points2 = detectSURFFeatures(grayImage2);
[features1, validPoints1] = extractFeatures(grayImage1, points1);
[features2, validPoints2] = extractFeatures(grayImage2, points2);

indexPairs = matchFeatures(features1, features2);
matchedPoints1 = validPoints1(indexPairs(:, 1));
matchedPoints2 = validPoints2(indexPairs(:, 2));

tform = estgeotform2d(matchedPoints2, matchedPoints1, 'projective');
outputViewI1 = imref2d(size(I1));
outputViewI2 = imref2d(size(I2));
I1Transformed = imwarp(I1, tform, 'OutputView', outputViewI2);
I2Transformed = imwarp(I2, tform, 'OutputView', outputViewI1);

stitchedImageRonL = max(I1, I2Transformed);
subplot(2, 2, 3);
imshow(stitchedImageRonL);
title("Right on Left");

stitchedImageLonR = max(I2, I1Transformed);
subplot(2, 2, 4);
imshow(stitchedImageLonR);
title("Left on Right");