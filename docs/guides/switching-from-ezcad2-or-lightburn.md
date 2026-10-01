# Switching a BJJCZ fiber laser from EZCad2 or LightBurn to FocuZ

**Short answer:** FocuZ runs the same BJJCZ (JCZ) galvo controller you already have — no new board. If
the laser currently runs from LightBurn, the USB driver is already the right kind; if it runs from EZCad2,
you switch the driver to WinUSB once with the free Zadig tool.

## 1. The USB driver

FocuZ talks to the controller through a **WinUSB** driver.

- **Coming from LightBurn:** LightBurn uses WinUSB too, so there's nothing to install. Close LightBurn
  first — only one program can hold the controller at a time.
- **Coming from EZCad2:** EZCad2 installs its own vendor driver. Replace it with WinUSB using Zadig,
  selecting the device with USB ID **`9588:9899`** — the full steps are in
  [Installation & driver](../getting-started/installation.md#2-install-the-bjjcz-usb-driver).

!!! note "Going back to EZCad2"
    EZCad2 needs its own vendor driver, so the WinUSB driver (the one FocuZ and LightBurn share) has to be
    removed first:

    1. With the controller plugged in, open **Device Manager** and find the controller (look under
       *Universal Serial Bus devices* — it may show as *USBLMCV2*, *USBLMCV4* or *jczMod2*).
    2. Right-click it › **Uninstall device**, tick **Attempt to remove the driver for this device**
       (*Delete the driver software for this device* on older Windows), and confirm.
    3. Choose **Action › Scan for hardware changes**, or unplug and replug the controller.
    4. Install EZCad2's own driver (from its driver folder), then start EZCad2.

    Coming back to FocuZ later is just the Zadig step again.

## 2. First-time setup

If this is the first time FocuZ has run on this PC, the **Device Setup** window opens on launch and walks you
through importing your EZCad2 `markcfg7` and lens correction — see [First-run setup](../getting-started/first-run.md).

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
