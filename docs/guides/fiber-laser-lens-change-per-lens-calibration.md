---
description: "Swap f-theta lenses on a fiber laser without recalibrating: FocuZ keeps field size, correction, work offset and focus height per lens, separate from the laser's own settings."
---

# Changing lenses on a fiber laser: per-lens calibration

**Short answer:** a lens changes how big your field is, how it distorts, where its center sits and how high
it focuses. The laser source doesn't change when you swap lenses. FocuZ keeps those two sets of settings
apart, so each lens keeps its own calibration and changing lenses is a single pick.

## What belongs to the lens

Each of up to eight lenses (L1–L8) carries its own:

- **Field size and correction:** a `.cor` file or manual values
- **WCS offset:** where that lens's 0,0 lands on the bed
- **Focus height:** with a motorized Z run by FocuZ, the lens keeps its saved Z and material offset, and
  when you change fixtures, updating the offset is all that's needed. With a manual lift, record the
  height for each lens.

## What belongs to the machine

These stay the same whichever lens is on: the laser source, galvo wiring, speed and frequency limits,
timing defaults, red light and power map.

## Why it matters

- **Calibrate each lens on its own terms.** Tuning your 174 mm lens never disturbs your 110 mm lens.
- **Make your lenses agree.** Set each lens's WCS offset so 0,0 lands on the same spot, and its field
  size so 50 mm marks 50 mm. A design placed for one lens then lands in the same place with another.
  See [Matching two lenses](#matching-two-lenses).
- **Simple switching.** Pick the lens from the lens button. Its correction and work offset come with it,
  and with a motorized Z the Lens change card offers to move Z to that lens's saved focus height.

## Setting up each lens

In the **Device Setup Wizard**, import any one `markcfg7` under Device Setup. Then, under Lens Setup, pick
each lens, open **Corrections…** and import the `markcfg7` from that lens's own copy of EZCad2 (or load its
`.cor`). One **Export All Settings** then backs up every lens.

## Fine-tuning a lens

For fine-tuning, add **Scale** and **Angle** in the lens's
[Corrections](../lenses-corrections.md#distortion-correction-the-corrections-dialog). With a `.cor` file
loaded, these are applied after the `.cor` file's corrections.

## Matching two lenses

1. Set up a `.cor` file on each lens, the larger and the smaller.
2. With the **smaller** lens, lightly engrave a square about as large as its field.
3. Switch to the **larger** lens and raise Z to its best focus height for the test piece.
4. Cover the engraved square with a marker.
5. Add a [**Calibration ▸ Offset**](../lenses-corrections.md#aligning-the-mark-to-the-part) action and mark a
   square of the same size, with the power just high enough to remove the marker but not engrave the path.
6. Adjust the larger lens to match: the **WCS offset** for position, and **Scale** and **Angle** if the
   squares differ in size or rotation. Mark again until the squares line up.

## Related

- [Lenses, Corrections & Calibration](../lenses-corrections.md)
- [What is markcfg7?](what-is-markcfg7.md)
