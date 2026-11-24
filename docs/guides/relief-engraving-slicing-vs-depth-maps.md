---
description: "Why fiber laser relief engravings from depth maps show staircase lines, and how slicing the 3D model gives true outlines and a step size you choose."
---

# Staircase lines in fiber laser relief engraving: slicing vs depth maps

**Short answer:** visible steps in a fiber laser relief usually come from how depth is *encoded* before the
laser ever fires. Grayscale depth maps turn a smooth surface into a limited number of gray levels, and
each level becomes a band of equal depth. Slicing the 3D model directly makes each layer follow the
model's true outline at that height, and you choose how fine those layers are.

## The problem

You engrave a relief — a coin, a medallion, a sculpted logo — and the curved surfaces come out as
terraces or contour rings instead of smooth slopes. The steepest areas look fine; gentle slopes show the
worst banding.

## Why it happens

Most galvo software marks depth from a **grayscale depth map**: a 2D image in which brightness stands for
height. The software converts gray levels into passes or power, so the result can only be as smooth as:

- **the number of gray levels** the map carries and the software actually uses,
- **the image resolution** — a pixel grid laid over curved outlines, so edges of each level are stair-cased
  in plan view too,
- **how the map was made** — a map rendered from a 3D model has already thrown away the exact geometry.

Gentle slopes suffer most: a small change in height spreads one gray level over a wide area, which marks
as a flat band with a sharp edge.

A 16-bit map has plenty of height levels, but its levels still have to be lined up with the slice count,
and its quality depends on its pixel resolution too. Editing a depth map to get the detail you expect is
difficult. With slicing, every slice is a consistent depth, and only the marking settings and the number
of slices control quality.

## How slicing is different

A **3D Slice** action in FocuZ imports the model itself — **STEP**, **STL**, **OBJ** or **3MF** — and cuts
it into horizontal layers. Each layer is filled inside the model's exact cross-section at that height, as
vector geometry, so the outline of every layer is where the model says it is, not where a pixel grid
rounds it to.

What that gives you:

- **Outlines at true resolution.** Layer boundaries are vector paths, not pixel edges.
- **Control over step size.** Depth still builds up layer by layer, so a slice is still a small step — but
  you set the slice count, and finer slices make smaller steps. You are not limited to the levels a
  depth map happened to contain. Slicing can still leave visible steps if the slices are too few or the
  depth per pass doesn't match your material.
- **The model stays editable.** Scale, rotate and place the model in FocuZ; the slices are recomputed
  from the geometry, not from a re-rendered image.

## Getting smooth results

1. **Start from a good model.** A STEP solid needs no watertight checks; an STL needs enough polygons to
   avoid micro-faceting on curves.
2. **Measure your material removal rate, then set the slices from it.** One pass rarely removes enough to
   measure accurately, so run a test area with your settings for many passes (say 50 or 100), measure the
   depth, and divide it by the number of passes. That's your **depth per pass**. For example, 0.50 mm deep
   after 50 passes is 0.01 mm per pass. With one pass per slice, set **Slices/mm** to 1 ÷ that depth —
   100 in the example — and FocuZ sets the **# of Slices** to match the model's height. More, thinner
   slices give smoother slopes.
3. **Turn the fill between slices** with **Auto Rotate** (and a **Step** angle), so line patterns don't
   stack into ridges.

## See it for yourself

The free **[Slice vs Depthmap comparison tool](https://compare.lokahi.shop)** loads a 3D model and the depth
map made from it — or its own example — and compares three results at every slice height:

| Result | What it is |
|---|---|
| **True slice** | The 3D model sliced directly. The tool treats this as the desired outcome. |
| **Depth map as a 3D model** | The same depth map built into a 3D surface, the way FocuZ [imports a depth map](../depth-maps.md), then sliced. Contours run between the pixels. |
| **Classic depth map** | Each pixel marked or skipped by its gray level. Outlines follow the pixel grid. |

For each depth map result it shows where the slice differs from the 3D model, and totals for the whole job:
**Depth accuracy** (the share of points marked to the right slice), average and maximum depth error, and the
share off by more than one slice. Depth accuracy changes with the number of slices, so compare runs at the
same slice count.

A high-resolution 16-bit map scores close both ways. The gap grows with low-resolution or 8-bit maps, where
the classic result shows its pixels and the 3D-model result stays smooth. Neither can bring back detail the
image never stored.

Everything runs in your browser; nothing is uploaded.

## Related

- [Importing Geometry](../importing.md) — bringing in STEP and mesh files
- [Marking & Tracing › 3D slice marking](../marking-tracing.md#3d-slice-marking)
- [Engraving STL and STEP models on a galvo fiber laser](engraving-stl-step-models.md)
- [Depth Maps](../depth-maps.md) — when a depth map is all you have, FocuZ turns it into a 3D model
