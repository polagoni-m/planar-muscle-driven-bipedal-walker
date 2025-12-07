# Neuromechanical Simulation: Muscle-Driven Bipedal Walker

**Course:** ME 5374 - Neuromechanical Simulation of Human Movement  
**Author:** Mayank Goud Polagoni  
**Tools:** MATLAB, Simulink, Simscape Multibody, CMA-ES  

## 📖 Project Overview

This project implements and optimizes a planar, muscle-driven bipedal walker using **Simscape Multibody**. The model progresses from a simple point-mass system to a complex **Head-Arms-Trunk (HAT)** model with realistic inertia ($m=54$ kg), controlled by reflex-based neuromuscular circuits.

The goal was to synthesize stable walking gaits using **Covariance Matrix Adaptation Evolution Strategy (CMA-ES)** to optimize control parameters for specific objectives:
1.  **Metabolic Efficiency:** Minimizing muscle effort ($1.0$ m/s).
2.  **High-Speed Sprinting:** Maximizing velocity ($10.0$ m/s target).
3.  **Novel Behaviors:** Synthesizing "Marching" and "Crouch Walking" gaits.

---

## 🚀 Key Features

### Task 1: Point-Mass Walker
- Baseline implementation of a reflex-based controller.
- Optimization for energy efficiency vs. sprinting speed.

### Task 2: HAT Segment & Balance Control
- **Mechanical Extension:** Replaced point-mass trunk with a rigid **Brick Solid** ($l=0.8$ m, $54$ kg).
- **Control:** Implemented a **PD Balance Controller** to regulate trunk orientation ($\theta$) by modulating Hip Extensor (GLU) and Flexor (HFL) activation.
- **Optimization:** Tuned 17 parameters (12 Leg + 5 Trunk) to stabilize the inverted pendulum dynamics.

### Task 3: Novel Gait Synthesis (Bonus)
- **High-Stepping (Marching):** Customized cost function to reward maximum hip flexion (95th percentile).
- **Crouch Walking (Sneaking):** Customized cost function to reward knee flexion while penalizing low velocity, resulting in a stable "Groucho walk."

---

## 📂 Repository Structure

### 🏗️ Models
* `muscleLegs_task1.slx`: Baseline point-mass walker.
* `muscleLegs_task2.slx`: Extended walker with HAT segment and Planar Joint.

### ⚙️ Setup Scripts
* `setup_muscleLegs_model.m`: Mechanical parameters (Mass, Inertia).
* `setup_muscleLegs_nm.m`: Neuromuscular properties (Hill-type muscle dynamics).
* `setup_muscleLegs_ctrl.m`: Control parameters (Gains, Targets).
* `setup_muscleLegs_ic.m`: Initial conditions ($x_0$, $d\_x0$).

### 🧠 Optimization & Execution
* `sim_muscleLegs_Task2.m`: Simulation wrapper for standard tasks (Efficiency/Sprinting).
* `sim_muscleLegs_Task3.m`: **New** wrapper for Task 3 containing custom cost functions (High Step, Crouch).
* `run_Task2_2_Set1.m`: Optimization driver for Efficiency ($v=1.0$ m/s).
* `run_Task2_2_Set2.m`: Optimization driver for Sprinting ($v=10$ m/s).
* `run_Task3_HighStep.m`: Optimization driver for Marching behavior.
* `run_Task3_Crouch.m`: Optimization driver for Crouch behavior.

### 📊 Analysis
* `Plot_task2_1.m`: Generates the 5-subplot report figure (Trunk Angle, Kinematics, Dynamics).

---

## 🛠️ How to Run

### Prerequisites
* MATLAB R2022b or later (Recommended).
* Simulink & Simscape Multibody.
* `cmaes.m` (Ensure the `ext` folder is added to your path).

### 1. Running Standard Optimizations (Task 2)
To replicate the Efficiency or Sprinting results:
1.  Open `run_Task2_2_Set1.m` (Efficiency) or `run_Task2_2_Set2.m` (Sprint).
2.  Run the script.
3.  The optimizer will run for 50 iterations.
4.  Results are saved to `param/optim_results_*.mat`.
5.  A visualization of the best gait will play automatically upon completion.

### 2. Running Novel Gaits (Task 3)
To generate the "Marching" or "Crouch" behaviors:
1.  Open `run_Task3_HighStep.m` or `run_Task3_Crouch.m`.
2.  Run the script.
3.  **Note:** These scripts use `sim_muscleLegs_Task3.m`, which contains specific cost function logic (e.g., `-10 * step_height`).

### 3. Visualizing Saved Results
To replay a result without re-optimizing:
```matlab
load('param/optim_results_task2_set1.mat', 'bestever');
% 3rd argument is duration (e.g., 15 seconds)
sim_muscleLegs_Task2(bestever.x, {[1, 1, 1.0], 1, 15});
