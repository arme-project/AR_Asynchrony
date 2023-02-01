function videoArray = readImagesToStack(imageFolder, imageNameTemplate, startFrame, endFrame)

folder = 'C:\Users\genia\PycharmProjects\GreenScreenVideo\MatlabSegmentationViolin\Images\VideoExportRaw\';
imageName = 'OriginalVideoRawStill1.png';

regexPattern = regexprep(imageName,"[1-9]","[0-9]{1,10}");

regexPattern = "^" + regexPattern + "$";

match = regexp(imageName, regexPattern);

filesList = dir(folder);

listOfMatchingFiles = {}

for file = 1:length(filesList)
    fileName = filesList(file).name;

    match = regexp(fileName, regexPattern);

    if match == 1;
        listOfMatchingFiles{length(listOfMatchingFiles) + 1} = fileName;
    end
end

if endFrame < 1
    endFrame = length(listOfMatchingFiles);
end

if startFrame < 1
    startFrame = 1;
end

videoArray = [];

for frameNumber = startFrame:endFrame

    currentImageName = regexprep(imageName,"[1-9]{1,10}",string(frameNumber));

    imageData = imread(folder + string(currentImageName));

    videoArray = cat(4,videoArray,imageData);

end
    

end
