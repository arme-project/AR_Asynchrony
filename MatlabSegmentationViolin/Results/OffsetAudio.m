%% Audio
[y,Fs] = audioread("OriginalVideoAudio.aac",'native');
%% +- 0, 40, 80, 120, 150, 200, 250, 300, 400, 500
% SOAs = ["-500", "-400", "-300", "-250", "-200", "-120", "-080", "-040", "+000", "+040", "+080", "+120", "+200", "+250", "+300", "+400", "+500"];
% SOAs = ["-200", "-130", "-080", "-040", "+000", "+040", "+080", "+130", "+200"];
% SOAs = ["-360", "-320", "-280", "-240", "-200", "-160", "-120", "-080", "-040", "+000", "+040", "+080", "+120", "+160", "+200", "+240", "+280", "+320", "+360"];
% SOAs = ["-200", "-150", "-100", "-050", "+000", "+050", "+100", "+150", "+200"];
% SOAs = ["-180", "-060", "+060", "+180"];
SOAs = ["-250", "-200", "-150", "-100", "-050", "+000", "+050", "+100", "+150", "+200", "+250"];

secondsPerSample = 1/double(48000);
%% 

for i = 1:length(SOAs)
    offsetString = SOAs(i);
    offsetDouble = (str2double(offsetString))+30;
    offsetSamples = int32((offsetDouble/1000)/secondsPerSample);
    newAudio = circshift(y,offsetSamples,1);
    
    fullFilenameString = "VRViolinSOA" + offsetString + ".wav";
    audiowrite(fullFilenameString,newAudio,Fs,"BitsPerSample",32)
end

%% Merge mp4 and wavs into alpha stacked with wav, mp4 output
% Merge colour and alpha channels produced in Matlab, into a webm file
for i = 1:length(SOAs)

    offsetString = SOAs(i);
    
    audioF = "VRViolinSOA" + offsetString + ".wav";
    videoF = "VRViolinSOA" + offsetString + ".mp4";
    l1 = "ffmpeg -i VideoOutput.mp4 -i alphaOutput.mp4 -i " + audioF + " ";
    l2 = "-filter_complex hstack ";
    l3 = '-c:v libx264 -tune fastdecode -x264-params "keyint=1" ';
    l4 = videoF;
    ffmpeg_alphamerge = l1+l2+l3+l4;
    system(ffmpeg_alphamerge)
end
%% DEPRECATED
    
for i = 1:length(SOAs)

    offsetString = SOAs(i);
    
    audioF = "ViolinSOA" + offsetString + ".wav";
    videoF = "ViolinSOA" + offsetString + ".webm";
    ffmpeg_combine = 'ffmpeg -i "'+ audioF + '" -i "MergedVideo.webm" -acodec libvorbis -mapping_family 0 -y -codec:v copy "' + videoF + '"';
    system(ffmpeg_combine);
end
%%
ffmpeg_keyframe = 'ffmpeg -hide_banner -y -i ViolinSOA+000.mp4 -pix_fmt yuv420p -c:v libx264 -crf 18 -g 1 ViolinSOA+000kf.mp4';
system(ffmpeg_keyframe)
