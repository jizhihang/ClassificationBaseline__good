function ResizeImage( height, width, image_folder, output_folder )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

disp('Resize images...');
% pay attention to the image format,all image of this format will be used
% to calculate the sift feature

subfolders = dir(image_folder);

%database_sift.img_num = 0; % total image number of the database
%database_sift.path = {}; % contain the pathes for each image of each class

for i = 1:length(subfolders),
    subname = subfolders(i).name;
    if (~strcmp(subname, '.') && ~strcmp(subname, '..'))
        kind_folder = fullfile(image_folder,subname);
        kind_output_folder = fullfile(output_folder,subname);
        
        if (~isdir(kind_output_folder))
            mkdir(kind_output_folder);
        end
        %mkdir(sift_dir);
        
        fprintf('Resize images for %s...\n',kind_folder);
        image_format = '*.jpg';
        image_dir = dir(fullfile(kind_folder,image_format));

        image_num = length(image_dir);
        
         for j = 1:image_num

            image_path = fullfile(kind_folder,image_dir(j).name);
            image = imread(image_path);
            image = imresize(image,[height width]);           
            
            imwrite(image,fullfile(kind_output_folder,image_dir(j).name),'jpg');
        
        end
        
        fprintf('Processing for %s finished!\n',subname);
    end
end

