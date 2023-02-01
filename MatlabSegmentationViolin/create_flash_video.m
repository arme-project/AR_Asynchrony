% Create a logical image of a circle with specified
% diameter, center, and image size.
% First create the image.
imageOrigX = 590;
imageOrigY = 1150;
imageSizeX = imageOrigX*4;
imageSizeY = imageOrigY*4;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = imageSizeX/2;
centerY = imageSizeY/2;
radius = 400;
circleMask = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;
% circlePixels is a 2D "logical" array.
% Now, display it.
% image(circleMask) ;
% colormap([0 0 0; 1 1 1]);
% title('Binary image of a circle');
% axis equal
%

blackImage = uint8(zeros(imageSizeY, imageSizeX, 3));
redImage = blackImage;
redImage(:,:,1) = 255;
redImage = imresize(redImage,0.25,'nearest');
circleMask = imresize(circleMask, 0.25, 'lanczos3');
alphaImage = cat(3, redImage, circleMask*255);
% imwrite(alphaImage(:,:,1:3),"alphaTest.png",'Alpha',uint8(alphaImage(:,:,4)),'Background',[0 0 0]);

%%
nFrames = 104;
onset = 31;
videoOutput = uint8(zeros(1150, 590,3,nFrames));
videoOutput(:,:,:,onset) = redImage;
alphaOutput = uint8(zeros(1150, 590,1,nFrames));
alphaOutput(:,:,:,onset) = circleMask*255;

%% Output video of alpha array 
tic;
videoWriter = VideoWriter("flashAlphaVideo.mp4", 'MPEG-4')
videoWriter.FrameRate = 30;
videoWriter.Quality = 100;
open(videoWriter);
for nFrame = 1:104
    alphaImage = uint8(alphaOutput(:, :, nFrame)*255);
    alphaImage = repmat(alphaImage,[1 1 3]);
    writeVideo(videoWriter, alphaImage);

end
close(videoWriter);
toc;
%%
% Output video directly from array
tic;
videoWriter = VideoWriter("flashVideoOutput.mp4", 'MPEG-4')
videoWriter.FrameRate = 30;
videoWriter.Quality = 100;
open(videoWriter);
for nFrame = 1:104
    
    writeVideo(videoWriter, videoOutput(:, :, :, nFrame));

end
close(videoWriter);
toc;
%% Merge mp4 and wav into single mp4 video
ffmpeg_mp4 = "ffmpeg -i flashVideoOutput.mp4 -i audio_beep_48k.wav MergedBeepVideo.mp4";
system(ffmpeg_mp4)
%% Merge mp4 and wavs into WEBM, with strict flag
% Merge colour and alpha channels produced in Matlab, into a webm file
l1 = "ffmpeg -i flashVideoOutput.mp4 -i flashAlphaVideo.mp4 -i audio_beep_48k.wav ";
l2 = "-filter_complex [0][1]alphamerge,format=yuva420p ";
l3 = "-c:a libvorbis -c:v libvpx -strict -2 -auto-alt-ref 0 ";
l4 = "MergedBeepVideo.webm";
ffmpeg_alphamerge = l1+l2+l3+l4;
system(ffmpeg_alphamerge)
%% Merge mp4 and wavs into alpha stacked with wav, mp4 output
% Merge colour and alpha channels produced in Matlab, into a webm file
l1 = "ffmpeg -i flashVideoOutput.mp4 -i flashAlphaVideo.mp4 -i audio_beep_48k.wav ";
l2 = "-filter_complex hstack ";
l3 = "-c:v libx264 ";
l4 = "MergedBeepVideoStacked.mp4";
ffmpeg_alphamerge = l1+l2+l3+l4;
system(ffmpeg_alphamerge)
%%
for i = 1:length(SOAs)

    offsetString = SOAs(i);
    
    audioF = "BeepSOA" + offsetString + ".wav";
    videoF = "BeepSOA" + offsetString + ".webm";
    ffmpeg_combine = 'ffmpeg -i "'+ audioF + '" -i "MergedBeepVideo.webm" -acodec copy -mapping_family 0 -y -codec:v copy "' + videoF + '"';
    system(ffmpeg_combine);
end