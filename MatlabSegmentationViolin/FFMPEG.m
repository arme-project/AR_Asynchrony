%% 1=270:480  2-864:1632    w/h-1152:594
% Crop video
ffmpeg_string = 'ffmpeg -i Videos/OriginalVideo.mp4 -filter:v "crop=590:1150:270:480" Videos/OriginalVideoCropped.mp4';
system(ffmpeg_string)
%%
% Output video to png images
ffmpeg_to_images = 'ffmpeg -i MergedBeepVideo.webm -pix_fmt yuva420p Images/beepVideoRawStill%d.png'
system(ffmpeg_to_images)
%%
% Output audio as original
AudioFromVideo = 'ffmpeg -i Videos/OriginalVideo.mp4 -vn -acodec copy OriginalVideoAudio.aac';
system(AudioFromVideo)
%%
% Output audio to wav
AACtoWav = 'ffmpeg -i OriginalVideoAudio.aac OriginalVideoAudio.wav';
system(AACtoWav)
%%
% get info on file
ffmpeg_info = 'ffmpeg -i Videos/OriginalVideo.mp4';
system(ffmpeg_info)
%%
% Combine audio and video
ffmpeg_combine = 'ffmpeg -i "offsetAudio.wav" -i "VideoOutput.webm" -acodec libvorbis -mapping_family 0 -y -codec:v copy "CombinedVideoandAudioOffset.webm"';
ffmpeg_combine = 'ffmpeg -i "OriginalVideoAudio.aac" -i "VideoOutput.webm" -acodec libvorbis -mapping_family 0 -y -codec:v copy "CombinedVideoandAudio.webm"';
system(ffmpeg_combine)
%%
% Output as webm with alpha
ffmpeg_webm = 'ffmpeg -i OriginalVideoSegmentedStill%1d.png -r 24 -pix_fmt yuva420p WebMOUt.webm';
ffmpeg_webm = ""
ffmpeg_webm1 = 'ffmpeg -r 30 -i "VideoOutput.mp4" -c:v libvpx -b:v 0 -crf 30 -pix_fmt yuva420p -g 10 -pass 1 -an -auto-alt-ref 0 -f null NUL && '
ffmpeg_webm2 = 'ffmpeg -r 30 -i "VideoOutput.mp4" -i "OriginalVideoAudio.acc" -c:v libvpx -codec:a libvorbis -b:v 0 -crf 30 -pix_fmt yuva420p -g 10 -pass 2 -auto-alt-ref 0 "WebMOut.webm"'
ffmpeg_webm = string(ffmpeg_webm2) + string(ffmpeg_webm1);
system(ffmpeg_webm)
%%
%
ffmpeg_audioconvert = 'ffmpeg -i OriginalVideoAudio.aac -c:a copy -vn -ar 44100 -ac 2 OriginalVideoAudio44k.aac';
system(ffmpeg_audioconvert)
%%
% Merge colour and alpha channels produced in Matlab, into a webm file
l1 = "ffmpeg -i VideoOutput.mp4 -i AlphaOutput.mp4 -i OriginalVideoAudio44k.aac ";
l2 = "-filter_complex [0][1]alphamerge,format=yuva420p ";
l3 = "-c:a libvorbis -c:v libvpx -strict -2 -auto-alt-ref 0 ";
l4 = "MergedVideo.webm";
ffmpeg_alphamerge = l1+l2+l3+l4;
system(ffmpeg_alphamerge)






