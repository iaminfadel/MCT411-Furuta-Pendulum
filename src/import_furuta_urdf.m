function import_furuta_urdf()
% IMPORT_FURATA_URDF Imports the Furuta Pendulum URDF model into Simscape Multibody
% This function uses the Simscape Multibody URDF importer to create a Simulink 
% model from the URDF description of the Furuta Pendulum.

    % Path to the URDF file
    urdf_file = 'models/furuta_pendulum.urdf';
    
    % Check if URDF file exists
    if ~exist(urdf_file, 'file')
        error('URDF file does not exist: %s', urdf_file);
    end
    
    fprintf('Importing Furuta Pendulum URDF model...\n');
    fprintf('URDF file: %s\n', urdf_file);
    
    % Import the URDF model
    % Note: This requires Simscape Multibody
    try
        smimport(urdf_file);
        fprintf('URDF model imported successfully!\n');
        
        % Display model information
        fprintf('\nModel imported. You can now:\n');
        fprintf('- Run simulations to test the mechanical model\n');
        fprintf('- Add control algorithms to stabilize the pendulum\n');
        fprintf('- Connect sensors and actuators\n');
        fprintf('- Tune physical parameters\n');
        
    catch ME
        fprintf('Error importing URDF: %s\n', ME.message);
        fprintf('Make sure you have Simscape Multibody installed.\n');
        rethrow(ME);
    end
end