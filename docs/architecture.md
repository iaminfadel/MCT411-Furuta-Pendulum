# Furuta Pendulum Control System - Architecture Documentation

## 1. System Overview

The Furuta Pendulum Control System is designed with a Simulink-centric architecture to support both simulation and Hardware-in-the-Loop (HIL) operation. The system primarily uses Simulink blocks for control and Simscape for mechanical modeling, with minimal MATLAB code for parameter management and GUI.

## 2. High-Level Architecture

@startuml High-Level Simulink Architecture
!theme plain

package "Furuta Pendulum Control System" as system {
  
  package "Configuration" as config {
    [JSON Parameter Manager]
  }
  
  package "Simulink Models" as sim {
    [Main Control Model]
    [Mechanical System Model]
    [Controller Models]
    [HIL Interface Model]
  }
  
  package "MATLAB Components" as matlab {
    [Parameter Manager]
    [LQR Design Tools]
    [GUI Application]
  }
}

config --> sim : Provides parameters
sim --> matlab : Provides data for visualization
matlab --> sim : Provides configuration and control

@enduml

## 3. Simulink Model Architecture

@startuml Simulink Model Architecture
!theme plain

component "Main Model" as main
component "Mechanical System" as mech
component "Controller System" as ctrl
component "HIL Interface" as hil
component "Visualization" as gui

main --> mech : contains
main --> ctrl : contains
main --> hil : contains
main --> gui : contains

note bottom of main
  Furuta_Pendulum.slx
end note

note bottom of mech
  Simscape Multibody
  Physical components
end note

note bottom of ctrl
  LQR Controller
  Swing-up Controller
  Mode Selector
end note

note bottom of hil
  Encoder Interface
  Motor Control
end note

note bottom of gui
  Scopes
  Dashboard
end note

@enduml

## 4. Detailed Block Diagram

@startuml Detailed Block Diagram
!theme plain

component "Mechanical System" as mech
component "LQR Controller" as lqr
component "Swing-up Controller" as swing
component "Mode Selector" as mode
component "HIL Interface" as hil
component "Parameter Manager" as param
component "GUI Display" as gui

param --> mech : provides parameters
param --> lqr : provides parameters
param --> swing : provides parameters
param --> mode : provides parameters

mech --> lqr : provides state
mech --> swing : provides state
mech --> gui : provides data

lqr --> mode : control signal
swing --> mode : control signal
mode --> hil : control command

hil --> mech : hardware feedback
gui --> mech : requests data

note top of mech
  Simscape-based
  Input: Torque (u)
  Output: Angles, Velocities
end note

note top of lqr
  Input: State Vector
  Output: Control Signal
end note

note top of swing
  Input: State Vector
  Output: Control Signal
end note

note top of mode
  Input: Current State
  Output: Active Controller
end note

note top of hil
  Input/Output: Hardware Signals
end note

note top of param
  Input: JSON config
  Output: System Parameters
end note

note top of gui
  Input: System Data
  Output: Visual Feedback
end note

@enduml

## 5. Data Flow Architecture

@startuml Data Flow Architecture
!theme plain

participant "User" as user
participant "Main Model" as main
participant "Mechanical Model" as mech
participant "Controller" as ctrl
participant "HIL Interface" as hil
participant "GUI" as gui

user -> main: Start Simulation/HIL
activate main

main -> main: Load Configuration
note right: From JSON parameters

main -> mech: Initialize Mechanical System
activate mech
mech --> main: System Ready
deactivate mech

loop Continuous Operation
    main -> mech: Get Current State
    activate mech
    mech --> main: State (theta1, theta2, theta1_dot, theta2_dot)
    deactivate mech
    
    main -> ctrl: Compute Control Signal
    activate ctrl
    ctrl --> main: Control Signal (u)
    deactivate ctrl
    
    alt Simulation Mode
        main -> mech: Apply Control
        activate mech
        mech --> main: Updated State
        deactivate mech
    else Hardware Mode
        main -> hil: Send Control Command
        activate hil
        hil --> main: Command Sent
        deactivate hil
    end
    
    main -> gui: Update Display
    activate gui
    gui --> main: Display Updated
    deactivate gui
end

deactivate main

@enduml

## 6. Configuration Management

The system uses a JSON-based configuration approach that feeds parameters into Simulink blocks:

@startuml Configuration Flow
!theme plain

component "config/parameters.json" as json
component "parse_config.m" as parser
component "Simulink Workspace" as workspace
component "Simulink Blocks" as blocks

json --> parser : read
parser --> workspace : load parameters
workspace --> blocks : provide parameters

note right of workspace
  Parameters available
  to all Simulink blocks
end note

@enduml

## 7. Component Responsibilities

### 7.1 Mechanical System (Simscape)
- Models the physical Furuta Pendulum using Simscape Multibody
- Includes pendulum rod, arm rod, rotary joints, and base
- Applies physical properties (mass, length, friction)
- Provides sensor outputs for position and velocity

### 7.2 LQR Controller (Simulink)
- Implements Linear Quadratic Regulator algorithm
- Stabilizes pendulum in upright position
- Computes optimal control signal based on state feedback
- Uses pre-computed gain matrix from MATLAB

### 7.3 Swing-up Controller (Simulink)
- Implements energy-based swing-up algorithm
- Controls pendulum motion from hanging to upright position
- Switches control strategy based on pendulum energy
- Coordinates with mode selector for seamless transition

### 7.4 Mode Selector (Simulink)
- Monitors pendulum state to determine control mode
- Switches between swing-up and regulation controllers
- Implements smooth transition logic
- Manages control signal blending during transitions

### 7.5 HIL Interface (Simulink)
- Interfaces with Arduino hardware via Simulink Support Package
- Reads encoder values from physical system
- Sends PWM control signals to motor
- Handles communication protocols and timing

### 7.6 Parameter Manager (MATLAB)
- Loads system parameters from JSON configuration file
- Makes parameters available to Simulink workspace
- Provides interface for parameter tuning
- Manages physical properties, controller gains, and simulation settings

### 7.7 GUI Application (MATLAB)
- Provides real-time visualization of system states
- Displays pendulum angles, angular velocities, and control signals
- Offers parameter adjustment interface
- Provides data logging and analysis capabilities

## 8. File Structure

```
Furuta_Pendulum/
├── config/
│   └── parameters.json
├── docs/
│   ├── requirements.md
│   └── architecture.md
├── models/
│   ├── Furuta_Pendulum.slx          # Main Simulink model
│   ├── Mechanical_Model.slx         # Simscape mechanical system
│   ├── Controller_Model.slx         # Control algorithms
│   └── HIL_Interface.slx           # Hardware interface
├── src/
│   ├── parse_config.m
│   ├── furuta_startup.m
│   └── create_furuta_gui.m
└── tests/
    └── test_controllers.slx
```

## 9. Implementation Approach

The system follows a Model-Based Design approach where:
1. Physical system is modeled in Simscape Multibody
2. Control algorithms are implemented in Simulink blocks
3. Parameters are managed via JSON configuration
4. Hardware interface uses Simulink Arduino Support Package
5. Visualization and high-level operations use MATLAB