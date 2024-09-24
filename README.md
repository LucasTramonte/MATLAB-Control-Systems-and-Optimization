# MATLAB-Control-Systems-and-Optimization
This repository contains two MATLAB projects focused on control laws and one dedicated project exploring optimization techniques

## Autonomous vehicle control laws

This project focuses on the development of control laws for autonomous vehicles, specifically aimed at automating parking maneuvers. The study employs a nonlinear bicycle kinematic model to represent the vehicle's dynamics, which is linearized for control purposes. The control strategy implemented is based on Linear Quadratic (LQ) control, allowing for optimal trajectory tracking.

### Project Overview

The project includes the following key components:

- **Kinematic Model**: A nonlinear bicycle model is utilized to describe the vehicle's motion, incorporating state variables such as position and orientation.
- **Linearization**: The system is linearized around a nominal operating point to facilitate the application of control laws.
- **Controller Implementation**: A state feedback controller is designed using the LQ method, which optimizes the control inputs to minimize the deviation from a desired trajectory.
- **Simulation**: The model is implemented in Simulink, allowing for the visualization of the vehicle's trajectory compared to the reference path.

### Results

The results demonstrate that the actual trajectory of the vehicle closely follows the reference trajectory, indicating the effectiveness of the control laws developed. Additionally, the project explores improvements to the initial controller design to enhance lateral control performance.

### Features

- **Trajectory Tracking**: The controller ensures that the vehicle follows a predefined path accurately.
- **Simulation Environment**: Utilization of MATLAB and Simulink for modeling and simulation of the vehicle dynamics and control laws.
- **Performance Analysis**: Evaluation of the controller's performance through graphical representations of the vehicle's trajectory.

## Integer Linear Programming

This project explores the application of Integer Linear Programming (ILP) techniques to optimize bin packing problems, which are essential in logistics and inventory management. The focus is on minimizing the number of boxes required to pack a set of items with given volumes while adhering to specific capacity constraints.

### Problem Formulation

The ILP problem is defined with the following key components:

- **Decision Variables**: 
  - $$ x_{n,b}  :   \text{indicates whether item n is placed in box  b (1 if true, 0 otherwise)}.$$
  - $$ y_b      :   \text{indicates whether box  b is used (1 if true, 0 otherwise)} $$.

- **Objective Function**: 
  The goal is to minimize the total number of boxes used:

  $$ \text{Minimize} \quad \sum_{b=1}^{B} y_b $$


- **Volume Constraints**: 
  The total volume of items in each box must not exceed the box's capacity \( C \):

  $$ \sum_{n=1}^{N} v_n x_{n,b} \leq C \cdot y_b \quad \forall b \in \{1, \ldots, B\} $$


- **Packing Constraints**: 
  Each item must be packed into exactly one box:
 
  $$\sum_{b=1}^{B} x_{n,b} = 1 \quad \forall n \in \{1, \ldots, N\}$$

### Implementation

The ILP problem is solved using the `intlinprog` function in MATLAB. The algorithm efficiently finds the optimal solution while ensuring that all constraints are satisfied. The initial heuristic approach using a greedy algorithm serves as an upper bound for the number of boxes, which allows for a comparison with the optimal solution obtained through ILP.

### Results

The optimal solution found through ILP yielded a total of 18 boxes, confirming the theoretical lower bound derived from the volume distribution of the items. This approach showcases the effectiveness of ILP in achieving optimal packing configurations while adhering to practical constraints.

### Features

- **Heuristic and Optimal Approaches**: The project contrasts greedy heuristic methods with optimal ILP solutions.
- **Scalability**: The formulation and implementation can be scaled for larger datasets and varying constraints.

## Vehicle Communications Network Project

This repository contains a study on the performance of vehicular communication systems, focusing on the analysis of different access methods, specifically ALOHA and CSMA/CA.

### Project Overview

In this project, we establish a link budget to determine the maximum distance between access points and vehicles, ensuring effective communication in transportation systems. We utilize key parameters such as transmitted power, bandwidth, and minimum signal-to-noise ratio to conduct our analyses.

### Features

- **Link Budget Establishment**: Calculation of the maximum distance for reliable communication between access points and vehicles.
- **Performance Study**: Comparative analysis of ALOHA and CSMA/CA access methods, including packet loss rates based on vehicle density.
- **Simulation**: Implementation of a scenario using MATLAB's Automated Driving Toolbox to simulate real-time data collection from autonomous vehicles.

