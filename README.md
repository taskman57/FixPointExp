# Pressure-to-Altitude Conversion in VHDL

This project implements a **transducer equation** (a second-order series) in **VHDL** to convert **pressure (in millibars)** into **altitude (in meters)** with an accuracy of approximately **±0.01 m**.

An accompanying Excel spreadsheet is included for **fixed-point scaling** and intermediate **calculation verification**, 
supporting the numerical design and validation of the **RTL/VHDL** and **HLS** implementations.
Two snapshots from the **RTL** and **HLS** implementations are provided to offer insight into how the implementation of fixed-point numbers in **HLS** is realized.

## 📂 Repository Structure
```ProjectRoot/
├── RTL/             # VHDL source files for the transducer logic
├── Sim/             # Simulation files and testbenches
├── Boardfiles/      # Board-specific configuration and pin definitions
├── Constraint/      # FPGA constraint files (timing, pin assignments, etc.)
├── Scripts/         # Automation, synthesis, and build scripts
├── HLS/             # C++ files added as realization of fixed point numbers in Vitis HLS
├── Docs/            # Documentation, spreadsheets, and design notes
│   └── FixedPoint.xlsx  # Fixed-point scaling and verification calculations
│   └── RTL_Imp.JPG   # a snapshot of RTL resource usage
│   └── HLS_Res.JPG   # a snapshot of implementation in Vitis HLS
└── README.md         # Project overview and documentation
