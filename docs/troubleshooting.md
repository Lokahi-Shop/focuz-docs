# Troubleshooting & FAQ

Common issues and how to resolve them. If something isn't here, see [Support](support.md).

## Connection

**The galvo controller isn't detected.**

- Check the USB cable and that the controller is powered.
- Open **Device ▸ Connection** and click **Refresh**.
- If it's plugged in but not listed, install the WinUSB driver with Zadig (USB ID `9588:9899`) — see
  [Installation & driver](getting-started/installation.md).

**The FocuZ:grbl controller (motion/accessories) isn't responding.**

- Confirm it's connected; FocuZ detects it on connect. Jog/homing/accessory steps need it.
- Use the [Terminal](jog-terminal.md#terminal) to send a status query and confirm it replies.

## "Device not configured" / Run is blocked

Import a **`markcfg7`** via [Device Setup](getting-started/first-run.md) — Run and Trace stay
blocked until the device is configured.

## Marking quality & placement

**Marks come out rotated or mirrored.** Check the galvo **X/Y assignment** and mirror toggles in
[Hardware & Device Setup](hardware-setup.md) (re-importing the correct `markcfg7` usually sets these).

**Shapes are round at center but distorted toward the edges.** That's distortion correction — load the
correct **`.cor`** for the lens or tune the manual values in
[Lenses, Corrections & Calibration](lenses-corrections.md).

**Marks are weak or out of focus.** Check power / speed / frequency, and set the lens **focal Z height**
(see [Lenses, Corrections & Calibration](lenses-corrections.md#focal-height-z-per-lens)).

**The mark is offset from where the part is.** Set the per-lens **WCS offset** or use **Calibration ▸
Offset** to drag-align it.

## Motion & axes

**An axis won't move / "alarm" after a limit hit.** The FocuZ:grbl controller loses an axis's homed status
on an alarm. Clear the alarm and **re-home** the axis (Jog card). Position confidence comes from homing —
see the [open-loop note](jog-terminal.md#manual-jogging).

**Air assist / vacuum won't switch.** These run off the controller's [accessory relays](jog-terminal.md#accessory-relays-air-vacuum-more).
Test the output from the **Terminal** first, and confirm the M-code matches how that relay is wired.

## Licensing

Activation or renewal trouble: see [Updates & Licensing](updates-licensing.md). For offline machines, use
offline activation.

## Getting more detail

FocuZ keeps a **log** (see [Reference](reference.md#file-settings-locations) for its location) — include it
when you contact [Support](support.md).
