# Furuta Pendulum Control System - Requirements Documentation

## 1. Project Overview

The Furuta Pendulum Control System is a project for the MCT411 Hybrid Control course. The system must control a Furuta Pendulum (Rotary Pendulum) to maintain the pendulum in an upright position using LQR control techniques. The system will be implemented primarily in Simulink with Simscape for mechanical simulation.

## 2. System Requirements

### 2.1 Functional Requirements

| ID | Requirement | Description |
|----|-------------|-------------|
| FR-1 | Pendulum Control | System shall control the pendulum angle theta1 to be zero, maintaining the pendulum in the upright position |
| FR-2 | LQR Controller | System shall implement an LQR controller to regulate the pendulum in the upright position |
| FR-3 | Swing-up Controller | System shall implement a swing-up controller to move the pendulum from hanging position to upright position |
| FR-4 | Disturbance Rejection | System shall overcome disturbances and maintain the pendulum in the upright position |
| FR-5 | GUI Display | System shall provide a GUI to display pendulum angle and actuator signal |
| FR-6 | Simulation | System shall provide a Simulink simulation model of the Furuta Pendulum |
| FR-7 | HIL Implementation | System shall implement Hardware-in-the-Loop using Simulink with Arduino support package |

### 2.2 Non-Functional Requirements

| ID | Requirement | Description |
|----|-------------|-------------|
| NFR-1 | Robustness | System shall maintain pendulum stability despite external disturbances |
| NFR-2 | Real-time Performance | System shall update control signals in real-time |
| NFR-3 | Parameter Configurability | System shall allow configuration of physical and control parameters |
| NFR-4 | Modularity | System shall have modular architecture for easy maintenance and extension |

## 3. System Architecture

@startuml Furuta Pendulum Simulink Architecture
!theme plain

package "Furuta Pendulum Control System" {
  
  package "Configuration" {
    [Parameter Manager]
  }
  
  package "Simulink Models" {
    [Mechanical Model]
    [Controller Model]
    [HIL Interface]
  }
  
  package "MATLAB Components" {
    [LQR Design Tool]
    [GUI Application]
  }
}

[Parameter Manager] --> [Controller Model]
[Parameter Manager] --> [Mechanical Model]
[Parameter Manager] --> [GUI Application]
[Mechanical Model] --> [Controller Model]
[Controller Model] --> [HIL Interface]
[GUI Application] --> [Simulink Models]

@enduml

## 4. Simulink Model Structure

@startuml Simulink Model Structure
!theme plain

package "Main Model" as main
package "Subsystems" as sub
package "Sensors & Actuators" as io

main --> sub : contains
sub --> io : connects to

note bottom of main
  Furuta_Pendulum.slx
  Top-level model containing
  all subsystems
end note

note bottom of sub
  Mechanical System
  LQR Controller
  Swing-up Controller
  Mode Selector
  HIL Interface
end note

note bottom of io
  Arm Encoder
  Pendulum Encoder
  Motor Driver
end note

@enduml

## 5. Component Responsibilities

### 5.1 Mechanical Model
- Implements the physical Furuta Pendulum dynamics using Simscape Multibody
- Includes pendulum rod, arm, joints, and physical properties
- Provides sensor outputs (angles and angular velocities)

### 5.2 LQR Controller
- Implements Linear Quadratic Regulator for pendulum stabilization
- Maintains pendulum in upright position (theta1 ≈ 0)
- Uses state feedback with pre-computed gain matrix

### 5.3 Swing-up Controller
- Implements energy-based swing-up algorithm
- Moves pendulum from hanging position to upright position

### 5.4 Mode Selector
- Manages transitions between swing-up and regulation modes
- Automatically switches based on pendulum position

### 5.5 HIL Interface
- Provides interface between Simulink and Arduino hardware
- Reads encoder values from hardware
- Sends control signals to motor driver

### 5.6 Parameter Manager
- Loads configuration from JSON file
- Provides parameters to all Simulink blocks
- Enables easy tuning of system parameters

## 6. Constraints

- Must be implemented primarily in Simulink
- Mechanical system must use Simscape Multibody
- Must use LQR technique (not PID)
- Must implement HIL using Simulink Arduino support package
- Must support both simulation and hardware operation
- GUI must display pendulum angle and actuator signal