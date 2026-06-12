# Quarter-Vehicle MBD Co-Simulation with Active Suspension Control

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Adams](https://img.shields.io/badge/MSC_Adams-2023-blue)
![MATLAB](https://img.shields.io/badge/MATLAB%2FSimulink-R2023b-orange)
![Python](https://img.shields.io/badge/Python-3.10+-green)

A full-stack multibody dynamics co-simulation project demonstrating active suspension control design using **MSC Adams** and **MATLAB/Simulink**, with Python-based parametric study and sensitivity analysis.

---

## Overview

This project implements a quarter-vehicle model to evaluate and optimize active suspension performance through the following integrated workflow:

1. **Multibody dynamics modeling** in MSC Adams (Adams View + Adams/Controls + Adams/Tire)
2. **Active suspension control design** in MATLAB/Simulink — from linearization and PID design to nonlinear co-simulation validation
3. **Parametric study and sensitivity analysis** in Python (SALib, GPR surrogate modeling) *(in progress)*

The workflow follows a **Model-Based Development (MBD) V-model process**: physical plant modeled in Adams, controller designed in Simulink via linearized state-space, and performance validated through real-time co-simulation — reflecting industry practice in automotive and industrial machinery development.

---

## System Architecture

```
┌──────────────────────────────────────────────────────┐
│                    MATLAB / Simulink                 │
│                                                      │
│   Road Input ──→ [ Adams Plant (S-Function .dll) ]  │
│                           │                         │
│               Sprung Mass Acceleration               │
│                           ↓                         │
│                   [ PID Controller ]                 │
│                           │                         │
│               Actuator Force ──→ [ Adams Plant ]    │
└──────────────────────────────────────────────────────┘
                ↕  TCP/IP  (Adams/Controls)
┌──────────────────────────────────────────────────────┐
│                MSC Adams Solver Process              │
│                                                      │
│   Sprung Mass ←── Suspension ←── Unsprung Mass      │
│                  (Spring + Damper + Actuator)        │
│                                    │                │
│                           PAC89 Tire Model          │
│                                    │                │
│                              Road Surface           │
└──────────────────────────────────────────────────────┘
```

> The Adams S-Function serves as an **interface layer** that launches a separate Adams Solver process at runtime. Simulink acts as the control-side master, exchanging states and forces with Adams at each co-simulation time step.

---

## Technical Stack

| Layer | Tool | Notes |
|---|---|---|
| Multibody Dynamics | MSC Adams (View + Controls + Tire) | Full MBS solver |
| Co-Simulation / Control | MATLAB / Simulink | S-Function interface |
| Tire Model | PAC89 (Magic Formula) | via Adams/Tire |
| Parametric Study | Python + adams-tools | Automated batch execution |
| Sensitivity Analysis | SALib (Sobol indices) | *(planned)* |
| Surrogate Modeling | scikit-learn (GPR) | *(planned)* |
| Visualization | matplotlib, plotly, Streamlit | *(planned)* |

---

## Model Details

### Quarter-Vehicle Parameters

| Parameter | Symbol | Value | Unit |
|---|---|---|---|
| Sprung mass | m_s | — | kg |
| Unsprung mass | m_u | — | kg |
| Suspension stiffness | k_s | — | N/m |
| Suspension damping | c_s | — | N·s/m |
| Tire model | — | PAC89 | — |

> Fill in actual values when the model is finalized.

### Tire Model

The **PAC89 (Magic Formula)** tire model is integrated via MSC Adams/Tire, capturing nonlinear force–slip and force–vertical load characteristics for realistic road–tire interaction.

### Control Design Workflow

```
Adams Model
    │
    ├─ Linearization  (Adams/Controls: operating point extraction)
    │         ↓
    │   State-Space Export  (.m file)
    │         ↓
    │   PID Design  (MATLAB pidtune / manual tuning)
    │         ↓
    └─ Nonlinear Validation  (Adams–Simulink Co-Simulation)
```

This flow mirrors the **MIL → Co-Simulation validation** step in the MBD V-model, ensuring that the controller designed on a linearized plant performs correctly on the full nonlinear MBS model.

---

## Results

> Screenshots and plots will be added here once PID tuning is complete.

### Performance Comparison: Passive vs. Active Suspension

| Metric | Passive | Active (PID) | Improvement |
|---|---|---|---|
| RMS Sprung Mass Acceleration (m/s²) | — | — | — |
| Max Suspension Stroke (mm) | — | — | — |
| Tire Load Variation (N) | — | — | — |

---

## Getting Started

### Prerequisites

- MSC Adams (Adams View, Adams/Controls, Adams/Tire)
- MATLAB R2023b or later with Simulink
- Python 3.10+

### Python Setup

```bash
git clone https://github.com/YOUR_USERNAME/quarter-vehicle-mbd-cosim.git
cd quarter-vehicle-mbd-cosim
pip install -r requirements.txt
```

### Running the Co-Simulation

1. Open `adams/models/quarter_vehicle.cmd` in Adams View
2. Open `simulink/models/qv_cosim.slx` in MATLAB/Simulink
3. Run the Simulink model — Adams Solver launches automatically via the S-Function
4. Simulation results are saved to `results/`

### Running the Parametric Study *(planned)*

```bash
cd python/parametric_study
python run_study.py
```

---

## Repository Structure

```
quarter-vehicle-mbd-cosim/
├── adams/
│   ├── models/             # Adams model files (.cmd, .adm, .adb)
│   ├── tire/               # PAC89 tire parameter files (.tir)
│   └── scripts/            # Adams batch execution scripts (.acf)
├── simulink/
│   ├── models/             # Simulink model files (.slx)
│   └── init_params.m       # Parameter initialization script
├── python/
│   ├── parametric_study/   # Automated parametric run scripts
│   └── postprocess/        # Result parsing and plotting
├── docs/
│   ├── architecture.png    # System overview diagram
│   └── theory.md           # Equations of motion and model background
├── results/                # Sample output data (.csv)
├── requirements.txt
└── README.md
```

---

## Roadmap

- [x] Quarter-vehicle multibody model (Adams View)
- [x] Adams/Tire integration (PAC89)
- [x] Adams–Simulink co-simulation setup (Adams/Controls)
- [x] PID active suspension controller
- [ ] Python parametric study (stiffness / damping sweep)
- [ ] Sobol sensitivity analysis (SALib)
- [ ] GPR surrogate model
- [ ] Streamlit visualization dashboard
- [ ] English technical article (Zenn / Medium)

---

## Background

This project was developed as part of a personal engineering portfolio. The author is a simulation engineer with 10+ years of experience in mechanical design and multibody dynamics, specializing in MSC Adams across the full product suite. The project demonstrates an end-to-end MBD workflow integrating physical modeling, control design, and data-driven analysis — skills increasingly required in automotive, industrial machinery, and robotics development.

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

## Contact

[LinkedIn](https://www.linkedin.com/in/YOUR_PROFILE) · [Zenn](https://zenn.dev/YOUR_ACCOUNT) · your.email@example.com
