function [Xo, Yo, Zo, Uo, Vo, Wo] = read_input(input_filename, sat_id)
% Reads parameters stored in satellite_data.txt 
% into MATLAB
% Input_filename is a string denoting the name of the file to be read
% sat_id is an integer indicating the satellite ID number
% outputs are initial position (Xo, Yo, Zo) and components of initial
% velocity (Uo, Vo, Wo)
% When sat_id is not available in the file, output is NaN and an error
% warning will be displayed to screen

pm = importdata(input_filename, ',',2);

if any(sat_id == pm.data(:,1))
    row = find(sat_id == pm.data(:,1));
    Xo = pm.data(row,2);
    Yo = pm.data(row,3);
    Zo = pm.data(row,4);
    Uo = pm.data(row,5);
    Vo = pm.data(row,6);
    Wo = pm.data(row,7);
else
    disp('read_input: invalid sat_id');
    Xo = NaN;
    Yo = NaN;
    Zo = NaN;
    Uo = NaN;
    Vo = NaN;
    Wo = NaN;
end
end % function read_input