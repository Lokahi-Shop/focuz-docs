# The Canvas (Design & Preview)

The canvas is where you place, orient, and preview your work. The toolbar **Preview toggle** switches
between the **Sequencer** layout and the **Preview**.

## 2D vs. 3D view

- **2D** — the flat design view for 2D art.
- **3D** — a perspective view for 3D imports and 3D-slice previews. Switching to a 3D Slice action puts the
  canvas in 3D mode.

### Workspace Offset

In the 3D view, **Workspace Offset** at the right end of the canvas toolbar sets how far the workspace
grid sits below the marked surface. The marked surface always stays at Z0; only the grid moves. It is a
view setting — it never changes what marks, and slicing and every other calculation still work from
Z0 — and it is saved with the project.

| Option | The workspace sits… | Offered |
|---|---|---|
| **Diameter** | one part diameter below the surface — the part rests on the workspace | With a rotary action in the sequence |
| **Radius** | on the rotary axis | With a rotary action in the sequence |
| **Lens Offset** | below the surface by the current lens's offset (on a rotary job, plus the part's radius) | Always |
| **Custom** | below the surface by the distance you enter, 0 to 1000.00 mm | Always |

Diameter and Radius use the **largest part diameter** in the sequence. With **Custom**, a box appears
beside the dropdown for the distance; it starts at 0, which leaves the workspace at the surface. The
2D view and the Preview always show the workspace at the surface, so the control is not shown there.

Whenever the workspace is offset, a **height scale** stands at its back-left corner, from the
workspace up to the marked surface: a tick every 5 mm, a longer one every 10, and a white mark at the
surface. On a rotary job it also marks the axis height and each part surface.

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
- **Ctrl+click** several items in the layer tree (objects, files, borders, layers) to select them together —
  the arrow keys then nudge them all by the same step. Ctrl+click toggles exactly what you click: a layer or
  file with everything in it, or a single segment inside a selected file or layer (the rest stays selected).
- **Shift+click** selects a range: file to file selects every file in between, layer to layer every layer,
  object to object every object (across layers); mixed ends select just the objects in between.
- Use the **Position / Size / Rotation** controls (and link/unlink X/Y scaling) to place objects precisely —
  see [Importing Geometry](importing.md).

### Rotating 3D models

A 3D model carries **two independent rotations** that combine:

- **Model Registration** — spins the model about its registration-cube point. A center point spins it
  in place; a corner or edge point tilts it about that point. The model's location doesn't change.
- **Workspace Center** — rotates the model about the workspace origin (0,0,0). A model away from the
  origin **swings around it** as the angle changes, turning as it goes; a model sitting at the origin
  spins in place.

The **Origin:** dropdown picks **which of the two sets the RX/RY/RZ fields show and edit** — switching
it never moves the model, and each set remembers its values. Returning a set to 0 undoes exactly that
rotation; with both sets at 0 the model is back in its original pose.

- **Size** and **Location** always describe the **current rotated footprint** — the box the model
  actually occupies in the workspace, which is what marking uses (slice height, where it lands). This
  holds whether or not the model is selected, and the values stay consistent across reselects, mode
  switches, and project reloads.
- Typed Location edits and arrow-key nudges move the model along plain **workspace axes** by exactly
  the amount entered, whatever the rotations are.
- Size editing follows the **combined** rotation: at **right angles** (0/90/180/270°) each axis can be
  stretched independently (or proportionally with the link on); at **other angles** scaling is uniform —
  the proportional link locks on (a gold indicator appears beside it) and one value scales all three
  axes. To stretch a single axis at an odd angle, bake the rotation into the model in your CAD tool and
  re-import at 0°.
- A flat perimeter has no tilt, so X/Y rotation is disabled while a perimeter is selected (Z rotation
  still works).

## What you see

- A **grid** for scale reference (toggleable).
- Imported geometry colored by layer.
- **Fill** and **cut** previews drawn over the shapes so you can see the marking pattern before you run.

## The layer tree

The panel on the left edge of the canvas lists every action's groups, layers, sublayers and imported
objects. Two things decide what you see and what marks:

- **Marking on or off** — right-click a group, layer or sublayer and choose **Disable marking** or
  **Enable marking**. A disabled line is **gray**: it is not drawn on the canvas and it does not mark,
  whatever its eye says. Everything under a disabled group or layer is off with it.
- **The eye** — click it to show or hide an object, an import, or a whole layer on the canvas. The eye
  is for viewing only: something hidden with marking still on **still marks**. A line like that carries
  a **warning triangle**, so a hidden object never marks by surprise.

| Marking | Eye | On the canvas | Marks |
|---|---|---|---|
| Enabled | Open | Shown | Yes |
| Enabled | Closed | Hidden — warning triangle in the tree | Yes |
| Disabled | Either | Hidden — gray in the tree | No |

The small square beside a layer or sublayer shows or hides its **fill** preview, and right-clicking an
object, an import or a border offers **Delete**.

## See also

- [Importing Geometry](importing.md) · [The Sequencer](sequencer.md) · [Marking & Tracing](marking-tracing.md)
