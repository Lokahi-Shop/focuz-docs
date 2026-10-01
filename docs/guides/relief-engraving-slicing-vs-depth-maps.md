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

## How slicing is different

A **3D Slice** action in FocuZ imports the model itself — **STEP**, **STL**, **OBJ** or **3MF** — and cuts
it into horizontal layers. Each layer is filled inside the model's exact cross-section at that height, as
vector geometry, so the outline of every layer is where the model says it is, not where a pixel grid
rounds it to.

What that gives you:

- **Outlines at true resolution.** Layer boundaries are vector paths, not pixel edges.
- **Control over step size.** Depth still builds up layer by layer, so a slice is still a small step — but
  you set the slice count, and finer slices make smaller steps. You are not limited to the levels a
  depth map happened to contain.
- **The model stays editable.** Scale, rotate and place the model in FocuZ; the slices are recomputed
  from the geometry, not from a re-rendered image.

## Getting smooth results

1. **Start from a good model.** A STEP solid needs no watertight checks; an STL needs enough polygons to
   avoid micro-faceting on curves.
2. **Pick a slice count for your material.** Measure how deep one slice removes on your material, then
   set enough slices to reach the depth you want — more, thinner slices give smoother slopes.
3. **Turn the fill between slices** with **Auto Rotate** (and a **Step** angle), so line patterns don't
   stack into ridges.

## See it for yourself

The free **[Slice vs Depthmap comparison tool](https://compare.lokahi.shop)** loads a 3D model and shows
the same surface as depth-map levels and as true slices side by side.

## Related

- [Importing Geometry](../importing.md) — bringing in STEP and mesh files
- [Marking & Tracing › 3D slice marking](../marking-tracing.md#3d-slice-marking)
- [Engraving STL and STEP models on a galvo fiber laser](engraving-stl-step-models.md)
