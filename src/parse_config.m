function config = parse_config(json_file_path)
% PARSE_CONFIG Parses a JSON configuration file for the Furuta Pendulum Control System
% Inputs:
%   json_file_path - Path to the JSON configuration file
% Outputs:
%   config - Structure containing all configuration parameters

    % Default path if none provided
    if nargin < 1
        json_file_path = '../config/parameters.json';
    end
    
    % Check if file exists
    if ~exist(json_file_path, 'file')
        error('Configuration file does not exist: %s', json_file_path);
    end
    
    % Read and parse JSON file
    json_text = fileread(json_file_path);
    config = jsondecode(json_text);
    
    % Convert parameter arrays to MATLAB-friendly formats
    config = convert_parameter_arrays(config);
end

function config = convert_parameter_arrays(config)
% CONVERT_PARAMETER_ARRAYS Converts parameter arrays to appropriate MATLAB formats
    
    % Convert LQR Q matrix to double matrix
    if isfield(config.controllers.lqr, 'Q')
        config.controllers.lqr.Q = cell2mat(config.controllers.lqr.Q);
    end
    
    % Convert LQR R matrix to double matrix
    if isfield(config.controllers.lqr, 'R')
        config.controllers.lqr.R = cell2mat(config.controllers.lqr.R);
    end
    
    % Convert initial conditions to array
    if isfield(config.simulation, 'initial_conditions')
        ic = config.simulation.initial_conditions;
        config.simulation.initial_conditions_array = [ic.theta_arm, ic.theta_pendulum, ...
                                                     ic.theta_arm_dot, ic.theta_pendulum_dot];
    end
end