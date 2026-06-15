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

Open **Corrections** (from the [setup wizard](getting-started/first-run.md) or the lens controls). It has
two modes for correcting galvo/lens distortion, and remembers settings per lens:

=== "`.cor` file (recommended)"

    Load the **`.cor`** correction file your lens uses — the same file format EZCad2 and LightBurn use. The
    file supplies the distortion map and field size. You can optionally fine-tune **Scale** and **Angle** on
    top of it. (Manual-only fields are greyed out while a `.cor` is loaded.)

=== "Manual"

    With no `.cor`, enter correction values directly:

    - **Scale X/Y** and **Angle**
    - per-lens **Field size X/Y** (mm)
    - **Bulge**, **Parallel**, and **Trapezoidal** correction (X/Y)

!!! tip "Round at center, distorted at the edges?"
    That's a distortion-correction issue — load the correct `.cor` for the lens, or tune the manual values.
    See [Troubleshooting](troubleshooting.md).

## WCS (work coordinate) offset

The **WCS offset** shifts the work origin so the mark lands where the part actually is. It's stored
**per lens**. Set it from the lens's **WCS** control (it opens the Corrections dialog for the active lens).

## Focal height (Z) per lens

Each lens has a focal working distance. Set it on **Jog ▸ Lens Offset**:

1. **Jog Z** to the optimum focal distance.
2. Enter an **Offset** (the distance between the baseboard and the top of your test material).
3. Click **Save Z** to commit the focal distance + offset to the active lens.

> The Offset can be updated later without re-finding the focal distance.

Then **Home & Jog to Lens 0** (on the Jog card) gets you straight back to focus for that lens.

## Aligning the mark to the part

- **Calibration ▸ Offset** (a [Sequencer](sequencer.md) action) lets you mark or trace a target, drag it on
  the canvas to where it actually landed, and **Apply** the difference as the work offset.
- **Red Light Trace** (Device menu) helps align the red pointer to where the IR beam fires (they have a
  small fixed parallax) and set the red-light offset and trace speed.

!!! warning "Per-lens actions confirm the target lens"
    Actions that change per-lens calibration apply to the **currently selected lens** and confirm which lens
    before applying — double-check it's the right one to avoid mis-calibrating another lens.

## See also

- [Hardware & Device Setup](hardware-setup.md) · [First-run setup](getting-started/first-run.md)
- [Jog, Homing & Terminal](jog-terminal.md) · [Troubleshooting & FAQ](troubleshooting.md)
