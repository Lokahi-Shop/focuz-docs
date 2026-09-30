# Switching a BJJCZ fiber laser from EZCad2 or LightBurn to FocuZ

**Short answer:** FocuZ runs the same BJJCZ (JCZ) galvo controller you already have — no new board. If
the laser currently runs from LightBurn, the USB driver is already the right kind; if it runs from EZCad2,
you switch the driver to WinUSB once with the free Zadig tool. Then import your EZCad2 `markcfg7` file
and your lens correction, and FocuZ is set up.

## 1. The USB driver

FocuZ talks to the controller through a **WinUSB** driver.

- **Coming from LightBurn:** LightBurn uses WinUSB too, so there's nothing to install. Close LightBurn
  first — only one program can hold the controller at a time.
- **Coming from EZCad2:** EZCad2 installs its own vendor driver. Replace it with WinUSB using Zadig,
  selecting the device with USB ID **`9588:9899`** — the full steps are in
  [Installation & driver](../getting-started/installation.md#2-install-the-bjjcz-usb-driver).

!!! note "Going back to EZCad2"
    EZCad2 needs its own driver. To use EZCad2 again on the same PC, reinstall its vendor driver in place
    of WinUSB.

## 2. Bring your settings across

- **Device settings:** import your EZCad2 **`markcfg7`** file (it lives in EZCad2's `plug` folder). One
  import sets up the device-wide values — see
  [Hardware & Device Setup](../hardware-setup.md).
- **Lens correction:** import your existing **`.cor`** correction file for each lens — see
  [Lenses, Corrections & Calibration](../lenses-corrections.md).
- **Rotary:** if you use a rotary, its motor settings come from the same `markcfg7` import.

## 3. The main difference: jobs are a sequence

EZCad2 and LightBurn place objects on a page and give each one a pen or layer. FocuZ builds a job as an
ordered **sequence of actions** — mark this 2D art, slice that 3D model, move a rotary, pause — run top
to bottom, with repeats and per-pass steps. See [How FocuZ works](../index.md#how-focuz-works) and
[The Sequencer](../sequencer.md).

!!! tip "Moving between programs"
    EZCad2 and LightBurn load their own settings into the controller. If you go back and forth,
    power-cycle the controller when switching, so each program starts from its own settings — see
    [Troubleshooting & FAQ](../troubleshooting.md).

## 4. First mark

Follow [Your first mark](../getting-started/your-first-mark.md): import simple art, trace it, and mark.

## Related

- [Troubleshooting & FAQ](../troubleshooting.md)
- [Support](../support.md)
