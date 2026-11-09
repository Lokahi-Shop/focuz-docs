---
description: "Can a fiber laser engrave an STL file? Slicing the model directly vs converting it to a depth map — accuracy, depth control and a faster path from 3D model to mark."
---

# Can a fiber laser engrave an STL file? True slicing vs a depth map

**Short answer:** yes. Most software turns the model into a grayscale depth map first and marks the
image. FocuZ slices the model itself — no depth map image in between.

## Why slicing

- **Accurate in X, Y and Z.** Every slice is the model's exact outline at that height — no pixel grid,
  no gray levels.
- **Depth you control.** Measure how much material one slice removes, set slices per mm from it, and
  the model's depth is the depth you mark.
- **Quality you choose.** The result comes down to your settings and the number of slices — not a gray
  value's estimation or the resolution of an image.
- **What you see is what you get.** The model on screen is what marks, and it's easy to place — in X and
  Y, and in Z too.
- **Faster to the mark.** Import STL, OBJ, 3MF or STEP and mark — no depth map to make. Make a model from
  an image or text in a tool like Meshy, bring it straight into FocuZ, and engrave.

## See the difference

The free [Slice vs Depthmap comparison tool](https://compare.lokahi.shop) shows the same model both ways,
side by side.

## Related

- [Engraving STL and STEP models](engraving-stl-step-models.md)
- [Staircase lines: slicing vs depth maps](relief-engraving-slicing-vs-depth-maps.md)
