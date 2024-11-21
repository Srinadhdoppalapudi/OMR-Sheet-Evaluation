function ok = is_img_ok(I)
    % Check if an OMR image is valid for evaluation.
    % Inputs: 
    %   I = grayscale image of the OMR sheet
    % Outputs:
    %   ok = 1 if image can be evaluated, 0 otherwise
    
    t = 200;  % Threshold for pixel intensity
    blackblock = 0;  % Counter for black blocks found

    % Define positions for the four sections to check
    positions = [
        128, 261;   % First section
        2324, 264;  % Second section
        130, 3214;  % Third section
        2325, 3215   % Fourth section
    ];
    
    xwid = 22;  % Width of the block to check
    ywid = 22;  % Height of the block to check

    % Iterate over each section and check for black pixels
    for l = 1:4
        startx = positions(l, 1);
        starty = positions(l, 2);
        
        n = 0;  % Counter for black pixels
        total = 0;  % Total pixels

        % Check each pixel in the block
        for i = 1:xwid
            for j = 1:ywid
                pixel = I(starty + j - 1, startx + i - 1);
                if pixel <= t
                    n = n + 1;  % Count black pixels
                end
                total = total + 1;  % Count total pixels
            end
        end
        
        % If 40% of the block is black, consider it as valid
        if n >= 0.4 * total
            blackblock = blackblock + 1;
        end
    end
    
    % If all four sections passed the check, the image is valid
    if blackblock == 4
        ok = 1;
    else
        ok = 0;
    end
end



new positions
% Load the new image
I = imread("C:\Users\SRINADH\OneDrive\Documents\DIP PROJECT\OMR-Sheet-Evaluation-main\OMR-Sheet-Evaluation\OMR IMAGE\OMR_1_1.jpg");  % Update with the correct path
I = rgb2gray(I);  % Convert the image to grayscale

% Display the image
imshow(I);
title('Select the new positions by clicking on the image');

% Use ginput to select points interactively
% For example, select 4 points for the new positions
[x, y] = ginput(4);

% Display the selected coordinates
disp('Selected positions (X, Y):');
for i = 1:length(x)
    disp(['Position ' num2str(i) ': X = ' num2str(x(i)) ', Y = ' num2str(y(i))]);
end

% Plot the selected positions on the image
hold on;
plot(x, y, 'ro', 'MarkerSize', 10, 'LineWidth', 2);  % Red circle markers for the points
hold off;

