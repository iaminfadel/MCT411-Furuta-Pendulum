function furuta_startup()
% FURUTA_STARTUP Startup script for the Furuta Pendulum Control System
% This script initializes the system components and displays status information.

    fprintf('========================================\n');
    fprintf('Furuta Pendulum Control System Startup\n');
    fprintf('========================================\n');
    
    try
        % Load configuration
        fprintf('Loading configuration...\n');
        config = parse_config('config/parameters.json');
        fprintf('Configuration loaded successfully!\n');
        
        % Store configuration in base workspace for global access
        assignin('base', 'furuta_config', config);
        fprintf('Configuration stored in workspace as ''furuta_config''\n\n');
        
        % Display system information
        fprintf('System Configuration:\n');
        fprintf('  Pendulum rod length: %.3f m\n', config.physical_properties.pendulum_rod_length);
        fprintf('  Pendulum rod mass: %.3f kg\n', config.physical_properties.pendulum_rod_mass);
        fprintf('  Arm length: %.3f m\n', config.physical_properties.arm_length);
        fprintf('  Arm mass: %.3f kg\n', config.physical_properties.arm_mass);
        fprintf('  Gravity: %.3f m/s²\n', config.physical_properties.gravity);
        fprintf('  Simulation solver: %s\n', config.simulation.solver_type);
        fprintf('  Simulation step size: %.4f s\n', config.simulation.step_size);
        
        % Initialize components
        fprintf('\nInitializing system components...\n');
        
        % Initialize controllers
        fprintf('  Loading controller parameters...\n');
        controller_params = load_controller_params();
        fprintf('  Controller parameters loaded.\n');
        
        % Initialize hardware abstraction
        fprintf('  Creating hardware abstraction layer...\n');
        hw_abstraction = create_hardware_abstraction('simulation');
        fprintf('  Hardware abstraction layer ready (simulation mode).\n');
        
        % Show available modes
        fprintf('\nSystem ready!\n');
        fprintf('Available modes: simulation, hardware\n');
        fprintf('Configuration available as ''furuta_config'' in workspace\n');
        fprintf('Run "create_furuta_gui()" to start the GUI interface\n');
        fprintf('Run "furuta_pendulum_main()" for main control interface\n');
        
    catch ME
        fprintf('Error during startup: %s\n', ME.message);
        rethrow(ME);
    end
    
    fprintf('========================================\n');
end