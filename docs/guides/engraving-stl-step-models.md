# Engraving STL and STEP models on a galvo fiber laser

**Short answer:** in FocuZ, add a **3D Slice** action, import the model (STEP, STL, OBJ or 3MF), size and
place it, choose how many slices, and run. FocuZ cuts the model into horizontal layers and marks them
one after another, so the laser removes material in the shape of the model — no depth map to prepare.

## What you need

- A fiber laser with a **BJJCZ (JCZ) galvo controller** — the EZCad2 family, including boards sold as
  "LightBurn-compatible".
- A 3D model: **STEP/STP** (true solids, always closed) or a mesh — **STL**, **OBJ** or **3MF**.
- FocuZ on Windows ([free 30-day trial](https://lokahi.shop)).

## Step by step

1. **Add a 3D Slice action** in the Sequencer and **import** the model. FocuZ switches to the 3D canvas.
2. **Size and position it.** Scale the model to the finished size and set its registration point in the
   work area. The top of the model is the surface you start marking from.
3. **Choose the slice count.** Each slice removes one layer of material. Find out how deep one slice cuts
   on your material and settings, then set enough slices to reach the depth you want. More, thinner
   slices give smoother slopes.
4. **Add a perimeter if the model sits inside a pocket.** A perimeter bounds the area carved around the
   model — for example a circle for a coin background. Choose **Hull** to follow the model's own
   footprint.
5. **Set the fill.** A line fill with **Auto Rotate** turns the angle on every slice so the patterns don't
   stack into ridges.
6. **Trace, then run.** Trace to check placement on the part, then press **Run**. Slices mark top to
   bottom; check **Inverse** to mark from the floor up.

## Tips for clean results

- **Prefer STEP for solids.** STEP models are always closed. Meshes are checked on import, and FocuZ warns
  you when a mesh isn't watertight — repair those before slicing, because an open mesh can slice
  unpredictably.
- **Fill Through** decides whether the bottom slice is marked; **Respect holes** keeps through-holes empty.
- **Z+ Offset** adds depth below the model, in mm or in slices.
- **Deep reliefs drift out of focus** as material comes off. Refocus between runs, or split the job into
  depth ranges.

## Why slice instead of using a depth map?

A depth map encodes height as gray levels in an image, which limits how smooth slopes can be. Slicing
works from the model itself — see
[Staircase lines in fiber laser relief engraving: slicing vs depth maps](relief-engraving-slicing-vs-depth-maps.md).

## Related

- [Importing Geometry › Importing 3D models](../importing.md#importing-3d-models-slicing)
- [The Sequencer › 3D layers: the Perimeter](../sequencer.md#3d-layers-the-perimeter)
- [Marking & Tracing › 3D slice marking](../marking-tracing.md#3d-slice-marking)
