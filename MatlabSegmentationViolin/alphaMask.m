function resultRGBImage = alphaMask(inputMask, image, bg_image)
    
    if bg_image == 0
        bg_image = zeros(size(image));
    end

    if ndims(bg_image) == 2
        bg_image = repmat(bg_image,[1 1 3]);
    end

    if ndims(image) == 2
        image = repmat(image,[1 1 3]);
    end

    mask = repmat(inputMask,[1 1 3]);
    invMask = 1-mask;
    invMask(invMask<0) = 0;

    for layer = 1:3

        image(:,:,layer) = uint8(double(image(:,:,layer)) .* mask(:,:,layer));
        image(:,:,layer) = image(:,:,layer) + uint8(double(bg_image(:,:,layer)) .* invMask(:,:,layer));

    end

    resultRGBImage = image;

end

%% result.r = background.r * (1 - A) + foreground.r * A
%% result.g = background.g * (1 - A) + foreground.g * A
%% result.b = background.b * (1 - A) + foreground.b * A