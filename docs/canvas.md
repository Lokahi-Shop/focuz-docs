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

- **Click** an object to select it (a new pick replaces any earlier selection, in every layer);
  **Ctrl+click** on the canvas adds to / removes from the same selection as the layer tree.
- **Right-click ▸ Delete** on an item of a multi-selection deletes every selected object, file and border
  (after a confirmation with the count); one Undo brings them all back.
- **Right-clicking** a group, layer or sublayer (Enable / Disable marking) outlines that row while the menu
  is open and leaves the selection as it is.
- Selecting a **layer** (tree row, sequencer header or a field) selects its **artwork only**. A **border** is
  selected on its own, from its own row: Ctrl+click skips borders, and a Shift range selects everything
  between its ends except borders.
- Selecting in the **layer tree** highlights the object on the canvas, and vice-versa.
- **Nudge** the selection with the arrow keys (step sizes are set in [Preferences](projects-files.md)).
- **Ctrl+click** several items in the layer tree (objects, files, borders, layers) to select them together
  (within one layer, or across layers with **Allow multiple layer selection** on in Preferences) —
  the arrow keys then nudge them all by the same step. Ctrl+click toggles exactly what you click: a layer or
  file with everything in it, or a single segment inside a selected file or layer (the rest stays selected).
- **Shift+click** selects a range: file to file selects every file in between, layer to layer every layer,
  object to object every object (across layers); mixed ends select just the objects in between.
- With **Allow multiple layer selection** on ([Preferences](projects-files.md)), when a selection spans
  **several layers** (layers, or objects from different layers), each of those layers
  marks its Content section *(multiple layers selected)* and shows the **combined** Size and Location;
  typing a Location moves the whole selection, typing a Size scales it about its registration point, and
  **Turn By / Set Angle** turn the whole selection (see [Rotating](#rotating)).
- Use the **Position / Size / Rotation** controls (and link/unlink X/Y scaling) to place objects precisely —
  see [Importing Geometry](importing.md).
- Every object keeps **its own angle** — turn one object, a few, a whole layer or several layers; see
  [Rotating](#rotating).

### Registration point

The **registration point** is the point of the art that its **Location** numbers describe: a corner, an edge
middle or the centre. It is also the point that stays put when you **resize**, and the point the selection turns about
with **Turn about: Registration point**.

- **One point for everything.** The 2D chooser (9 points) and the 3D registration cube (27 points) set **one**
  shared point for every layer in every action. Every layer's Location always reads for that point.
- **Only you change it.** Selecting a different layer, switching between 2D and 3D, importing, or adding an
  action never changes it. **Opening a project** keeps the point you are working with; the project's layers
  are read for it.
- **Z-up, like the view cube.** X = left / right, Y = **back** (top of the screen in top view) / front,
  Z = **bottom** / middle / top (3D only; 2D art is flat). The chooser's top row is the cube's back row.
- **Changing it never moves art.** Only the Location numbers change to describe the new point.
- **3D imports** always land as if bottom-centre were chosen: centred on X / Y 0, sitting on Z = 0. Their
  Location then reads for your point.

Example: with **top-left** (back-left) chosen, a 20 × 10 mm part at X 0–20, Y 0–10 reads Location X 0, Y 10;
doubling its width keeps that back-left corner where it is.

### Rotating

Every object — a piece of 2D art or a 3D model — keeps its **own** angle. Rotating is something you do to the
**current selection** in the layer panel's **Transform** section:

- The **Selection** line says what is selected and at what angle(s). **RX / RY / RZ** show the selection's angle,
  or **—** when the selected items are at different angles.
- Type an angle, then press a button. The line under the buttons previews the result before anything moves.
  - **Turn By** turns the selection **together** by the amount you typed (a layout stays a layout): items at 30°
    and 0°, turned by 20, end at 50° and 20°. Only the boxes you typed in count.
  - **Set Angle** sets the angle. **As a group** (the default) turns the selection together to that angle — it
    needs the items to share one angle, and says so otherwise. **Each item** turns every item **in place** to
    that angle ("straighten these all to 0°").
  - **Enter** in an angle box = Set Angle.
- **Turn about**: the selection's **registration point**, or the **workspace origin** (the selection swings around
  0, 0). Both options are remembered and apply to every layer.
- Angles show as **0.000 – 359.999**: typing 400 gives 40, −30 gives 330. Turn By takes −359.999 – 359.999.
- **2D art** turns about Z. Typing **180** in **RX** or **RY** mirrors it (top ↔ bottom, left ↔ right).
- **3D models** turn about all three axes. Turn By turns about the **workspace** X, then Y, then Z axes; the boxes
  then show the model's resulting X / Y / Z angles.
- With **Allow multiple layer selection** on, Turn By / Set Angle act on every selected layer; with it off, on
  the selected layer.
- **Size** shows the selection's **own** size (along its sides) when its items share one angle, labelled
  *Size (own)*; when they differ, the **outline** on the workspace (*Size (outline)*) and resizing is proportional
  only (the lock turns on). Several selected layers show their combined outline. For 3D, **Location Z** is the lowest point on the bed (with a bottom registration point).
- Fill lines keep their direction when the art turns.
- Perimeters never turn: they keep their own Size and Location. A **Hull** perimeter is rebuilt around the art
  after every move, turn or flip (it keeps its Offset).

### Flip and Mirror

Right-click a row in the layer tree — an action, a group, a layer, a file or an object (or a multi-selection):

- **Flip X / Flip Y** (when 3D models are in it) turn everything under that row 180° about the workspace X or Y
  axis — **other side up**. The part keeps its height: a part whose top sat at Z 0 still has its top at Z 0, so
  you can engrave one side, flip, and engrave the other at the same focus. 2D layers in it mirror.
- **Mirror horizontal / Mirror vertical** (2D only) mirror left ↔ right or top ↔ bottom.
- Always about the **workspace origin**, always on the row you clicked and everything under it (the multiple
  layer selection setting doesn't matter), and one **Ctrl+Z** undoes it. A part off-centre lands on the
  mirrored side — FocuZ tells you if any of it leaves the lens field.
- Perimeters stay where they are (a Hull is rebuilt); calibration actions and the Test Grid don't flip.

## What you see

- A **grid** for scale reference (toggleable).
- Imported geometry colored by layer.
- **Fill** and **cut** previews drawn over the shapes so you can see the marking pattern before you run.
- **Very fine fills drawn solid.** A fill whose line spacing is below the **Solid fill below spacing** setting
  ([Preferences](projects-files.md#preferences-edit-preferences), default **0.05 mm**) shows as one solid area in the
  layer's colour instead of its lines — at that spacing the lines blend into a solid area anyway, and the canvas stays
  quick. Holes in the art stay empty. Only the screen changes: the job marks every line, and the time estimate
  counts them. Set it to **0** to always see the lines.

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
