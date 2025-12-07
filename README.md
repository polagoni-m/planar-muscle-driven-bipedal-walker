# Neuromechanical Simulation: Muscle-Driven Bipedal Walker

**Course:** ME 5374 - Neuromechanical Simulation of Human Movement  
**Author:** Mayank Goud Polagoni  
**Tools:** MATLAB, Simulink, Simscape Multibody, CMA-ES  

## 📖 Project Overview

This project implements and optimizes a planar, muscle-driven bipedal walker using **Simscape Multibody**. The project is divided into three main tasks progressing from a simple point-mass system to a complex **Head-Arms-Trunk (HAT)** model with realistic inertia ($m=54$ kg), controlled by reflex-based neuromuscular circuits.

The goal was to synthesize stable walking gaits using **Covariance Matrix Adaptation Evolution Strategy (CMA-ES)** to optimize control parameters for specific objectives:
1.  **Metabolic Efficiency:** Minimizing muscle effort ($1.0$ m/s).
2.  **High-Speed Sprinting:** Maximizing velocity ($10.0$ m/s target).
3.  **Novel Behaviors:** Synthesizing "Marching" (High-Step) and "Sneaking" (Crouch) gaits.

---

## 📂 Repository Structure

### 🏗️ Models (Simulink)
* `muscleLegs_task1.slx`: Baseline point-mass walker model (Task 1).
* `muscleLegs_task2.slx`: Extended walker model with rigid HAT segment and Planar Joint (Task 2 & 3).

### ⚙️ Setup & Configuration
* `setup_muscleLegs_model.m`: Defines mechanical parameters (Mass, Inertia, Geometry).
* `setup_muscleLegs_nm.m`: Configures neuromuscular properties (Hill-type muscle dynamics: $F_{max}$, $l_{opt}$).
* `setup_muscleLegs_ctrl.m`: Calculates reflex control gains and target angles; handles parameter injection.
* `setup_muscleLegs_ic.m`: Sets initial conditions ($x_0$, $d\_x0$, leg angles).

### 🚀 Execution Scripts (Main Drivers)
* `main_muscleLegs.m`: Master execution script for running general simulations.
* **Task 1 (Point-Mass Optimization):**
    * `main_task1_1_set1.m`: Runs optimization for Efficiency ($v=1.0$ m/s).
    * `main_task1_1_set2.m`: Runs optimization for Sprinting ($v=10.0$ m/s).
* **Task 2 (HAT Model Optimization):**
    * `main_task2_2_set1.m`: Runs optimization for Efficiency ($v=1.0$ m/s).
    * `main_task2_2_set2.m`: Runs optimization for Sprinting ($v=10.0$ m/s).
* **Task 3 (Novel Gaits):**
    * `main_task3_HighStep.m`: Optimizes for "Marching" gait (High Hip Flexion).
    * `main_task3_Crouch.m`: Optimizes for "Sneaking" gait (Crouch Walking).

### 🧠 Simulation Wrappers (Cost Functions)
* `sim_muscleLegs_Task1.m`: Wrapper for Task 1; calculates cost based on metabolic effort and velocity.
* `sim_muscleLegs_Task2.m`: Wrapper for Task 2; injects 17 parameters (Legs + Trunk) and calculates cost.
* `sim_muscleLegs_Task3.m`: Wrapper for Task 3; contains custom cost logic for High-Step and Crouch behaviors.

### 📊 Analysis & Plotting
* `Plot_task1_1.m`: Generates the 4-subplot report figure for Task 1 (Kinematics & Dynamics).
* `Plot_task2_1.m`: Generates the 5-subplot report figure for Task 2 (Trunk Angle, Kinematics, Dynamics).

### 💾 Optimization Data (Results)
Contains the saved CMA-ES results (`bestever` parameters and history):
* `cmaes_task1_2_set1.mat` / `cmaes_task1_2_set2.mat`
* `cmaes_task2_2_set1.mat` / `cmaes_task2_2_set2.mat`
* `cmaes_task3_highstep.mat` / `cmaes_task3_crouch.mat`

---

## 🛠️ How to Run

### Prerequisites
1.  Ensure MATLAB (R2022b+) and Simulink/Simscape Multibody are installed.
2.  Ensure `cmaes.m` is in your path (if running optimizations).

### 1. Reproducing Task 1 & 2 Results
To run a specific optimization or visualize the result:
1.  Open the desired main script (e.g., `main_task2_2_set1.m`).
2.  Run the script.
3.  The script will load the corresponding `.mat` file (e.g., `cmaes_task2_2_set1.mat`) and visualize the best solution found.

### 2. Generating Report Plots
To generate the figures used in the report:
1.  Run a simulation first (using `main_muscleLegs.m` or by running a visualization).
2.  Run `Plot_task1_1.m` (for point-mass) or `Plot_task2_1.m` (for HAT model).

---

## 📈 Results Summary

| Task | Objective | Final Cost | Result Description |
| :--- | :--- | :--- | :--- |
| **Task 2-1** | Hand-Tuning | N/A | Stable walking for >12s with minimal trunk sway. |
| **Task 2-2 Set 1** | Efficiency | **1.32** | Highly efficient, upright gait minimizing metabolic cost. |
| **Task 2-2 Set 2** | Sprinting | **76.0** | Aggressive forward lean; velocity increased to ~1.35 m/s. |
| **Task 3A** | High Step | **-18.49** | Exaggerated marching gait with swing legs reaching horizontal. |
| **Task 3B** | Crouch | **23.80** | Stable "sneaking" gait with continuous knee flexion. |

---

## 📝 License
This project is for educational purposes for ME 5374.
