% Script written to take in regional LUT data, apply it to an image,
% and save the newly calibrated image.
% 12/21/15 - Aaron Fiscus
% 09/06/16 - Iuliu Vasilescu

% phase_image 512x512 0 - 2PI
% wavelength in nm
% returns 16bit uint16 image
function Image_new=ApplyLUT(phase_image, wavelength)
    pkg load mapping
    
    % LUT_location is the where the regional LUT is saved
    LUT_location = 'SLM3818_regional_LUT_1064.csv';
    LUT_input = csvread(LUT_location);  %Read in the regional LUT data
    LUT_wavelength = 1064;
    if wavelength>LUT_wavelength
      error('cannot apply LUT, wavelength too high');
    end
    
    phase_image = wrapTo2Pi(phase_image);
    phase_image = phase_image*wavelength/LUT_wavelength;
    Image = uint8(phase_image*256/2/pi);  % 8bit image
    
    num_regions = size(LUT_input,2)-1;  %64 regions in the LUT
    
    Image_new = zeros(512,512);  % Create an array to hold new image data
    
    i = 0;  % Place holder value for loop counting
    
    % The following loop goes through each pixel and applies the appropriate
    % region's LUT value
    for row = 1:512
        % The following calculates where on the image the row is and sets
        % the region appropriately.  For the case of 64 regions, the first
        % cur_region calculates either region 1, 9, 17, 25, 33, 41, 47, or 55.
        % Once in the col loop, this value is incremented by 1 every 64 
        % iterations through the loop to coincide with the correct region
        cur_region = 1+sqrt(num_regions)*i;
        if mod(row/64,1) == 0
            i = i + 1;
        end      
        for col = 1:512           
            col_mod = mod(col/64,1);
            Image_new(row,col) = LUT_input(Image(row,col)+1,cur_region+1);
            if (col_mod == 0)
                cur_region = cur_region + 1;
            end
        end
    end
    
    % As the new image is 8-bit, it will need to be upscaled to 16-bit
    Image_new = uint16(Image_new*256);
  
endfunction