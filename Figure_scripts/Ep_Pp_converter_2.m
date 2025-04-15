%Script to extract Ep and Pp values to be used in figures
% Load the .mat file
load('BMA_search_PEB_only_clinicals_dep_anx_dx_52_participants_symptoms.mat');

% Set the sizes of the matrices and number of specified connections
region_n = 10;  
connection_n = 58;

% Get the indices from BMA.Pind
indices = BMA.Pind;

% Create matrices filled with zeros
Ep_matrix1 = zeros(region_n, region_n);
Pp_matrix1 = zeros(region_n, region_n);
Ep_matrix2 = zeros(region_n, region_n);
Pp_matrix2 = zeros(region_n, region_n);
Ep_matrix3 = zeros(region_n, region_n);
Pp_matrix3 = zeros(region_n, region_n);

% Fill the matrices with values from BMA.Ep and BMA.Pp
for i = 1:length(indices)
    row = ceil(indices(i) / region_n);
    col = mod(indices(i) - 1, region_n) + 1;
    Ep_matrix1(col, row) = BMA.Ep(i);
    Pp_matrix1(col, row) = BMA.Pp(i);
end

for i = 1:length(indices)
    row = ceil(indices(i) / region_n);
    col = mod(indices(i) - 1, region_n) + 1;
    Ep_matrix2(col, row) = BMA.Ep(i + connection_n);
    Pp_matrix2(col, row) = BMA.Pp(i + connection_n);
end

for i = 1:length(indices)
    row = ceil(indices(i) / region_n);
    col = mod(indices(i) - 1, region_n) + 1;
    Ep_matrix3(col, row) = BMA.Ep(i + 2*connection_n);
    Pp_matrix3(col, row) = BMA.Pp(i + 2*connection_n);
end

% Process matrices
ep_vector1 = process_and_format(Ep_matrix1, 'Ep1');
pp_vector1 = process_and_format(Pp_matrix1, 'Pp1');
ep_vector2 = process_and_format(Ep_matrix2, 'Ep2');
pp_vector2 = process_and_format(Pp_matrix2, 'Pp2');
ep_vector3 = process_and_format(Ep_matrix3, 'Ep3');
pp_vector3 = process_and_format(Pp_matrix3, 'Pp3');

% Display the R vectors
disp(ep_vector1);
disp(' ');
disp(pp_vector1);
disp(' ');
disp(ep_vector2);
disp(' ');
disp(pp_vector2);
disp(' ');
disp(ep_vector3);
disp(' ');
disp(pp_vector3);

% Function to process and format data
function r_vector = process_and_format(data, name)
    % Round to 2 decimal places
    rounded_data = round(data * 100) / 100;
    
    % Replace small values with 0
    rounded_data(abs(rounded_data) < 0.005) = 0;
    
    % Create the R vector string
    r_vector = [name, ' <- c('];
    for i = 1:numel(rounded_data)
        if mod(i-1, size(data, 2)) == 0 && i > 1
            r_vector = [r_vector, sprintf('\n        ')];
        end
        r_vector = [r_vector, sprintf('%.2f', rounded_data(i))];
        if i < numel(rounded_data)
            r_vector = [r_vector, ', '];
        end
    end
    r_vector = [r_vector, ')'];
end