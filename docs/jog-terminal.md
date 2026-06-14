# Jog, Homing & Terminal

Manual axis control, homing, and a raw command terminal — available from the **Jog** and **Terminal**
menus.

!!! info "This page is being written"
    The outline below is what it will cover.

## What this page will cover

- **Jog** — homing (per-axis and Home All), the **axis Enable** checkboxes, **position display**
  (MPos / LPos) and limit-switch status, and manual jogging (distance, speed, jog buttons, nudge).
- **Home & Jog to Lens 0** — homing then moving to the active lens's saved focal position.
- **Terminal** — sending raw GRBL commands and reading responses.

## How jogging behaves (important)

FocuZ's motion control (GRBL) is **open-loop** and **queues** jog commands:

- Clicking a jog button several times runs the jogs **consecutively** — each click queues another move.
- A move is "complete" when the controller reports **Idle**, not when the axis is confirmed to have
  physically arrived. With no encoder, a stall or a disabled driver is **not** detected.
- Positional confidence comes from **homing** (hitting the limit switch), not from per-move confirmation.

## See also

- [Hardware & Device Setup](hardware-setup.md) · [Lenses, Corrections & Calibration](lenses-corrections.md)
- [Troubleshooting & FAQ](troubleshooting.md)
