% This script generally shows the usage of all the matlab functions we'll
% .. need for this project and is my best start on building the gaussian  
% .. and LoG pyramids.
%
% Input:  the cameraman image
% Output: graphs of image, image * gaussian, laplacian of gaussian (DoG)
% 
% I use the p0, p1, p2 notation used in the Crowley paper & proj. desc.
%    where: p0 = the image
%           p1 = p0 * G
%           p2 = p1 * G = p0 * G * G
% -----------------------------

% Global Vars Go Here
% -----------------------------
% showing_size is used to confirm the greyscale conversion works
SHOW_SIZE = false;

% read in the cameraman image
im = imread('cameraman.jpg');

% convert image to a double 
% -- prof's advice to do this, refer to 'bobtricks' in Canvas
im = double(im);

% convert image to grey scale b/c easier to work with
% moves image from 3 chanels R,G,B --> 1 chanel pixel values
p0 = (im(:,:,1) + im(:,:,2) + im(:,:,3))/3;

% print to command window the size of the image
% confirm that the color RGB color channels were removed
if SHOW_SIZE
    disp("Image Size: ");
    disp(size(im));
    disp("Gray Image Size: ");
    disp(size(p0));
end

% define gaussian, sigma=1 vector
g_sig1 = [1 4 6 4 1];
g_sig1_coef = 1/16;

% start of the gaussian pyramid --
% blur image with the gaussian
p1 = imfilter(p0, g_sig1 * g_sig1_coef, 'same', 'replicate');
p2 = imfilter(p1, g_sig1 * g_sig1_coef, 'same', 'replicate');

% start of the LoG pyramid --
% approximating LoG with difference of gaussian (DoG)
% --> allowed to do this from reasoning in Crowley paper
log_1 = p1 - p0;
log_2 = p2 - p1;

% display the images
subplot(2,3,1), imagesc(p0);
title("p0, Image");
subplot(2,3,2), imagesc(p1);
title("p1, Image * G");
subplot(2,3,3), imagesc(p2);
title("p2, Image * G * G");
subplot(2,3,4), imagesc(log_1);
title("p1 - p0, LoG");
subplot(2,3,5), imagesc(log_2);
title("p2 - p1, LoG");
colormap(gray);
