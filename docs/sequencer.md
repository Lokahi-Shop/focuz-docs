# The Sequencer

The Sequencer is the heart of FocuZ. A job is an **ordered list of actions** that FocuZ runs top to bottom
when you press Run. If you're used to the object/pen model of other galvo software, read
[How FocuZ works](index.md#how-focuz-works) first — the sequence-of-actions idea is what everything below
builds on.

![TODO screenshot: the Sequencer with a few layers and actions](assets/sequencer-overview.png){ .screenshot }

<!-- TODO screenshot: Sequencer with groups/layers/sublayers -->

## Structure: groups, layers, sublayers

Your job is organized as a tree:

- **Groups** hold layers and can **repeat** as a unit.
- **Layers** carry an action and its marking parameters.
- **Sublayers** are extra passes attached to a layer (a second marking pass, a jog, a cut, etc.).

Each node has an **Enable** checkbox — disable a node to skip it without deleting it. Groups can be
**collapsed** to keep a big job tidy. (Drag-to-reorder isn't available yet — build the order as you add.)

### Repeats & run-every-Nth

- **Passes** repeat a layer's mark N times.
- **Group repeat** runs a whole group multiple times.
- **Run every N** on a sublayer fires it only on every Nth pass or 3D slice (e.g. a jog or accessory step
  every 10th slice rather than every one).

## Action types

Adding an action opens a picker grouped by purpose:

**Marking**

- **2D Import** — mark imported 2D art (see [Importing Geometry](importing.md)).
- **3D Slice** — slice a 3D model and mark it layer by layer.

**Sequencer**

- **Delay** — wait a set time.
- **Pause** — stop and wait for you to continue (a modal prompt).
- **Stop** — end the sequence here.
- **Select** — a no-op placeholder (skipped at marking); useful while building.

**GRBL** (the [FocuZ:grbl controller](jog-terminal.md))

- **GRBL - Jog** — move an axis as a job step.
- **GRBL - Command** — send raw G-code/M-code — including switching **accessory relays** (air assist,
  vacuum) on/off mid-job. See [the relay section](jog-terminal.md#accessory-relays-air-vacuum-more).

**Calibration**

- **WCS Offset** — align the mark to the part by dragging a target on the canvas (see
  [Lenses, Corrections & Calibration](lenses-corrections.md)).
- **Test Grid** — mark a parameter-sweep grid to dial in settings.

## Marking parameters

Per layer:

| Parameter | What it does |
|---|---|
| **Speed** (mm/s) | Galvo speed while marking. |
| **Power** (%) | Laser power (0–100). |
| **Frequency** (kHz) | Pulse frequency, clamped to the device min/max. |
| **Q-Pulse** | Pulse-width / energy-per-pulse control. |
| **Passes** | Number of times to repeat the layer. |

## Fill types

Pick a **fill** to engrave a filled area (leave it off to mark just the outline):

- **Unidirectional / Bidirectional / Cross** — straight line fills (one direction, back-and-forth, or
  crossed). Set **Spacing** and **Angle**.
- **Hilbert Curve** — a space-filling curve (set its depth/size).
- **Snake** — a continuous serpentine fill.
- **Contour Race Track** — fast concentric rings that follow the shape (offset insetting).
- **Contour Max Detail** — high-fidelity concentric fill (slower).
- **Thatch** — a textured/wobble fill (set its size and phase).

Common controls: **Spacing** and **Angle** for line fills, **Auto-Rotate** (+ rotate step) to turn the fill
angle each pass, and a contour **offset** for the contour types.

## Variation

**Variation** sweeps a parameter across a fill so it changes as the mark progresses:

- **Scope** — Layer, Action, or Sublayer.
- **Type** — Linear, Sine, or Random.
- **Per-parameter** — enable variation on Speed, Power, Frequency, and/or Q-Pulse, each with a value range.

Use it for gradients, test ramps, or texture effects.

## Timings

Per-layer or per-action overrides for laser/jump timing (laser on/off, polygon corner, end delays; jump
speed and ramp). Choose **Device** to use the global device defaults, or **Custom** to override for that
layer/action. Defaults from your `markcfg7` import are a good starting point.

## Sublayers

A sublayer attaches an extra step to a layer. Set its **mode**:

- **Mark (Sub)** — a second marking pass with its own parameters (+ Run-every-N).
- **Jog** — move an axis (via the FocuZ:grbl controller) between passes/slices.
- **Terminal** — send raw GRBL command lines (e.g. switch a relay) as a step.
- **Cut** — mark an **offset band** around the path:
    - **Source** — an imported file, the layer **Perimeter**, or a **Border**.
    - **Offset** (how far out from the path) and **Distance** (band width).
    - Optional **outline**, or a wobble fill for the band.

## See also

- [Marking & Tracing](marking-tracing.md) — preview and run the job you built.
- [Importing Geometry](importing.md) · [The Canvas](canvas.md) · [Jog, Homing & Terminal](jog-terminal.md)
