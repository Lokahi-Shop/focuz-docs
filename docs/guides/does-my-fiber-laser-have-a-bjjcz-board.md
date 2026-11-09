---
description: "How to tell whether your fiber laser has a BJJCZ (EZCad2-type) controller board — the software it shipped with, Windows Device Manager and the board label — and which boards FocuZ is tested on."
---

# Does my fiber laser have a BJJCZ board?

**Short answer:** if your fiber laser shipped with **EZCad2**, or runs from LightBurn in Galvo mode over
USB, it very likely has a BJJCZ (Beijing JCZ) controller board. Most sellers don't name the board, so
check the laser itself.

## Three ways to check

1. **The software it came with.** EZCad2 runs only on BJJCZ boards. If you have an EZCad2 folder with a
   `plug` folder holding a `markcfg7` file, you have one.
2. **Windows Device Manager.** With the laser on and plugged in, look for a **BJJCZ Device** category
   near the top of the list — the board sits under it (for example *Laser Mark Control Board V4 [USB]*).
   If the laser has been set up for LightBurn or FocuZ, it shows under *Universal Serial Bus devices* as
   **USBLMCV2** or **USBLMCV4** instead.

    ![Device Manager showing the BJJCZ Device category with Laser Mark Control Board V4 [USB] under it](../assets/device-manager-bjjcz.png)

3. **The board label.** Inside the controller box, the board is usually labeled **LMCV4-FIBER-M**,
   **FBLI-B-LV4** or similar.

## Which boards FocuZ runs

- **Tested:** the Lite boards **LMCV4-FIBER-M** and **FBLI-B-LV4**.
- **Should work, untested:** the Standard board **LMCV4-FIBER** (without the -M; some sellers list it as
  "FBLMCB-V4"). A motorized Z works through a FocuZ-compatible Z controller, not this board's own Z axis.
- **Fiber laser sources only.**

## Next steps

- The free 30-day trial has every feature. Connect the laser and FocuZ shows the board's firmware version
  and serial number.
- [Switching from EZCad2 or LightBurn](switching-from-ezcad2-or-lightburn.md)
- [Installation & driver](../getting-started/installation.md)
