function [black, total] = blackpixelcounter(I, startx, starty)
    % Counts black pixels and total pixels in a specific area of the OMR sheet.
    % Inputs:
    %   I = Grayscale image
    %   startx = X-coordinate of the center of the area
    %   starty = Y-coordinate of the center of the area
    % Outputs:
    %   black = Number of black pixels
    %   total = Total number of pixels in the area
    
    radius = 21;  % Radius of the area
    diameter = 43;  % Diameter of the area
    sx = startx;
    sxnew = sx - radius;
    newwidy = 12; % Initial width of the region to evaluate
    totpix = 0;  % Total pixels in the area
    n = 0;  % Black pixels count
    t = 200;  % Threshold for black pixels

    for i = 1:diameter
        synew = starty - newwidy / 2;
        for j = 1:newwidy
            a = I(synew + j - 1, sxnew + i - 1);
            if a <= t
                n = n + 1;
            end
            totpix = totpix + 1;
        end
        
        % Adjust width of the region as you go along
        if i <= 4
            newwidy = newwidy + 4;
        elseif (i > 4 && i <= 11) || i == 15
            newwidy = newwidy + 2;
        elseif (i > 32 && i < 40) || i == 27 || i == 29
            newwidy = newwidy - 2;
        elseif i >= 40
            newwidy = newwidy - 4;
        end
    end
    
    black = n;
    total = totpix;
end
