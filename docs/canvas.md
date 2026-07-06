# The Canvas (Design & Preview)

The canvas is where you place, orient, and preview your work. The toolbar **Preview toggle** switches
between the **Sequencer** layout and the **Preview**.

## 2D vs. 3D view

- **2D** — the flat design view for 2D art.
- **3D** — a perspective view for 3D imports and 3D-slice previews. Switching to a 3D Slice action puts the
  canvas in 3D mode.

## Navigating

| Action | How |
|---|---|
| **Zoom** | Mouse wheel |
| **Pan** | Right-click drag |
| **Orbit** (3D) | Middle-click drag |
| **Snap to a view** (3D) | Click a face/edge of the **view cube** |
| **Perspective ⇄ orthographic** (3D) | Projection toggle button (top row) |
| **Reset view** | Reset button |
| **Zoom to fit** | Fit-to-content button |

## Selecting & editing

- **Click** an object to select it; multi-select within a layer.
- Selecting in the **layer tree** highlights the object on the canvas, and vice-versa.
- **Nudge** the selection with the arrow keys (step sizes are set in [Preferences](projects-files.md)).
- Use the **Position / Size / Rotation** controls (and link/unlink X/Y scaling) to place objects precisely —
  see [Importing Geometry](importing.md).

### Rotating 3D models

- The **Origin:** dropdown in the Rotation section picks the pivot: **Model Registration** (rotate about
  the model's registration point) or **Workspace Center**.
- For a rotated model, **Size** and **Location** always describe the **current rotated footprint** — the
  box the model actually occupies in the workspace, which is what marking uses (slice height, where it
  lands). The values stay consistent when you reselect or reload the project, and edits round-trip.
- Size editing follows the rotation: at **right angles** (0/90/180/270°) each axis can be stretched
  independently (or proportionally with the link on); at **other angles** scaling is uniform — the
  proportional link locks on (a gold indicator appears beside it) and one value scales all three axes.
  To stretch a single axis at an odd angle, bake the rotation into the model in your CAD tool and
  re-import at 0°.
- A flat perimeter has no tilt, so X/Y rotation is disabled while a perimeter is selected (Z rotation
  still works).

![TODO screenshot: canvas with an object selected and the view cube](assets/canvas-selection.png){ .screenshot }

<!-- TODO screenshot: canvas selection + view cube -->

## What you see

- A **grid** for scale reference (toggleable).
- Imported geometry colored by layer.
- **Fill** and **cut** previews drawn over the shapes so you can see the marking pattern before you run.

## See also

- [Importing Geometry](importing.md) · [The Sequencer](sequencer.md) · [Marking & Tracing](marking-tracing.md)
