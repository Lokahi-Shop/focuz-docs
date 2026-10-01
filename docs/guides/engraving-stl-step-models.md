# Engraving STL and STEP models on a galvo fiber laser

**Short answer:** in FocuZ, add a **3D Slice** action, import the model (STEP, STL, OBJ or 3MF), size and
place it, choose how many slices, and run. FocuZ cuts the model into horizontal layers and marks them
one after another, so the laser removes material in the shape of the model — no depth map to prepare.

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

- **STEP or STL?** With a STEP file there's no need to worry about the model being watertight — it's a
  true solid. An STL (or other mesh) can show **micro-faceting** if the model doesn't have enough polygons;
  export it with a finer mesh for smooth curves.
- **Fill Through** fills the mesh or solid down to the workspace, eliminating any undercuts.
  **Respect holes** keeps through-holes empty.
- **Z+ Offset** includes space above the model, in mm or in slices.

## Why slice instead of using a depth map?

A depth map encodes height as gray levels in an image, which limits how smooth slopes can be. Slicing
works from the model itself — see
[Staircase lines in fiber laser relief engraving: slicing vs depth maps](relief-engraving-slicing-vs-depth-maps.md).

## Related

- [Importing Geometry › Importing 3D models](../importing.md#importing-3d-models-slicing)
- [The Sequencer › 3D layers: the Perimeter](../sequencer.md#3d-layers-the-perimeter)
- [Marking & Tracing › 3D slice marking](../marking-tracing.md#3d-slice-marking)
