# Importing Geometry

FocuZ imports both 2D art and full 3D models. 3D models are sliced into layers for depth-aware marking.

## Supported formats

| Kind | Formats | Notes |
|---|---|---|
| 2D vector | **SVG, DXF, AI, EPS, PDF** | Lines/curves to mark or fill. |
| 3D solid | **STEP / STP** | True solids (via the built-in 3D engine). Imports at the model's exact size; curves come in to within 0.01 mm. |
| 3D mesh | **STL, OBJ, 3MF** | Triangle meshes. |

Text and placed images inside a 2D file are not imported — see
[Text and images](#text-and-images).

A layer takes the files that match its action: 2D actions import 2D art, 3D actions (3D Slice, 3D Cut, 3D Shadow)
import 3D models. Picking the other kind (for example with **All Files** in the file dialog) shows a message and
imports nothing.

## Importing 2D art

Add a **2D Import** action and choose your file.

- **Multi-layer files** — if the file has multiple layers, FocuZ asks whether to **flatten** them into one
  or keep them **separate**. Separate layers land exactly where they sit in the file — the whole file is placed by
  the registration point, so the layers stay lined up on top of each other.
  Pick **which layers** come in: all are selected at first; click picks one, `Ctrl`+click toggles,
  `Shift`+click picks a range, `Ctrl+A` picks all. Picked **separate** layers still land where they sit in the
  whole file — as if every layer came in and you deleted the rest.
  A layer that is hidden in the file is listed as ***Name* (hidden)** — it imports with the rest, switched off
  (see [Hidden layers](#hidden-layers)). Art that sits in none of the file's layers is listed as **(no layer)**.
- **Registration point** — choose the reference point used to position the art (a 9-point grid for 2D).
- **Position / Size / Rotation** — place and scale the art on the [canvas](canvas.md); link or unlink X/Y
  scaling.
- **Border** — optionally load a closed path as a **clipping boundary** so marks stay within it.

!!! tip "Fills need closed paths"
    A [fill](sequencer.md#fill-types) can only fill a **closed** shape. If a fill looks empty, the path
    probably isn't closed — check it in your design tool, or adjust the closed-path tolerance in
    [Hardware & Device Setup](hardware-setup.md). A layer whose art has no closed path keeps its **Fill**
    box greyed out until it does; a 2D Grid's second layer and a group sublayer follow the art they fill.

## Hidden layers

A layer that is hidden in your design tool **still imports** — but it arrives switched off, so it can never
mark the part by surprise:

- Its **eye is closed**: it is not shown on the canvas.
- Its **marking is disabled**: it does not mark until you right-click it in the
  [layer tree](canvas.md#the-layer-tree) and choose **Enable marking**. Enabling marking does not open the eye —
  click the eye to see the layer. (A layer that marks while its eye is closed carries the tree's warning triangle.)

Where the hidden layer lands depends on how you import:

| Import | A hidden layer becomes |
|---|---|
| **Separate layers** | Its own layer, gray in the tree. |
| **Flattened** into one layer (also a 2D Grid) | Its own file row inside that layer, gray in the tree. |

The import is **placed by the art that is not hidden**. A hidden layer keeps its position relative to the rest,
but it never changes where the visible art lands. After a flattened import the visible art is selected, so the
**Size** and **Location** boxes show it; with the whole layer selected they measure everything in the layer,
hidden rows included.

**Preferences ▸ Import ▸ Enable marking on imported hidden layers** (off by default) brings hidden layers in
with marking **enabled** instead — still with the eye closed.

What counts as a hidden layer:

| File | Hidden means |
|---|---|
| SVG | A top-level layer group with `display: none` or hidden visibility — on the group itself or through a style-sheet class. |
| DXF | A layer that is **off** or **frozen**. |
| AI, PDF | A layer with its eye off. |
| EPS | Nothing — an EPS carries no layers, and a layer hidden when it was saved is not in the file at all. |

- A layer that is visible but set **not to print** (or not to plot) is a visible layer.
- Hidden things that are **not layers** are not imported: a hidden shape, group or sublayer inside a layer, and a
  DXF entity marked invisible.
- A file imported as a **perimeter** or as a **cut path** uses its visible layers only.

## Preparing AI and SVG files

A little preparation in your design tool makes vector imports land exactly as designed.

### Convert text to outlines

**FocuZ imports vector paths, not fonts.** Live text in an AI or SVG file — text still bound to a
font — is not imported, and there are no plans to render fonts inside FocuZ: substituting an
installed font for the designer's font would mark the *wrong* shapes with full confidence, which
is worse than leaving them out. Convert text to paths before exporting:

- **Illustrator:** select the text → **Type ▸ Create Outlines** (Ctrl/Cmd+Shift+O).
- **Inkscape:** select the text → **Path ▸ Object to Path**.

If imported art is missing its lettering, this is almost always why.

### Text and images

When a file holds text, FocuZ says so as it imports: **Continue** brings in the rest of the art, **Cancel**
imports nothing so you can convert the text first. Placed images are called out the same way — images are not
imported. If the file holds nothing else, the message says that too. The log records how many text objects and
images were left out.

### Saving AI, PDF and EPS files

- **AI and PDF** — FocuZ reads the art from the file's page, with its layers. Save with **Create PDF Compatible
  File** turned on (Illustrator's default): a file saved without it holds no readable art, and FocuZ tells you to
  save it again. **Use Compression** and **Embed ICC Profiles** can be on or off.
- **Illustrator 8** files import with their layers.
- **EPS** files import as one flat set of art.
- A shape that has both a fill and a stroke imports as **one** object.
- A password-protected PDF cannot be read.

### Flatten before export

Flattening (Illustrator: **Object ▸ Flatten Transparency**, or **Object ▸ Expand / Expand
Appearance**) bakes advanced constructs down to plain paths — which is exactly what a laser
needs:

- **Clipping masks** are applied: geometry is genuinely cropped to the mask, so hidden portions
  can't come back on import.
- **Symbols, brushes, patterns and effects** become real geometry at their placed positions.

Files saved as **Illustrator 8** (the version EZCad2 requires) are largely flattened by the
save-down itself, which is why EZCad2-era art usually imports cleanly.

### Artboards

From an **AI or PDF** file FocuZ imports the **artboard's art**: paths entirely outside the artboard are
skipped, and the count is recorded in the log ("*N paths beyond the artboard were not imported*") so a missing
element is never a mystery. Artists commonly park scratch material on the pasteboard — that
material stays out of your job.

- Art **crossing** the artboard edge imports whole by default. The Preferences ▸ Import option
  **"clip art crossing the artboard closed at its edge"** cuts it at the boundary instead,
  resealing closed shapes along the edge (note the sealed edge marks as a line).
- A file with **several artboards** asks which one to import.
- **Illustrator 8** files and **EPS** files carry no artboard FocuZ can use — all of their art imports.

### Sizes and units

AI files import at true size (Illustrator's points convert to millimeters). SVG files with real
units (mm/cm/in/pt) import exactly; pixel-based SVGs use **Preferences ▸ Import ▸ SVG px
scale** — *Auto* reads 96 dpi (the web standard) unless the file identifies itself as an
Illustrator export (72 dpi), or force either value.

### Curves come in as drawn

FocuZ keeps the file's geometry rather than redrawing it. Circles, ellipses and arcs import as
**true curves**: an SVG `<circle>`, `<ellipse>`, rounded `<rect>` or path arc command, and a DXF
CIRCLE, ARC, ELLIPSE (a partial one keeps its start and end) or polyline bulge. A 50 mm circle
measures 50.000 at any angle, and its marking follows the real curve. SVG `skewX` / `skewY`
transforms are honoured. Curves drawn **with Béziers** in the design tool (an Illustrator circle,
every AI / PDF / EPS curve) stay Béziers — that is what the artist drew.

DXF files also bring in:

- **Splines**, read from their knot vector; a spline given by fit points only is drawn as a smooth
  curve through them.
- **Block references** (INSERT), placed with their scale, rotation, mirror and arrays, nested blocks
  included. External references (XREF) live in another file and are not imported — the log says so.
- **Drawing units** (`$INSUNITS`): inches, feet, centimetres and the rest convert to millimetres. A
  file that states no unit is read as millimetres, with a note in the log.
- **Model space only**: entities placed on a paper-space layout are skipped, with a note in the log.

!!! note "Projects and curves"
    Projects saved by this version carry the new curve type and open in this version or newer.

## Importing 3D models (slicing)

Add a **3D Slice** action and import a STEP/STP or mesh file. FocuZ switches to the 3D canvas and slices the
model into layers for marking.

- **Registration** — position the model in the work area (a 27-point grid for 3D).
- **Sizing & Z position** — scale the model and set where it sits along Z (for rotated models see
  [Rotating](canvas.md#rotating)).
- **Perimeter** — an optional boundary around the model's footprint (Import / Hull / Circle / Square) —
  see [3D perimeters](sequencer.md#3d-layers-the-perimeter).
- **Fill-Through** — whether the bottom slice is marked.
- The **slice count** follows the model's depth and your settings.

!!! note "Open meshes"
    STL/OBJ/3MF meshes are checked on import. If a mesh isn't closed ("watertight") — it has holes, or
    faces that share an edge with more than one other face — FocuZ says how many and offers to repair it:

    - **Repair and import** merges coincident corners, joins open edges within 0.01 mm, removes doubled
      faces, caps each hole and makes the faces consistent. A through-hole whose wall faces are missing is
      bridged with a wall, so it stays a hole; a pipe end keeps its bore. The file on disk is not changed.
      If some edges still can't be closed, FocuZ tells you what remains and suggests repairing the model
      in your modeling tool and importing it again (you can still **Import anyway**).
    - **Import as-is** brings the model in unchanged.
    - **Esc** cancels the import.

    Whatever stays open is highlighted in **orange** on the design canvas, so you can see where the model
    may not mark as expected; the highlight disappears once the mesh is closed. Modeled through-holes (a
    sealed tunnel, a torus) are closed surfaces and are never flagged or touched. **STEP** files get the
    same check: a true solid reads closed, and the rare face that could not be meshed gets the same offer.

    OBJ faces with any number of corners import complete, and a 3MF keeps its units and the placement of
    every part on the plate. A 3MF that stores its model across several parts in the file, as meshy.ai
    exports do, imports like any other. Very large models (millions of triangles) can take a minute to
    import.

!!! note "STEP size and curves"
    A STEP model imports at its **exact** size — the Size fields show the model's true dimensions (a 49 mm
    disc reads 49, not the width of the polygon that draws it). Its curved faces come in to within
    **0.01 mm** of the true surface, the same curve tolerance 2D arcs use, so a STEP circle and an SVG
    circle of the same size mark the same.

How slices are marked (Z order, per-slice sublayers) is covered in
[Marking & Tracing](marking-tracing.md#3d-slice-marking).

## Tips

- Check **units/scale** on import — confirm the imported size on the canvas grid before marking.
- Re-importing the same file is supported; FocuZ can relink originals when you reopen a project (see
  [Projects & Files](projects-files.md)).

## See also

- [The Canvas](canvas.md) — placing and transforming imports.
- [The Sequencer](sequencer.md) — fills and marking parameters.
- [Marking & Tracing](marking-tracing.md) — running a 2D or 3D job.
