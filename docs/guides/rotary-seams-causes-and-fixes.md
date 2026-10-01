# Rotary seams on a fiber laser: causes and fixes

A galvo lens can only mark a small window of a cylinder at a time, so rotary jobs are marked in
**splits**: mark one strip, turn the part, mark the next. The line where two splits meet is a **seam**.
A good seam is invisible; a bad one shows as a gap, an overlap, a sideways jog, or a raised ridge.
Each of those has a different cause.

## Match the symptom to the cause

| What you see at the seams | Most likely cause | Fix |
|---|---|---|
| The pieces on either side don't belong together — the art looks scrambled | The part turns the **wrong way** | Toggle **Invert direction** in Rotary Setup |
| A small step along the circumference at every seam, all the same way, and a gap or overlap where the wrap closes | **Part diameter** (or steps per revolution / gear ratio) doesn't match the real part | Measure the part and correct **Part Diameter**; check the motor settings |
| A sideways shift along the part's length that grows from one end | The rotary axis isn't parallel to the field | Re-square the rotary on the table |
| The first seam is off but the rest are fine | Gear or chuck backlash | Turn on **Backlash compensation** |
| A raised ridge of material on both sides of each seam, even with perfect alignment | Fill **line ends** stacking at the seam | Change the fill angle — see below |
| Doubled, darker outlines at seams | Outlines marked by both splits | Set **Outlines at seams** to **Exact seam** |

## Ridges at the seams: line ends, not alignment

A seam is where fill lines **end**. Line ends are where a galvo mark puts the most heat — the beam slows,
the laser switches off, and the melt pool is pushed ahead of it — and at a seam both neighbouring splits
end there, so the effect doubles into a visible bead.

- **Change the fill angle.** A fill running straight into the seam ends every line at the same place. At
  **45°** the ends are spread along the seam and the bead usually disappears.
- **Check the laser off delay.** Too long a delay burns every line end; seams show it first.
- **Measure the diameter with calipers.** The part diameter sets how far the part turns between splits,
  so an error shows at every seam and adds up around the part: the wrap closes short or long by π × the
  diameter error — 0.1 mm off on the diameter leaves about 0.31 mm at the closing seam. Measure with
  calipers where the art will be marked, at a few points around the part, and enter what you measure
  rather than the nominal size. With an accurate diameter and Z height, the splits meet exactly and no
  overlap is needed.

## How FocuZ keeps seams consistent

- **Equal splits.** Set the **number of splits per revolution** and every split is exactly the same
  width — there's no short leftover strip at the end, and splits that hold no art are skipped.
- **Seams placed to the motor step.** Every split is commanded to the nearest motor step, so a seam is
  never more than one step from ideal. When the split count divides the motor's steps per revolution,
  every advance is identical and the readout says **exact**.
- **Backlash-safe approach.** With **Backlash compensation** on, each revolution approaches its first split
  from the same side as every later advance, so lash never lands in a seam. Turn it on for any rotary that
  shows lash, however small — it adds only a short move per revolution.
- **Seam-aware splits** (optional) move seams into gaps in the artwork where there are any.
- **Outlines at seams** — choose **Exact seam**, a small **Stitch** past the seam, or share the **Overlap**.
- **Arc compensation** (on by default — keep it on) corrects the curvature across each split, so
  distances on the part match the design right up to the seam.

Or use the seams on purpose: the **[2D Grid action](../rotary.md#the-2d-grid-action)** divides every split
into a checkerboard of cells, so the seams become lines of the pattern.

## Related

- [Rotary Marking](../rotary.md) — setup, split settings and the rotary actions
- [Previewing splits](../rotary.md#previewing-splits)
