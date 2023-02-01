close all
x=figure(1);
for n=1:101
    clf
    plot(0, 0, '.w', 'MarkerSize',10069)
    hold on
        if n==51
            plot(0, 0, '.r', 'MarkerSize',50)
        end
    axis([-100 100 -100 100])
    axis off
    drawnow
    M(n)=getframe(x);
end

%movie(M)

% v = VideoWriter('newfile.mp4','MPEG-4');
% open(v)
% writeVideo(v,M)
% close(v)