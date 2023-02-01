function [outputImage] = getBoundarySmoothedImage(BW)
    inputImage = BW;
    [nx,ny] = size(inputImage) ;
    [y,x] = find(inputImage(:,:)==1) ;
    outputImage = zeros(nx,ny) ;
    [X,Y] = meshgrid(1:ny,1:nx) ;
    idx = boundary(x,y,1.0) ;
    idx = inpolygon(X(:),Y(:),x(idx),y(idx)) ;
    outputImage(idx) = 1 ;
end