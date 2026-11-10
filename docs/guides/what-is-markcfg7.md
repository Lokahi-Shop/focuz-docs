---
description: "markcfg7 is EZCad2's file for your fiber laser's current settings, usually set up by the vendor. What's in it, where to find it, how to check the vendor's calibration, and how FocuZ uses it."
---

# What is markcfg7? EZCad2's machine configuration file

**Short answer:** `markcfg7` is EZCad2's file for your laser's current settings. It lives in EZCad2's
**plug** folder. Your vendor usually sets it up before the machine arrives. If your machine came with more
than one lens, each lens usually has its own working copy of EZCad2, with its own `markcfg7`.

The file always holds EZCad2's latest settings: if you've changed anything in EZCad2, your `markcfg7`
includes those changes.

## What's in it

- **The laser:** laser type, frequency and speed limits, power map
- **The galvo:** which galvo drives X and Y, and their directions
- **The lens:** field size, field angle, distortion correction and the work offset
- **Extras:** red-light pointer settings, the rotary axis and I/O port assignments

## Check the vendor's settings

The vendor's values are a starting point. Compare the `markcfg7` from each lens's copy of EZCad2. If the
correction values are all the same and only the field size changes, your vendor probably didn't calibrate
each lens. To confirm the settings, or to dial them in further, run your own calibration:

- **Lens correction:** make a `.cor` file for your lens, then load it in
  [Corrections](../lenses-corrections.md#distortion-correction-the-corrections-dialog).
- **Focus height:** run the [Z Focal Distance test](../lenses-corrections.md#finding-focus-the-z-focal-distance)
  to find your lens's best Z height.
    - **Manual lift:** if the result is different from the vendor's height, make a new height stick or
      measurement, or record and set the height your preferred way.
    - **Motorized Z run by FocuZ:** save the Z height and your test material's offset to that lens. FocuZ
      returns to it whenever you pick the lens, and when you change fixtures, updating the offset is all
      that's needed.

## Using it in FocuZ

EZCad2 keeps everything in one file for the whole machine, but that file holds only one lens. FocuZ splits it into machine settings and lens
settings, and the **Device Setup Wizard** walks you through both. It opens on first launch, and any time
from **Device ▸ Device Setup Wizard**.

1. **Device Setup: import any lens's `markcfg7`.** Every EZCad2 copy that came with your lenses is set up
   for the same machine, so any one works. This sets the laser, galvo, red light, power map and rotary
   for the machine.
2. **Lens Setup: import each lens's own `markcfg7`.** Pick a lens, give it a label (for example "174"),
   click **Corrections…** and use **Choose markcfg7…** to import the file from that lens's copy of EZCad2.
   This brings in its field size, correction and work offset. Pick the next lens and repeat.

To change one setting later, you don't need to run the whole wizard again. **Laser Setup**, **Lens
Corrections**, **Rotary Setup**, **Trace Settings** and **Power Map** in the **Device** menu each have
their own **Import markcfg7** button. That's useful for going back to an original setting for one section
without overwriting the others.

Changing lenses? See
[Changing lenses on a fiber laser](fiber-laser-lens-change-per-lens-calibration.md).

## Keep a copy

- **Your `markcfg7` files:** keep a copy of each lens's file. They're your way back to EZCad2 or other
  software.
- **Your vendor's originals:** vendors may supply a zipped copy of EZCad2 on a USB stick with your laser.
  Keep it: its `markcfg7` files are a good way back to the original vendor settings, even after you've
  changed things in EZCad2.
- **Your FocuZ setup:** **Device ▸ Export All Settings…** saves your whole setup in one `.focuzsettings`
  file. That includes **every lens's** corrections, WCS offset, focus height and `.cor` copy, so one export
  covers them all. Your Library and your projects aren't included, so back those up separately. See
  [Backing up and moving your setup](../hardware-setup.md#backing-up-and-moving-your-setup-device-export-import-all-settings).

## Related

- [Hardware setup](../hardware-setup.md)
- [Switching from EZCad2 or LightBurn](switching-from-ezcad2-or-lightburn.md)
- [Lenses, Corrections & Calibration](../lenses-corrections.md)
