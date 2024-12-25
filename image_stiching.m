fnames = {'image_left.png', 'image_right.png'};  % Input image filenames

% Read the input images into a cell array
imgs = cell(numel(fnames), 1);
for i = 1:numel(fnames)
    imgs{i} = imread(fnames{i});
end

% Perform image stitching using MATLAB's built-in functions
tform = estimateGeometricTransform(imgs{1}, imgs{2}, 'similarity');
pano = imwarp(imgs{1}, tform);
for i = 2:numel(fnames)
    tform = estimateGeometricTransform(pano, imgs{i}, 'similarity');
    pano = imwarp(pano, tform, 'OutputView', imref2d(size(pano)));
end

% Save the stitched image
imwrite(pano, 'pano.png');