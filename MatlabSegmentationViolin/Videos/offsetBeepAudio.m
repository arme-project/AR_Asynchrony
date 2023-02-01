%% Audio
[y,Fs] = audioread("audio_beep_48k.wav",'native');
%% +- 0, 40, 80, 120, 150, 200, 250, 300, 400, 500
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
    
    fullFilenameString = "VRBeepSOA" + offsetString + ".wav";
    audiowrite(fullFilenameString,newAudio,Fs,"BitsPerSample",32);

end

%% Merge mp4 and wavs into alpha stacked with wav, mp4 output
% Merge colour and alpha channels produced in Matlab, into a webm file
for i = 1:length(SOAs)

    offsetString = SOAs(i);
    
    audioF = "VRBeepSOA" + offsetString + ".wav";
    videoF = "VRBeepSOA" + offsetString + ".mp4";
    l1 = "ffmpeg -i flashVideoOutput.mp4 -i flashAlphaVideo.mp4 -i " + audioF + " ";
    l2 = "-filter_complex hstack ";
    l3 = '-c:v libx264 -tune fastdecode -x264-params "keyint=1" ';
    l4 = videoF;
    ffmpeg_alphamerge = l1+l2+l3+l4;
    system(ffmpeg_alphamerge)
end
%% DONT USE
    
for i = 1:length(SOAs)

    offsetString = SOAs(i);
    
    audioF = "BeepSOA" + offsetString + ".wav";
    videoF = "BeepSOA" + offsetString + ".webm";
%     ffmpeg_combine = 'ffmpeg -i "'+ audioF + '" -i "MergedBeepVideo.webm" -acodec libvorbis -mapping_family 0 -y -codec:v copy "' + videoF + '"';

    l1 = "ffmpeg -i flashVideoOutput.mp4 -i flashAlphaVideo.mp4 -i " + audioF + " ";
    l2 = "-filter_complex [0][1]alphamerge,format=yuva420p ";
    l3 = "-c:a libvorbis -c:v libvpx -strict -2 -auto-alt-ref 0 ";
    l4 = videoF;
    ffmpeg_combine = l1+l2+l3+l4;
    system(ffmpeg_combine);

end