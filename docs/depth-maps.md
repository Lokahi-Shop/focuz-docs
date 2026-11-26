---
description: "Import a grayscale depth map into FocuZ as a 3D model, then cut it from the top or bottom, invert, smooth or swap the image with Edit Depth Map."
---

# Depth Maps

A depth map is a grayscale image where brightness means height. FocuZ turns a depth map into a real **3D
model**. From then on it behaves like any imported STL or STEP model: you can slice it, give it a perimeter,
move and size it, and preview it.

If you have the 3D model itself, import that instead. A depth map can only hold as many heights as it has gray
levels, so its slopes are made of small steps. A model slices from its true surface. See
[Staircase lines: slicing vs depth maps](guides/relief-engraving-slicing-vs-depth-maps.md).

To see what a depth map loses, the free [Slice vs Depthmap comparison tool](https://compare.lokahi.shop)
compares a 3D model with its depth map sliced as a 3D model, and with the same map used the classic,
pixel-by-pixel way.

## Supported files

| File | Notes |
|---|---|
| **PNG, TIFF** | 8-bit or 16-bit. 16-bit gives far more height steps. |
| **JPG, BMP, GIF** | 8-bit. JPG compression adds noise to the heights. |
| **WebP, HEIC** | When Windows has the codec installed. |
| **EXR** | Float depth, for example a Blender depth pass. Scanline files saved with ZIP, ZIPS, RLE or no compression. Other EXR compressions are refused with a message: re-save as ZIP. |
| **PFM** | Float depth. |

The pixel values are read exactly as stored. No color profile or gamma is applied.

## Importing

Depth maps import into **3D Slice**, **3D Cut** and **3D Shadow** actions. Press **Import** in the layer and
pick the image (it is listed under **All 3D Files** and **Depth Maps**). Picking one in a 2D action shows a
message and imports nothing.

The **Import Depth Map** window shows the image, its size in pixels, its bit depth and how many gray levels
it really uses. For example, "16-bit file, 763 levels" means the file is 16-bit but holds 763 distinct heights.

- **Width (X)** or **Height (Y)**: type one and the other follows the image. This is the size of the
  **visible** model, not counting transparent margins.
- **Depth (Z)**: the full black-to-white depth in mm. The next import starts with the Z you typed last.
- **Sampling resolution**: the distance between model points. It starts at the image's own pixel spacing, but never
  finer than 0.02 mm. The window shows how many points that makes.

**Import** stays greyed until X or Y and Z are filled in. Building a large model takes a few seconds behind a
small progress window; **Cancel** stops it.

FocuZ asks before importing a **color image or a render**, because its brightness comes from color and
lighting rather than height. Very large models (over 8 million triangles) also ask first, and models over
12 million triangles are refused. Choose a coarser resolution (a larger number) to make them lighter.

## How the image becomes a model

- **White is the top, black is the bottom** of the Z depth you typed.
- **Transparent pixels** are background: no model there. The edge follows the image smoothly instead of in
  pixel steps.
- Each image point becomes a point on the model. Flat areas use far fewer triangles than detailed ones.
- The model is closed: the image surface on top, walls around the edge and a flat base. Black areas keep a
  very thin layer above the base, so they are still part of the model and of its outline.
- **EXR and PFM** files hold depth values rather than gray levels. FocuZ maps their nearest-to-farthest range
  onto your Z depth. A camera depth pass is dark where things are near, so use **Invert map** (below) to
  bring the near side up. Pixels with no depth (the empty background of a render) become transparent.

## Raised relief or pocket

The action and its perimeter decide how the model is engraved, exactly as for any 3D model:

- **Perimeter ▸ Hull**: FocuZ marks around the model, so the relief stands up. White areas stay untouched
  and the background is carved down to the black level.
- **No perimeter**: FocuZ marks the model's own cross-sections, so the result is a pocket in the shape of the
  relief.

See [3D perimeters](sequencer.md#3d-layers-the-perimeter).

## Edit Depth Map

Right-click a depth-map model in the layer tree and choose **Edit Depth Map…**. Depth-map models show a small
relief marker after their name. The window edits that one model, and the canvas updates as you go. The rest of
FocuZ stays usable while it is open: you can change layer settings, move the model or turn the view. Run, Trace,
Save, Open and New ask you to finish the edit first (OK or Cancel). **Cancel** puts the model back but keeps the
other changes you made meanwhile.

- **Cutting planes**: one track with two handles, over bars that show how much of the image sits at each
  height. Each handle is a flat plane that cuts the model.
    - **Low handle**: a plane rising from the bottom. Everything below it is cut away, so the model loses its
      lowest parts and its outline shrinks to what rises above the plane. This is the way to drop a black
      background around a coin. If faint near-black specks around the subject survive as small islands, raise
      the low handle a little or add some smoothing.
    - **High handle**: a plane dropping from the top. Everything above it is cut off, leaving a flat top.
    - Type exact values in mm in **Low** and **High**. In a 3D Slice layer the handles step from one slice plane to
      the next, so a cut always lands exactly on a slice; the steps follow the layer if you change # of Slices,
      Slices/mm, Fill Through, the size or the position while the window is open. Otherwise they move in small mm steps.
    - **What is left never moves.** Cutting from the bottom raises the base off Z 0 by the amount cut. To put
      the base back on the surface, set the layer's **Location Z** to 0 (with the bottom-centre registration
      point).
- **Invert map**: swaps high and low before the handles act.
- **Smoothing**: smooths the model's heights over this radius in mm (0 = off), which softens the steps
  between gray levels. The image itself is never changed. Smoothing can lower the highest peaks slightly.
- **Sampling resolution**: rebuild finer or coarser from the original image.
- **Show closed mesh**: turn it off to see only the image surface on the canvas. This is display only; slicing
  always uses the closed model.
- **Replace image…**: swap in a re-edited depth map. Size, position and settings stay. The width is kept and
  the height follows the new image.
- **Reset**: everything back to how the depth map was imported.
- **OK** keeps the changes as one step you can undo with `Ctrl+Z`. **Cancel**, `Esc` or closing the window
  puts the model back as it was.

In a 3D Slice layer, **Slices/mm** counts from the model's top down to Z 0. Cutting from the bottom leaves the
top where it is, so the slice count does not change. Cutting from the top lowers the top, so the layer gets fewer
slices of the same thickness. Moving the model with **Location Z** changes Slices/mm, because the distance from
its top to Z 0 changes.

## Saving and copying

The original image is saved inside the project, compressed. A reopened project can still be edited with
**Edit Depth Map…**. Copies made with **Duplicate**, **Copy** and **Paste** keep it too. When a project opens,
the model is used exactly as it was saved; it is only rebuilt when you edit it.

## Limits

- Images up to about 8,000 × 8,000 pixels.
- EXR: tiled, deep and PIZ / DWA / B44 / PXR24 / HTJ2K-compressed files are refused. Re-save as a scanline EXR
  with ZIP compression.

## See also

- [Importing Geometry](importing.md)
- [Engraving STL and STEP models](guides/engraving-stl-step-models.md)
- [Staircase lines: slicing vs depth maps](guides/relief-engraving-slicing-vs-depth-maps.md)
