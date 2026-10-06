# The Sequencer

The Sequencer is the heart of FocuZ. A job is an **ordered list of actions** that FocuZ runs top to bottom
when you press Run. If you're used to the object/pen model of other galvo software, read
[How FocuZ works](index.md#how-focuz-works) first — the sequence-of-actions idea is what everything below
builds on.

## Structure: groups, layers, sublayers

Your job is organized as a tree:

- **Groups** hold layers and can **repeat** as a unit.
- **Layers** carry an action and its marking parameters.
- **Sublayers** are extra passes attached to a layer (a second marking pass, a jog, a cut, etc.).

To skip a node without deleting it, **right-click** it in the canvas [layer tree](canvas.md#the-layer-tree)
and choose **Disable marking** (**Enable marking** turns it back on). A disabled node is gray in the tree
and in its header, isn't drawn on the canvas, and doesn't mark. Groups can be **collapsed** to keep a big
job tidy. (Drag-to-reorder isn't available yet — build the order as you add.)

### Repeats & run-every-Nth

- **Passes** repeat a layer's mark N times.
- **Group repeat** runs a whole group multiple times.
- **Run every N** on a sublayer fires it only on every Nth pass or 3D slice (e.g. a jog or accessory step
  every 10th slice rather than every one).
- **Run once after all** on a Mark or Cut sublayer fires it once more after its layer's final pass and that
  pass's sublayers — a finishing or cleaning pass. Set **Run every** to 0 to make it fire *only* at the
  end. Not offered on rotary actions.

## Action types

Adding an action opens a picker grouped by purpose:

**Marking**

- **2D Import** — mark imported 2D art (see [Importing Geometry](importing.md)).
- **2D Cut** — mark an offset **cut band** around imported 2D art (see [The Cut Band](cut-band.md)).
- **3D Slice** — slice a 3D model and mark it layer by layer.
- **3D Cut** — mark an offset cut band around a 3D model's outline (see [The Cut Band](cut-band.md)).
- **3D Shadow** — flatten a 3D model to its floor outline and **fill** it like 2D art (see
  [below](#3d-shadow)).
- **Rotary ›** — one action per rotary fixture, each using its own Rotary Setup profile (see
  [Rotary Marking](rotary.md#the-2d-rotary-action)): **2D Rotary (Chuck)** and **2D Rotary (Roller)**
  mark 2D art wrapped around a cylindrical part, with the job's own part and split settings;
  **2D Grid (Chuck)** marks each split as a checkerboard of cells shared between two layers (see
  [The 2D Grid action](rotary.md#the-2d-grid-action)). A fixture whose profile is disabled in
  Rotary Setup isn't listed.

**Sequencer**

- **Delay** — wait a set time.
- **Pause** — stop and wait for you to continue (a modal prompt).
- **Stop** — end the sequence here.
- **Goto** — loop the sequence back to an earlier action. Pick the **target action** and a **Repeat**
  count: on reaching the Goto, the sequence returns to that action `Repeat` times (so the actions in
  between run `Repeat + 1` times total). **Repeat 0** passes straight through, as if the Goto weren't
  there. A run won't start until the Goto has both a target and a repeat count set. Goto loops can be
  **nested** — a Goto whose loop sits inside another Goto's loop runs its own repeats each time the
  outer loop comes back around.
- **Select Action** — a no-op placeholder (skipped at marking); useful while building.

**Motion** — every action that moves an axis, whichever controller drives it. Items marked
*(FocuZ)* run on the [FocuZ:grbl controller](jog-terminal.md); *(BJJCZ)* items run on the laser
board's rotary port.

- **Home (FocuZ)** — homes the axes you tick, Z first, then X, then Y, at the controller's own homing
  speeds. For Z you can tick **then return to 0 (lens focus)**: after homing, Z moves to the selected
  lens's focus, plus the **Offset** you enter (mm, **+ is up**). Make it **action #1**: then Run counts
  the ticked axes as homed — no homing prompt, and with Z ticked no lens-activation prompt either — and
  as soon as the homing is done FocuZ repeats Run's checks on the rest of the job, stopping if anything
  is still not right. (A homing line in a Command action homes too, but Run doesn't count it.) X and Y
  can return to 0 too, with their own offset: after homing Z, X and Y, the action returns Y, then X,
  then Z. X/Y 0 is the machine's 0 — on an axis that homes toward +, that is right at the limit switch,
  so use an offset that moves away from it (for example −5). A Home action further down the job is
  refused at Run if one of its axes isn't homed yet — move it to action #1. With it as action #1, Return
  to Start goes back to where the Home action left the machine.
- **Linear Axis Jog (FocuZ)** — move an axis as a job step. Pausing the run holds the move and Continue
  finishes it; FocuZ checks the axis arrived before going on.
- **Rotary Jog (BJJCZ)** — turn the rotary as a job step: pick the fixture (its Rotary Setup
  profile applies), **Rotation (degrees)** or **Distance (mm)** of part surface, the direction and
  the amount. A distance needs the part diameter — on the action, or blank for the profile's
  default (see [Rotary Jog](rotary.md#rotary-jog)).
- **Return to Start (FocuZ)** — return the axes you tick to the machine position they were at when
  the run started, Z first, then X, then Y, at the feedrate you set (mm/min). All three axes are
  listed with their live lens (LPos) and machine (MPos) position, so you can set the action up with no
  controller connected;
  a warning icon shows beside Copy while the controller is disconnected; hover it for the reason. The
  rows show the **start each axis will return to**, worked out from the sequence as you build it: an
  axis a Home action #1 homes shows where that action leaves it (marked *Action 1*); every other axis
  shows its live position, which becomes the start when you press Run. The lens the Z position is
  measured from is shown under the rows. The run-start position is recorded after the Run
  checks pass (or, with a Home action as action #1, once that action is done). The return is a move
  *back by the distance* from where the machine is, so it works on axes that aren't homed (Run only
  warns), and pausing the run holds it rather than cutting it short. Run refuses the job if a homing
  line in a Command action would home an axis that isn't homed yet before a Return to Start brings it
  back — the start would no longer match. After every return FocuZ checks the axis arrived.
- **Return to Saved 0 (FocuZ)** — the same panel, but each ticked axis moves to its saved 0 (Z = the
  selected lens's saved focal position; X/Y saved zeros are not available yet). Requires that axis's limit
  switches to be enabled in both + and − (Device Setup ▸ Enable Limit Switches); the warning icon says so.

!!! note "Return actions only raise Z"
    Both Return actions may only move Z in the + direction. Before a run starts, FocuZ walks the sequence's Z
    moves and blocks the run if a Return action would have to move Z down — or if it can't tell where Z will
    be at that point (for example after a homing command). Fix the sequence so Z is at or below the return
    position when the action runs. X and Y move either way.
- **Command (FocuZ)** — send raw G-code/M-code, **one command per line** — including switching
  **accessory relays** (air assist, vacuum) on/off mid-job. Lines run in order, and the sequence
  doesn't advance until every line — and any motion it started — has fully completed. Arcs
  (`G2`/`G3`) and probing (`G38`) aren't supported on the motion controller — FocuZ flags those
  lines before the run so you can correct them. See
  [the relay section](jog-terminal.md#accessory-relays-air-vacuum-more).

**Calibration**

Listed in the order you'd normally work through them:

- **Test Grid** — mark a parameter-sweep grid to dial in settings (see [The Test Grid](test-grid.md)).
- **WCS Offset** — align the mark to the part by dragging a target on the canvas (see
  [Lenses, Corrections & Calibration](lenses-corrections.md)).
- **Z Focal Distance** — find the optimal focal height by marking a stepped-Z test pattern (see
  [Finding focus](lenses-corrections.md#finding-focus-the-z-focal-distance-test)).
- **Red Light** — mark a centered reference square, then align the red guide beam to it (see
  [Lenses, Corrections & Calibration](lenses-corrections.md)).

## Adding, copying & removing actions

- **Add Action** (top of the Sequencer) appends a new action slot.
- Each slot starts on the **Select Action** chooser — pick a type from the picker to configure it.
- Once a real type is picked, the slot shows **Delete** and **Copy**: Copy duplicates the action (its
  type and settings) as a new slot; Delete removes it. An empty chooser slot shows **Delete** only —
  there's nothing to copy yet — and the sole remaining slot shows no buttons at all.
- The list always keeps at least one slot. Deleting the **last remaining** action returns it to the
  empty chooser instead of leaving an empty list; deleting any earlier action shifts the rest up and
  renumbers them. All of this is undoable.

## Marking parameters

Per layer:

| Parameter | What it does |
|---|---|
| **Speed** (mm/s) | Galvo speed while marking. |
| **Power** (%) | Laser power (0–100). |
| **Frequency** (kHz) | Pulse frequency, clamped to the device min/max. |
| **Q-Pulse** | Pulse-width / energy-per-pulse control. |
| **# of Passes** | Repeats each fill line (or, for a contour fill, each ring) that many times before moving on — like a per-segment pass count. **Unidirectional** and **Thatch** repeat a line in the same direction every time. **Snake** does the same for each straight run of its curve — run 1, run 1 again, round the turn, run 2, run 2 again — and marks each turn once. **Bidirectional** and **Cross** go back and forth along the line. Hidden for Wobble and Hilbert, where it doesn't apply. The whole-layer pass count is **Repeat** in the layer header. |

## Fill types

Pick a **fill** to engrave a filled area (leave it off to mark just the outline):

- **Unidirectional / Bidirectional / Cross** — straight line fills (one direction, back-and-forth, or
  crossed). Set **Spacing** and **Angle**.
- **Snake** — a continuous serpentine fill.
- **Contour** — concentric rings that follow the shape.
- **Thatch** — a tiled weave: each tile has four quadrants of short parallel lines, alternating upright
  and across (set the tile size and phase). It marks one quadrant at a time, every line of a quadrant in
  the same direction.

Common controls: **Spacing** and **Angle** for line fills, **Auto Rotate** (+ **Step**) to turn the fill
angle each pass, and **Center** (where the rings start, as a % of the spacing) for **Contour**.

On 2D Import layers, two extra rows shape the filled area itself:

- **Fill Offset** — grow (+) or shrink (−) the fill past the shape's boundary.
- **Hole Inset** — keep the fill a set distance short of the shape's interior holes.

Both shape the area *after* the layer's fill grouping has decided what counts as filled, so overlapping
shapes keep the behaviour you picked — a **Winding #** or **Union** overlap stays filled once you grow it,
and an **Intersection** grows the shared area rather than losing it.

## 3D layers: the Perimeter

3D actions (3D Slice, 3D Cut, 3D Shadow) can carry a **perimeter** — a closed boundary that bounds the
fill around the model's footprint (for a 3D Slice, the area between the perimeter and the model is what
gets carved). Pick a source from the **Perimeter ▾** menu on the layer:

- **Import…** — load a closed 2D path from a file.
- **Hull** — the model's outline where it meets the floor (Z 0), plus everything Fill Through carves above it,
  generated for you, so an overhanging model still gets a perimeter around its whole footprint; move the model up or down
  in Z and the Hull follows its cross-section there. Re-importing the model refreshes it.
- **Circle** / **Square** — a simple shape centered on the model's footprint (set its width/length).

A perimeter is a normal canvas object — select it to move it or edit it. With **Hull** or **Import**
selected, the size fields become a single **Off:** (offset) box that grows or shrinks the boundary evenly
all the way around; setting it back to 0 restores the original outline exactly.

**Respect holes** (on by default) — the model's **through-holes** are treated as real empty space with
**any** perimeter, or none. The checkbox sits next to **Fill Through** in the slice section; with a Hull
perimeter, the same setting also makes the Hull itself follow the holes (a ring's outline becomes a ring,
not a disc — the Hull's own checkbox toggles the same thing). What a hole becomes depends on the setup:
**with a perimeter**, the hole is carved at full depth along with the background; **without one**, it is
simply left unmarked and stands at the surface. Uncheck it to fill holes solid (legacy behavior).
Clean, watertight meshes give the truest holes. An imported multi-contour perimeter still clips with its
outer outline only.

## 3D Shadow

**3D Shadow** turns a 3D model into a flat engraving: the model is flattened to its floor outline (only
geometry at or above the floor counts) and the interior is **filled** like a 2D import — with the usual
fill types, an **Offset** to grow/shrink the outline first, and an optional perimeter to clip the fill.
The **Group** setting controls how the outline's through-holes fill: **Even / Odd** leaves holes open,
**Union** fills them solid.

## Variation

**Variation** changes a parameter as the mark progresses — from the layer's own value (the *first*
value) to a *second* value you enter. Tick **Speed**, **Power**, **Freq** and/or **Q-Pulse** and give
each its second value. The section heading reads **Variation (active)** while any parameter is varied.
The second-value boxes work like the main parameter boxes: a box turns red while what you typed has not
been entered yet, and **Enter** or clicking away enters it.

**Scope** — what one ramp runs across:

| Scope | The ramp runs… |
|---|---|
| **Segment** | along each stroke: one fill line, one contour ring, the whole curve of a Hilbert or Snake fill, one outline |
| **Chord** *(Hilbert, Snake)* | along each straight run of the curve |
| **Quadrant** *(Thatch)* | across the lines of each thatch quadrant |
| **Fill** | across each shape's fill, 0 → 100 % over that fill's own lines, starting again for the next shape — line by line (or ring by ring); on a **Hilbert** or **Snake** fill, along the full length of the curve. Anything that is not fill (an outline, an open line) marks at the first value; a layer with no fill at all behaves as Layer |
| **Layer** | across everything the layer marks in one pass — stroke by stroke; on a **Hilbert** or **Snake** fill, along the full length of everything marked |

On a Hilbert or Snake fill, Fill and Layer run 0 → 100 % over the whole fill even when the curve is in
several sections; Segment starts again on each section. Chord needs straight runs of at least 0.5 mm
to show — on a Hilbert fill that means cells that size or larger (a low depth, or a large shape).

**Type** — **1 → 2** ramps from the first value to the second; **1 → 2 → 1** goes to the second and
back — the middle line of a group (both middle lines of an even count), or the middle step of a stroke,
is exactly the second value; **Random** picks a value between the two.

**Width** is how much of the ramp the change takes (the rest holds the second value). **Slope** bends
the ramp: above 50 % it stays near the first value longer, below 50 % it reaches for the second sooner.

### How the ramp steps along a stroke

The stroke (for Fill and Layer on a Hilbert or Snake fill: the whole fill) is divided into equal steps
of **1 % of its length** — never shorter than 0.5 mm, so a 10 mm line gets 20 steps and a 1 mm line
gets two. A default thatch (1 mm tiles) has 0.5 mm lines, so Segment gives each of them two steps. The first step marks at exactly the first value and
the last at exactly the second (with 1 → 2 → 1, the middle step is the second value), so every stroke
completes the ramp whatever its length. A stroke shorter than 0.5 mm is too short to ramp and marks at
the first value.

The values in between come from the numbers as you typed them: halfway along is halfway between the
two values in mm/s, %, kHz or ns, and power still goes through your
[Power Map](hardware-setup.md#power-map-device-power-map).

### Variation with # of Passes

**Every pass carries the whole ramp** — with 4 passes each one runs 0 → 100 %, never a quarter each.

- Under the Quadrant, Fill and Layer scopes, every pass of a line carries that line's value.
- A **Unidirectional** or **Thatch** line, and each lap of a **contour ring** or an outline, repeats
  the same ramp on every pass.
- Every pass of a **Snake** run marks with the same values at the same place.
- On **Bidirectional** and **Cross** fills the passes of a line go out and back, and each ramps
  0 → 100 % along its own travel — so the return pass runs the ramp the other way along the line,
  just as neighbouring lines of a bidirectional fill do. For a gradient that builds the same way on
  every pass, use a fill that repeats in one direction.

The time estimate allows for a varied speed. Use variation for gradients, test ramps, or texture
effects: in a [Test Grid](test-grid.md) the second value gets its own axis, and on a rotary job the ramp
is worked out on the whole design ([Variation in rotary jobs](rotary.md#variation-in-rotary-jobs)).
Variation is not offered on 2D Grid layers.

## Timings

Per-layer or per-action overrides for laser/jump timing (laser on/off, polygon corner, end delays; jump
speed and ramp). Choose **Device** to use the global device defaults, or **Custom** to override for that
layer/action. Defaults from your `markcfg7` import are a good starting point.

## Sublayers

A sublayer attaches an extra step to a layer. On rotary actions a sublayer can also be attached to
the **group**, and where it is attached decides when it runs — see
[Sublayers in rotary jobs](rotary.md#sublayers-in-rotary-jobs). Set its **mode**:

- **Mark (Sub)** — a second marking pass with its own parameters (+ Run-every-N and Run once after all).
- **Jog** — move an axis (via the FocuZ:grbl controller) between passes/slices. Right of the Distance box the
  panel shows the **total travel** the run will produce (distance × how many times it fires, from the
  layer's passes or the 3D slice count, Run every, and the group repeat), so a Z step of −0.025 every 6
  passes over 580 passes reads as −2.4 mm total.
- **Terminal** — send raw GRBL command lines (e.g. switch a relay) as a step.
- **Cut** — mark an **offset band** around the path:
    - **Source** — an imported file, the layer **Perimeter**, or a **Border**.
    - **Offset** (how far out from the path) and **Distance** (band width).
    - Optional **outline**, or a wobble fill for the band.

## See also

- [Marking & Tracing](marking-tracing.md) — preview and run the job you built.
- [Importing Geometry](importing.md) · [The Canvas](canvas.md) · [Jog, Homing & Terminal](jog-terminal.md)
