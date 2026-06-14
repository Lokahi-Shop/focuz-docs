# Lenses, Corrections & Calibration

FocuZ keeps correction and focus settings **per lens** (L1–L8), so you can switch lenses without
re-tuning. This section covers selecting a lens, distortion correction, the work-coordinate offset, focal
height, and alignment.

!!! info "This page is being written"
    The outline below is what it will cover. In the meantime, the
    [first-run setup](getting-started/first-run.md) walks through configuring a lens, and
    [Hardware & Device Setup](hardware-setup.md) covers device-level settings.

## What this page will cover

- **Lens management** — selecting the active lens (L1–L8), per-lens settings, lens activation and the
  homing prompt.
- **The Corrections dialog** — the two correction modes:
    - **`.cor` file** — load the lens map EZCad2/LightBurn use; optional fine-tune scale + angle.
    - **Manual** — scale, angle, per-lens field size, and bulge / parallel / trapezoidal correction.
- **WCS (work coordinate) offset** — per-lens origin offset so the mark lands where the part is.
- **Z focal height & Z offset** — setting the in-focus working distance per lens (Jog ▸ Lens Offset).
- **Calibration ▸ Offset** — a sequencer action to align the mark to the part by dragging on the canvas.
- **Red-Light Trace alignment** — compensating for the parallax between the red pointer and the IR beam.

## See also

- [First-run setup](getting-started/first-run.md) · [Hardware & Device Setup](hardware-setup.md)
- [Jog, Homing & Terminal](jog-terminal.md) · [Troubleshooting & FAQ](troubleshooting.md)
