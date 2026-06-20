# Quarter-Car Active Suspension — Adams–Simulink Co-Simulation

> A high-fidelity multibody quarter-car (MSC Adams) coupled to a MATLAB/Simulink
> semi-active **skyhook** controller. Shows how closed-loop control improves ride
> comfort over a passive suspension, on both random and step road inputs.

![demo](results/demo.gif)

## What this is

The quarter-car plant (sprung mass, unsprung mass, suspension, PAC2002 tire) is built in
MSC Adams and exported with Adams/Controls as a co-simulation plant. Simulink runs the
controller and exchanges signals with the Adams Solver every communication interval. The
same model is switched between **passive** and **semi-active skyhook** control, and between
a **step** and a **random (ISO 8608)** road, so all four cases run from one script.

**Skills demonstrated:** multibody dynamics (MSC Adams), Adams–Simulink co-simulation,
semi-active control (skyhook), MATLAB scripting & signal processing, ride-comfort vs
road-holding analysis.

## Results

<!-- TODO: fill in your numbers and figures -->
On the random road, skyhook reduced the RMS sprung-mass acceleration by ~`XX`% versus
passive (better comfort); on the step road it settled noticeably faster. The trade-off is
slightly more suspension travel — the expected comfort vs rattle-space compromise.

| metric                          | passive | skyhook |
|---------------------------------|--------:|--------:|
| comfort — sprung accel RMS       |    …    |    …    |
| road holding — tire-defl RMS     |    …    |    …    |
| stroke — susp-defl RMS           |    …    |    …    |

![random road](results/random_road.png)
![step road](results/step_road.png)

## How it works

```
 road input            control force (skyhook)
     |                          ^
     v                          |
 +----------------+   y   +-------------------+
 |  MSC Adams     | ----> |  Simulink         |
 |  plant         |       |  skyhook / passive|
 | (Adams Solver) | <---- |                   |
 +----------------+   u   +-------------------+
   Adams/Controls           adams_sub S-Function
   (co-simulation)          (separate Adams Solver process)
```

Two base-workspace switches select the case:

- `use_skyhook` : 0 = passive, 1 = skyhook
- `use_random`  : 0 = step road, 1 = random road

## Repository structure

```
.
├── adams/                  # Adams quarter-car plant + Adams/Controls export
├── simulink/               # co-simulation model (.slx)
├── matlab/                 # init.m (setup) + postprocess.m (metrics & plots)
├── results/                # figures and demo animation
└── docs/                   # engineering notes
```

## How to run

1. **Export the plant (once).** In Adams/Controls, export the quarter-car for
   MATLAB/Simulink in *co-simulation* mode, producing `Controls_Plant.m`.
2. **Run `matlab/init.m`.** Sets the model parameters and generates the step and random
   road profiles.
3. **Run `matlab/postprocess.m`.** Runs all four cases (2 roads × passive/skyhook),
   prints the metric tables, and plots the comparisons.

## Design notes

- **Controller:** semi-active skyhook, `F = -C_sky * v_sprung`, clipped to the dissipative
  quadrant (a real damper can only remove energy).
- **Excitation:** the road is applied at the tire–road contact (road -> body), the
  physically correct input for a ride study.
- **Units:** the Adams model uses the MMKS system (mm, kg, N, s); logged signals are in
  mm and mm/s².
- **Known limitation:** the semi-active clipping produces a switching shock (acceleration
  spikes at damper on/off). Smoothing the transition (low-pass / rate-limit / dead-band)
  is listed under future work.

## Limitations & future work

- Smooth the semi-active switching to remove the acceleration spikes.
- Extend to a full-vehicle model (Adams/Car); add a braking / cornering scenario.
- Add Python automation for parameter sweeps and sensitivity analysis.

## References

- H. B. Pacejka, *Tyre and Vehicle Dynamics*.
- D. Karnopp, M. J. Crosby, R. A. Harwood — semi-active "skyhook" damping.
- ISO 8608 — mechanical vibration, road surface profiles.
- MSC Adams/Controls documentation.

## License

MIT — see [LICENSE](LICENSE).

## Author

`<name>` — multibody dynamics & CAE.  LinkedIn: `<link>`
