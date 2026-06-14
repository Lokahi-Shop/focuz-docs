# The Sequencer

The Sequencer is the heart of FocuZ. A job is an **ordered list of actions** that FocuZ runs top to bottom
when you press Run — see [How FocuZ works](index.md#how-focuz-works) for the model and why it differs from
the object/pen approach.

!!! info "This page is being written"
    The outline below is what it will cover.

## What this page will cover

- **Structure** — **groups**, **layers**, and **sublayers**; enabling/disabling, reordering, and
  collapsing.
- **Repeats & run-every-Nth** — repeating an action or group, and running a sublayer only on every Nth pass
  or 3D slice.
- **Action types**
    - *Marking:* **2D Import**, **3D Slice**
    - *Sequencer:* **Delay**, **Pause**, **Stop**, **Select**
    - *GRBL:* **Jog**, **Command**
    - *Calibration:* **WCS Offset**, **Test Grid**
- **Marking parameters** — Speed, Power, Frequency, Q-Pulse, Passes.
- **Fill types** — unidirectional / bidirectional / cross line fills, **Hilbert**, **snake**, **contour**
  (race-track / max-detail), and **thatch**; plus fill spacing/angle and auto-rotate.
- **Variation** — sweeping a parameter across a layer/action/sublayer (linear / sine / random).
- **Timings** — per-layer or per-action overrides for laser/jump delays (Device / Custom modes).
- **Cut sublayers** — marking an **offset band** around a path (with optional outline), for cut-style passes.

## See also

- [Marking & Tracing](marking-tracing.md) — running and previewing a job.
- [Importing Geometry](importing.md) · [The Canvas](canvas.md)
