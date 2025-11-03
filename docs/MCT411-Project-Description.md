# MCT411 – Hybrid Control Systems
## Fall 2025

**Faculty of Engineering – Ain Shams University**  
**Mechatronics Engineering Department**

---

## Major Task: Furuta Pendulum

### Description
You are required to make a Furuta Pendulum (Rotary Pendulum) as shown below in Figure 1.

### Requirements
1. Use pole placement / LQR techniques to control the pendulum. (using PID will result in deduced points)
2. Control the angle θ₁ to be zero. So, the pendulum stands in the upright position.
3. Overcome any disturbances that may affect the pendulum. So, the pendulum should maintain its upright position and don't fall.
4. Follow the standard procedure for performing a control task to design a controller to regulate the system's output according to the set control requirements.

**Figure 1 - Furuta Pendulum**

---

## Quick bullets you need to care for:
- You need one motor equipped with an encoder to control theta0 and one encoder (at least 360 pulses/revolution) for theta1.
- Wires should be hidden as much as you can, and All components must be fixed well.
- You can choose any platform that can be connected to the MATLAB from the below list in Figure 2.
- You must build and control your model on MATLAB/SIMULINK.
- You must implement HIL (Hardware in the loop) using SIMULINK

**Figure 2 - Example of supported platforms**

---

## Project Submission

### Working Structure
- Working in the project should be in groups of 4 - 5 students.

### Submission Phases
The project submission has 2 phases:

#### Phase #1: SimMechanics Model (Week 7)
Deliver a MATLAB model of the pendulum system (preferably using SimMechanics) of your design of furuta pendulum + controller in simulation. **(10%)**

#### Phase #2: Final Submission (Week 13)
Full project delivery according to the following table.

---

## Final Submission Form & Grading Scheme

| # | Deliverable | Weight |
|---|-------------|--------|
| 1 | Working prototype with a GUI to display pendulum angle (θ) and actuator signal (u)<br>The prototype shall demonstrate robustness against disturbances<br>**Note:** Bonus points are awarded for swing up controller design (10%) | 20% |
| 2 | Technical Report including the following:<br>1. Contribution of each member of the group<br>2. Detailed discussion of the following:<br>&nbsp;&nbsp;&nbsp;- Modelling of the pendulum system<br>&nbsp;&nbsp;&nbsp;- Method of controller design<br>&nbsp;&nbsp;&nbsp;- Controller requirements<br>&nbsp;&nbsp;&nbsp;- Implementation details<br>&nbsp;&nbsp;&nbsp;- Simulation results<br>&nbsp;&nbsp;&nbsp;- Detailed analysis of simulation vs actual results | 20% |
| 3 | Oral discussion | 20% |
| 4 | Simulation results and Controller implementation (Simulink model) | 15% |
| 5 | Demo video (5 min's max) that contains:<br>A) Demonstration of a working prototype<br>B) Brief discussion of controller design and simulation | 15% |

---

**Total Project Weight:** Phase 1 (10%) + Phase 2 (90%) = 100%  
**Bonus Opportunity:** Swing-up controller design (+10%)