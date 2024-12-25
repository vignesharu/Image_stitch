I1 = imread('image_left.png');
I2 = imread('image_right.png');

grayImage1 = rgb2gray(I1);
grayImage2 = rgb2gray(I2);

points1 = detectSURFFeatures(grayImage1);
points2 = detectSURFFeatures(grayImage2);
[features1, validPoints1] = extractFeatures(grayImage1, points1);
[features2, validPoints2] = extractFeatures(grayImage2, points2);

indexPairs = matchFeatures(features1, features2);
matchedPoints1 = validPoints1(indexPairs(:, 1), :);
matchedPoints2 = validPoints2(indexPairs(:, 2), :);

tform = estimateGeometricTransform(matchedPoints2, matchedPoints1, 'projective');
outputView = imref2d(size(I1));
I2Transformed = imwarp(I2, tform, 'OutputView', outputView);

stitchedImage = max(I1, I2Transformed);
imshow(stitchedImage);