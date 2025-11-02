# Pressure-to-Altitude Conversion in VHDL

This project implements a **transducer equation** (a second-order series) in **VHDL** to convert **pressure (in millibars)** into **altitude (in meters)** with an accuracy of approximately **±0.01 m**.

An accompanying **Excel spreadsheet** is included for **fixed-point scaling** and intermediate **calculation verification**, supporting the numerical design and validation of the VHDL implementation.

---
## 📂 Repository Structure
ProjectRoot/
├── RTL/             # VHDL source files for the transducer logic
├── Sim/             # Simulation files and testbenches
├── Boardfiles/      # Board-specific configuration and pin definitions
├── Constraint/      # FPGA constraint files (timing, pin assignments, etc.)
├── Scripts/         # Automation, synthesis, and build scripts
├── Docs/            # Documentation, spreadsheets, and design notes
│   └── FixedPoint.xlsx  # Fixed-point scaling and verification calculations
└── README.md         # Project overview and documentation
