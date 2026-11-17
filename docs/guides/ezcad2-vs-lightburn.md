---
description: "EZCad2 vs LightBurn for BJJCZ fiber lasers: cost, operating systems, drivers, machine setup, design tools, 3D relief and multiple lenses compared, and where FocuZ fits."
---

# EZCad2 vs LightBurn for BJJCZ fiber lasers

**Short answer:** EZCad2 is the free software that comes with most BJJCZ (Beijing JCZ) fiber lasers. It
is already set up for your machine, but it is dated and 2D-only. LightBurn is a paid, modern
program for Windows and macOS with much stronger design tools, and the same program also runs CO2
and diode lasers. Both drive the same BJJCZ board, so moving between them is only a USB driver change. FocuZ
is a third option: it slices 3D models directly and gives you finer control of the BJJCZ board, to engrave
(ablate) or color (anneal) materials in ways other software can't, with no fixed number of layers or
sublayers.

Put simply, LightBurn is the Swiss Army knife of laser software, built to work with many
different laser systems, and it includes a drawing suite. FocuZ is the scalpel: designed specifically for BJJCZ (EZCad2-based) fiber laser
systems, with unique marking features and a higher level of functionality.

This comparison covers fiber lasers with a BJJCZ (EZCad2-based) controller board. Not sure which board yours
has? See [Does my fiber laser have a BJJCZ board?](does-my-fiber-laser-have-a-bjjcz-board.md).

## At a glance

| | EZCad2 | LightBurn | FocuZ |
|---|---|---|---|
| **Cost** | Free with the laser | LightBurn Pro (covers galvo lasers): $199 one-time, 3 computers, a year of updates, 30-day free trial | Pay once: <span data-fz-price="license">$139</span> one-time, 3 computers, a year of updates, 30-day free trial |
| **Operating system** | Windows | Windows and macOS (Linux support ended after version 1.7) | Windows 10 or later (64-bit) |
| **Lasers** | BJJCZ boards only | Galvo lasers plus CO2, diode and DSP machines | BJJCZ fiber galvo boards |
| **USB driver** | Its own vendor driver | Swapped in by the LightBurn installer (Zadig and WinUSB as a fallback) | WinUSB, installed with Zadig; LightBurn can use it too |
| **Machine setup** | Done by the vendor, stored in markcfg7 | Manual, or Find My Laser, which can then import the vendor's markcfg7 | Device Setup Wizard: import the device settings once, then each lens's markcfg7 into its own lens slot |
| **Design tools** | Basic. Some imports need older file versions (for example, AI files saved as Illustrator 8 or earlier) | Strong: text, shapes, node editing, offsets, arrays | Use your favorite drawing or 3D modeling program: imports SVG, DXF, AI, EPS and PDF at true size, and STL, OBJ, STEP and 3MF models |
| **3D relief** | No 3D model import | 3D Sliced image mode. STL files can be imported, but LightBurn slices a grayscale depth map made from the model, not the model itself | Slices STL, OBJ, STEP and 3MF models directly, from their true geometry |
| **Several lenses** | Usually one EZCad2 copy per lens | A separate device profile per lens | Up to eight lens profiles in one install for easy lens switching |
| **How a job is built** | Objects on a page, each with a pen | Objects on up to 30 layers (plus 2 tool layers that don't mark), each with up to 11 sub-layers of settings | An ordered sequence of actions, with no fixed number of layers or sublayers |

!!! note "Prices and features as of November 2026"
    This comparison reflects each program at the time of writing (LightBurn 2.2). Prices and features are
    subject to change, so check each vendor's site for the latest.

## EZCad2

**Good at:**

- It costs nothing and is already configured. The vendor sets up your laser, galvo and lens in its
  markcfg7 file before the machine ships.
- It is the reference software for BJJCZ boards, so every board feature works in it.

**Limits:**

- Mostly unsupported. Updates are rare: a new driver arrived recently, after many years without changes.
- A dated interface, often with a rough translation.
- Known memory problems on large jobs, especially with many filled layers.
- 2D only. There is no 3D model import, so relief work means grayscale images and trial and error.
- Each lens usually needs its own copy of EZCad2 with its own markcfg7.
- Some imports need older file versions, for example AI files saved as Illustrator 8 or earlier.
- It uses a vendor driver that LightBurn and FocuZ can't use, so switching away needs a one-time driver
  swap.

## LightBurn

LightBurn was the step up from EZCad2 in design and ease of use, and it has kept adding features since.

**Good at:**

- Design and layout: text, shapes, node editing, offsets and arrays in the same program that runs the
  laser.
- A modern interface, with better memory handling than EZCad2.
- One program for every laser you own: galvo, CO2, diode and DSP machines.
- Runs on Windows and macOS.
- A large user community, forum and library of tutorials.

**Limits:**

- Relief is depth-map based, even when you import an STL. LightBurn makes a grayscale depth map from the
  model and slices that, not the model itself. That is less accurate than slicing the 3D model directly:
  edges lose clarity, and you have less control over Z depth. See
  [Staircase lines in fiber laser relief engraving: slicing vs depth maps](relief-engraving-slicing-vs-depth-maps.md).
- Up to 30 layers, each with up to 11 sub-layers.
- Each lens is a separate device profile, so changing lenses means switching profiles.
- Its Material Library saves one layer's settings per entry (with its sub-layers) and applies the entry to
  a layer as a whole.
- Its Preview's time estimate comes from simulation speeds you enter in Device Settings, so it can be off
  until you tune them.

## Where FocuZ fits

If LightBurn was the step up from EZCad2 in design, FocuZ is the next step in marking. It strips laser
software back to its core and rebuilds it specifically for BJJCZ (EZCad2-based) fiber lasers, 3D from
the ground up:

- **Slices the model itself.** Import STL, OBJ, STEP or 3MF and FocuZ cuts it into marking layers from its
  true geometry, with no depth map in between. If a model isn't watertight, FocuZ offers to repair it on
  import. Place each model at its own Z height. Every slice is the model's exact outline at its height,
  so the slices stay exactly in step with each other. You set the slice count, so smoothness comes from
  your settings, not a depth map's gray levels.
- **More fill patterns.** Unidirectional, Bidirectional, Cross, Snake, Contour (a ring fill
  with cleaner paths than EZCad2's ring) and Thatch, a tiled weave, plus Wobble on cut bands. See
  [Fill types](../sequencer.md#fill-types).
- **Fill variation.** Vary power, speed or frequency (or Q-Pulse, if your laser offers pulse width) along
  a fill for color gradients, test ramps or texture. See
  [Variation](../sequencer.md#variation).
- **Jobs as a sequence.** A job is an ordered list of actions, not a fixed set of layers: mark, slice, move
  a rotary or pause, run top to bottom with repeats. The Sequencer shows the job's estimated time as you
  build it. See [The Sequencer](../sequencer.md).
- **Many-layer art, a recipe for each layer.** Import a file with many layers, keep them separate, and
  give each layer its own marking: color marking on one, deep engraving on the next, with no fixed limit
  on how many. Save any proven recipe, or a single test-grid square, to the
  [Settings Library](../library.md), then load it onto a layer in one step, with every setting included:
  speed, power, frequency, fill type, line spacing, angle and the rest. It's like color by numbers, except
  instead of grabbing the crayon that matches the number, you load the settings from the Library that
  match the layer. A template can hold one action or a whole job, you can compare it side by side with
  your job and copy every setting or only the ones you pick, and you can lock a proven template. Or start
  from a project you know works and just add art. No copying numbers by hand or
  from a photo of the screen.
- **A Preview that follows the real job.** The Preview plays the job back in the order it marks, with
  every pass, sublayer and repeat. On a rotary job it steps through the splits one at a time, showing
  exactly the strip the galvo will see. The time estimate learns your machine: each finished job adjusts
  later estimates to match how long the marking really took. See [Marking & Tracing](../marking-tracing.md).
- **Test grids that mark the way you will.** Each grid square marks every layer in turn, stacked exactly
  as in your real job, with a sweep for any (or all) marking parameters. See [The Test Grid](../test-grid.md).
- **Rotary without surprises.** Splits are always equal, so there's never a thin leftover strip, and every
  seam is placed to the nearest motor step. Backlash compensation and arc compensation are built in, and
  the 2D Grid action hides seams by making them lines of a checkerboard pattern. See
  [Rotary Marking](../rotary.md).
- **Machine and lenses kept apart.** The Device Setup Wizard imports the device settings once, then each
  lens's markcfg7 into its own lens slot: field size, correction and work offset. Up to eight lenses live
  in one install, each with its own corrections, offsets and focus height, and switching lenses is a
  single pick from the lens button. See [Lenses, Corrections & Calibration](../lenses-corrections.md).

And more: see the [Overview](../index.md).

FocuZ doesn't try to be a drawing program. Design in the program you already know, whether that's a
drawing program, a CAD program or a 3D modeling program, and import the result: SVG, DXF, AI, EPS or PDF
for 2D art, and STL, OBJ, STEP or 3MF for 3D models. LightBurn works for this too. LightBurn can use
FocuZ's WinUSB driver, so you can design in LightBurn, export SVG or DXF, and mark it in FocuZ with no driver
change in between. Only one program can hold the USB connection at a time, so close one before
connecting from the other.

## Which one should you use?

- **Stay with EZCad2** if it does what you need and you only mark simple 2D work. It's free and already
  set up.
- **Choose LightBurn** if you want design tools included, run other kinds of lasers too, or work on a Mac.
- **Choose FocuZ** if you engrave 3D relief from models, use several lenses, or run multi-step jobs.

## Switching between them

- **From EZCad2 to LightBurn or FocuZ:** swap the driver once. LightBurn's installer can do it for
  LightBurn; for FocuZ, switch to WinUSB with Zadig. Full steps:
  [USB LMCV4 driver for Windows 11 & 10](https://lokahi.shop/pages/driver-installation).
- **Between LightBurn and FocuZ:** no driver change. Close one program before connecting from the other.
- **Back to EZCad2:** restore EZCad2's vendor driver. See
  [Switching from EZCad2 or LightBurn](switching-from-ezcad2-or-lightburn.md).
- **Keep your markcfg7 files.** They are your vendor's settings and your way back to EZCad2. See
  [What is markcfg7?](what-is-markcfg7.md).
- **Moving between programs often?** FocuZ loads its own correction settings onto the controller every
  time it connects, so switching to FocuZ needs only a reconnect. When switching to EZCad2 or LightBurn,
  power-cycle the controller first, so that program starts from its own settings.
  See [Troubleshooting & FAQ](../troubleshooting.md).

## Related

- [Switching from EZCad2 or LightBurn](switching-from-ezcad2-or-lightburn.md)
- [What is markcfg7?](what-is-markcfg7.md)
- [Does my fiber laser have a BJJCZ board?](does-my-fiber-laser-have-a-bjjcz-board.md)
- [Staircase lines in fiber laser relief engraving: slicing vs depth maps](relief-engraving-slicing-vs-depth-maps.md)
