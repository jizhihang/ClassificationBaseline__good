function [data_matrix, label_matrix, label_name_matrix] = LoadData(data_folder)



fprintf('Loading data for %s...\n', data_folder);

subfolder_dir = dir(data_folder);

data_matrix = [];
label_matrix =[];
label_name_matrix = cell(0);
label = 1;

for i = 1:length(subfolder_dir)    
    label_name = subfolder_dir(i).name;
    
    if (~strcmp(label_name, '.') && ~strcmp(label_name, '..'))        
        label_name_matrix = [label_name_matrix;label_name];
        data_dir = dir(fullfile(data_folder,subfolder_dir(i).name,'*.mat'));
        for  j = 1:length(data_dir)
            label_matrix = [label_matrix;label];
            load(fullfile(data_folder, subfolder_dir(i).name, data_dir(j).name));
            %DSIFT
            % data = feature_set.sift_des;
            %Other feature
            data = feature_set.feature;
            data = data';
            data = double(data(1:end));
            
            data = data./max(data);
%             data = (data-mean(data))./std(data);
            
            
%             data = data./sqrt(sum(data.^2));
            
            if (size(data_matrix,2) >= size(data,2))
                data_matrix = [data_matrix; data zeros(1, size(data_matrix,2) - size(data,2))];
            else
                data_matrix = [data_matrix zeros(size(data_matrix,1), size(data,2) - size(data_matrix,2)); data ];
            end
            
        end
        label = label+1;
    end
end




