%% VARIABLES

tic; clc;  close all;  clear all

% Enter number of images per condition
% (i.e., how many chambers per condition)
repeats = 2;

% We use a control image (8 mM glucose) as reference for chambers detection
% Enter below the number of the image to use as reference
% The number to enter is the position of the image in the image files folder
refImg = 5;

%% ALL FOLDERS READING

mainFolder = pwd;                   % main folder
files = dir(mainFolder);            % all files and folders list
dir1 = [files.isdir];               % detect directories
sub1 = files(dir1);                 % extract only directories
subFolders = {sub1(3:end).name};    % remove . and ..

%% IMAGES NAME READING

currentDir = append(mainFolder,'\',subFolders{1});
actualFolder = subFolders{1}                % images saved in a single folder
P = dir(currentDir);
imageNames = setdiff({P.name},{'.','..'});  % Store names of all images
imageNum = length(imageNames);              % Number of total images

imageArray = cell(1,imageNum);              % Array to store all images
imageAligned = cell(1,imageNum);            % Array to store aligned images

%% READ ALL IMAGES AND COPY TO ARRAY

for i = 1:imageNum
    filename = imageNames{i};                   % get current image name
    outputCell{i,1} = filename;                 % store to output cell array with images names
    tempImage = imread(append(currentDir,'\',filename));    % read current image
    tempImg = imresize(tempImage,[1024 1360]);  % resize image to 1024x1360 px
    imageArray{i} = tempImg;                    % save current image in array
end

%% IMAGE ALIGNMENT

for ii = 1:imageNum
    tformEstimate(ii) = imregcorr(imageArray{ii},imageArray{refImg});    % correction values
    Rfixed(ii) = imref2d(size(imageArray{refImg}));                      % reference image
    imageAligned{ii} = imwarp(imageArray{ii},tformEstimate(ii),'OutputView',Rfixed(ii));    % aligned image
%     imshowpair(imageArray{4},imageAligned{ii},'falsecolor');        % show both images overlapped
end

%% IMAGE CROP AND CHAMBER FILTERING

I = imageAligned{refImg};                   % detect chamber with reference image
% imshow(I)
[Iy, Ix, Iz] = size(I);
I1 = I( (Iy/2-Iy/3):(Iy/2+Iy/3) , (Ix/2-Ix/3):(Ix/2+Ix/3) , :);
% imshow(I1)

I2 = im2gray(I1);
I2 = wiener2(I2, [5 5]);              % remove noise
bw = imbinarize(I2,graythresh(I2));     % create binary mask 
bw = logical(not(bw));
bw = imerode(bw,strel('diamond',5));
bw = bwareaopen(bw, 1000);              % remove particles less than 2000 pixels
bw = imfill(bw,'holes');                % fill the holes
bw = imdilate(bw,strel('diamond',5));
bw = imfill(bw,'holes');                % fill the holes
bw = imerode(bw,strel('rectangle',[5 40]));
bw = imdilate(bw,strel('rectangle',[5 40]));
% imshow(bw)

%% CHAMBERS RECOGNITION AND REMOVAL OF TOP CHAMBER

props = regionprops(bw,'all');          % properties of white areas
xyCentroids = vertcat(props.Centroid);  % save centroids position
yCentroids = xyCentroids(:,2);         % y component of centroids
CC = bwconncomp(bw);                    % detect number of regions in bw
[topCh,pos] = min(yCentroids);          % finding the top chamber in the array
bw(CC.PixelIdxList{pos}) = 0;           % delete top chamber
CC = bwconncomp(bw);                    % find white areas again (bottom ch)
props = regionprops(bw,'all');          % properties of bottom chamber
xyCentroids = vertcat(props.Centroid);  % centroid of bottom chamber
% imshow(bw)

%% REGION TO ANALYZE

width = 300;
height = 100;
xCenter = xyCentroids(:, 1);
yCenter = xyCentroids(:, 2);
xLeft = xCenter - width/2;
yBottom = yCenter - height/2;
    
%% ANALYSIS TO ALL IMAGES

for i = 1:imageNum

%% TRIM IMAGE TO RECTANGLE AREA

I = imageAligned{i};
[Iy, Ix, Iz] = size(I);
I1 = I( (Iy/2-Iy/3):(Iy/2+Iy/3) , (Ix/2-Ix/3):(Ix/2+Ix/3) , :);
I3 = imcrop(I1,[xLeft yBottom width height]);
% imshow(I3)

RC = I3(:,:,1);
GC = I3(:,:,2);
BC = I3(:,:,3);

%% ANALYZING MAGENTA VALUE

means = [mean2(RC(:,:)) mean2(GC(:,:)) mean2(BC(:,:))]/255;

Kvalue = 1 - max(means);
Mvalue = (1 - means(2) - Kvalue) / (1 - Kvalue) * 100;

%% SAVING MAGENTA VALUE FOR CURRENT IMAGE

expArray{i,1} = imageNames{i};
expArray{i,2} = Mvalue;
magentaVector(i) = Mvalue;

end

%% ORDERING DATA IN GROUPS

% Group values in columns with repeats of same sample
groupedValues = reshape(magentaVector, repeats, []);
groupedMean = mean(groupedValues);                      % Average of each group
groupedSD = std(groupedValues);                         % Std. dev. of each group

%% EXPORT DATA TO EXCEL FILE

originaldata = [groupedMean' groupedSD'];

nn = ['Image name'];
mm = ['Mean values'];
sd = ['StdDev'];
gg = ['Each row shows data for one experimental group, following the order' ...
    ' of the images in the folder.'];
ee = ['If repeats = 1, disregard data in Sheet2.'];

xlswrite('AnalysisData.xlsx', cellstr(nn), 'Sheet1', 'A1');
xlswrite('AnalysisData.xlsx', cellstr(mm), 'Sheet1', 'B1');
xlswrite('AnalysisData.xlsx', expArray, 'Sheet1', 'A2');

xlswrite('AnalysisData.xlsx', cellstr(gg), 'Sheet2', 'A1');
xlswrite('AnalysisData.xlsx', cellstr(ee), 'Sheet2', 'A2');
xlswrite('AnalysisData.xlsx', cellstr(mm), 'Sheet2', 'A4');
xlswrite('AnalysisData.xlsx', cellstr(sd), 'Sheet2', 'B4');
xlswrite('AnalysisData.xlsx', originaldata, 'Sheet2', 'A5');

toc