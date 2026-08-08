# Lenses, Corrections & Calibration

FocuZ keeps correction and focus settings **per lens** (L1–L8), so swapping lenses doesn't mean re-tuning.
This section covers selecting a lens, distortion correction, the work-coordinate offset, focal height, and
aligning the mark to the part.

## Lens management

- Pick the active lens (**L1–L8**) from the lens selector. Each lens carries its own field size, correction,
  work offset, and focal Z.
- Selecting a lens shows a short summary of its settings.
- When the lens needs a known Z reference, FocuZ may prompt to home / jog before marking (see the
  [homing gate](marking-tracing.md#lens-activation-homing-gate)).

## Distortion correction (the Corrections dialog)

Open **Corrections** from **Device ▸ Lens Corrections** (it applies to the currently selected lens),
or during [Device Setup](getting-started/first-run.md). It has two modes for correcting galvo/lens
distortion, and remembers settings per lens:

=== "`.cor` file (recommended)"

    Load the **`.cor`** correction file your lens uses — the same file format EZCad2 and LightBurn use. The
    file supplies the distortion map and field size. You can optionally fine-tune **Scale** and **Angle** on
    top of it. (Manual-only fields are greyed out while a `.cor` is loaded.)

=== "Manual"

    With no `.cor`, enter correction values directly:

    - **Scale X/Y** and **Angle**
    - per-lens **Field size X/Y** (mm)
    - **Bulge**, **Parallel**, and **Trapezoidal** correction (X/Y)

    Or import them from a `markcfg7`: **From device markcfg7** reuses the file the device was
    configured with (no file picking needed), and **Choose markcfg7…** imports from any file. Either
    way, if the file carries a different work offset, FocuZ asks whether to bring that in too.

    **Field size** may be left **empty** — that means "not set for this lens", and the grayed number in
    the box is the device value FocuZ will use instead. Setting it correctly matters: field size scales
    every mark, so a wrong one makes everything the wrong *size*. **From device markcfg7** is the
    quickest way to get it right, because it brings in the field size and the scale together.

!!! tip "Round at center, distorted at the edges?"
    That's a distortion-correction issue — load the correct `.cor` for the lens, or tune the manual values.
    See [Troubleshooting](troubleshooting.md).

!!! tip "Marks come out the right shape but the wrong size?"
    That's field size, not distortion. Check the **Field size** on the lens card — it shows the value in
    use and where it came from (`.cor` file, set for this lens, or the device default). With a `.cor`
    loaded you can trim the remaining error with the **Scale** boxes, which fine-tune on top of the file:
    multiply the current scale by `target / measured`.

## WCS (work coordinate) offset

The **WCS offset** shifts the work origin so the mark lands where the part actually is. It's stored
**per lens**. Set it from the lens's **WCS** control (it opens the Corrections dialog for the active lens).

The canvas origin (0,0) **is** the WCS reference point: artwork placed at 0,0 marks at the work origin,
and moving art +20 in X marks +20 from that origin. The offset itself applies only when marking and
tracing — changing it never moves artwork on the canvas.

## Focal height (Z) per lens

Each lens has a focal working distance. Set it on **Jog ▸ Lens Offset**:

1. **Jog Z** to the optimum focal distance.
2. Enter an **Offset** (the distance between the baseboard and the top of your test material).
3. Click **Save Z** to commit the focal distance + offset to the active lens.

> The Offset can be updated later without re-finding the focal distance.

Then **Home & Jog to Lens 0** (on the Jog card) gets you straight back to focus for that lens.

### Finding focus: the Z Focus Test

The **Z Focus Test** ([Sequencer](sequencer.md) ▸ Calibration) finds the optimum focal height empirically:
it marks a row of numbered tick marks, stepping the Z height between marks — the sharpest mark is your
focal height.

1. Add a **Z Focus Test** action. In **Setup**, set the number of **5-Mark Groups**, **Mark Spacing**,
   **Mark Height**, and **Label Height** — the pattern on the canvas updates as you type.
2. On the sublayer, set the Z **Distance** per mark and pick the mode: **Auto** (FocuZ jogs Z between
   marks — needs the FocuZ:grbl controller connected and Z homed) or **Manual** (FocuZ prompts you to move
   Z between marks yourself).
3. **Run**, then inspect the part for the sharpest, cleanest line.
4. **Auto** — enter that mark's number when prompted and FocuZ jogs straight down to its focal height;
   save it to the active lens via **Lens Offset**. **Manual** — move Z down by that many of your steps,
   then save the same way.

## Aligning the mark to the part

- **Calibration ▸ Offset** (a [Sequencer](sequencer.md) action) lets you mark or trace a target, drag it on
  the canvas to where it actually landed, and apply the difference as the work offset. The layer header's
  **Apply Offset (Lx)** button names the currently selected lens right in its label, so you can see whose
  offset will be updated before you click. The **Return to 0,0** checkbox next to it (on by default) snaps
  the target back to the design origin after applying — with the drag absorbed into the offset, that's
  where it now marks, so a re-trace lands on the same spot on the material. Untick it to keep the target
  where you dragged it instead.
- **Red Light Trace** (Device menu, or the **Red Light** button at the bottom of the Corrections
  dialog) helps align the red pointer to where the IR beam fires (they have a small fixed parallax).
  The red-light **offset, scale, and trace speed are stored per lens** — like the other corrections
  here, they apply to the lens named when you open it — while repeats and durations are
  device-wide. The window is organized into **Calibration** (red light toggle, per-lens offset,
  scale, and speed), **Locate** (move the pointer to a position or the field center), and **Timing**. An
  **Import markcfg7** button at the top loads a file's red-light offset, scale, and speed into the
  boxes — nothing commits until **Save**.

!!! warning "Per-lens actions confirm the target lens"
    Actions that change per-lens calibration apply to the **currently selected lens** and confirm which lens
    before applying — double-check it's the right one to avoid mis-calibrating another lens.

## See also

- [Hardware & Device Setup](hardware-setup.md) · [First-run setup](getting-started/first-run.md)
- [Jog, Homing & Terminal](jog-terminal.md) · [Troubleshooting & FAQ](troubleshooting.md)
