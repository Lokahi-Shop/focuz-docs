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
- **2D Cut** — mark an offset **cut band** around imported 2D art.
- **3D Slice** — slice a 3D model and mark it layer by layer.
- **3D Cut** — mark an offset cut band around a 3D model's outline.
- **3D Shadow** — flatten a 3D model to its floor outline and **fill** it like 2D art (see
  [below](#3d-shadow)).

**Sequencer**

- **Delay** — wait a set time.
- **Pause** — stop and wait for you to continue (a modal prompt).
- **Stop** — end the sequence here.
- **Select Action** — a no-op placeholder (skipped at marking); useful while building.

**GRBL** (the [FocuZ:grbl controller](jog-terminal.md))

- **GRBL - Jog** — move an axis as a job step.
- **GRBL - Command** — send raw G-code/M-code — including switching **accessory relays** (air assist,
  vacuum) on/off mid-job. See [the relay section](jog-terminal.md#accessory-relays-air-vacuum-more).

**Calibration**

- **WCS Offset** — align the mark to the part by dragging a target on the canvas (see
  [Lenses, Corrections & Calibration](lenses-corrections.md)).
- **Z Focus Test** — find the optimal focal height by marking a stepped-Z test pattern (see
  [Finding focus](lenses-corrections.md#finding-focus-the-z-focus-test)).
- **Test Grid** — mark a parameter-sweep grid to dial in settings (see [The Test Grid](test-grid.md)).

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

Common controls: **Spacing** and **Angle** for line fills, **Auto Rotate** (+ **Step**) to turn the fill
angle each pass, and a contour **offset** for the contour types.

On 2D Import layers, two extra rows shape the filled area itself:

- **Fill Offset** — grow (+) or shrink (−) the fill past the shape's boundary.
- **Hole Inset** — keep the fill a set distance short of the shape's interior holes.

## 3D layers: the Perimeter

3D actions (3D Slice, 3D Cut, 3D Shadow) can carry a **perimeter** — a closed boundary that bounds the
fill around the model's footprint (for a 3D Slice, the area between the perimeter and the model is what
gets carved). Pick a source from the **Perimeter ▾** menu on the layer:

- **Import…** — load a closed 2D path from a file.
- **Hull** — the model's own flattened outline, generated for you. Re-importing the model refreshes it.
- **Circle** / **Square** — a simple shape centered on the model's footprint (set its width/length).

A perimeter is a normal canvas object — select it to move it or edit it. With **Hull** or **Import**
selected, the size fields become a single **Off:** (offset) box that grows or shrinks the boundary evenly
all the way around; setting it back to 0 restores the original outline exactly.

**Respect holes** (Hull only, on by default) — the Hull follows the model's **through-holes**, so e.g. a
ring's center stays open instead of being treated as solid. Combined with **Fill-Through**, a through-hole
is marked at full depth — either way the hole is treated as real empty space. Uncheck it to use the outer
outline only.

## 3D Shadow

**3D Shadow** turns a 3D model into a flat engraving: the model is flattened to its floor outline (only
geometry at or above the floor counts) and the interior is **filled** like a 2D import — with the usual
fill types, an **Offset** to grow/shrink the outline first, and an optional perimeter to clip the fill.
The **Group** setting controls how the outline's through-holes fill: **Even / Odd** leaves holes open,
**Union** fills them solid.

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
