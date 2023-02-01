function [maskedRGBImage] = maskImage(BWMask, RGBImage)
    maskedRGBImage = RGBImage;
    maskedRGBImage(repmat(~BWMask,[1 1 3])) = 0;
end