# Rotary Marking

Mark cylindrical parts — tumblers, rings, shafts, pens — by rotating the part between marking
passes. The galvo can only mark a flat window at a time, so FocuZ wraps your artwork around the
part in **splits**: it marks one strip, rotates the part, marks the next strip, and so on until
the whole design is on the surface.

Rotary marking always runs through the [**2D Rotary** action](#the-2d-rotary-action) in the
Sequencer — the action carries the job's part and split values, so nothing has to be switched
on or off app-wide. The rotary hardware itself (motor, mode, axis) is configured once under
**Device ▸ Rotary Setup**.

!!! info "Which controller drives the rotary"
    The rotary runs from your BJJCZ laser controller's expansion axis — no extra hardware. It has been
    tested on the Lite boards (**LMCV4-FIBER-M**, **FBLI-B-LV4**), which have a single expansion axis.
    The less common Standard boards (**LMCV4-FIBER**, without the -M), which have two expansion axes, are untested but should work; FocuZ
    uses only the first axis. A motorized **Z** for focus works through a FocuZ-compatible Z controller
    (FocuZ:grbl, coming soon), not through the standard laser board's own Z axis.

## Rotary Setup

Rotary Setup keeps **one settings profile per fixture** — **Chuck**, **Roller** and **Turntable** —
and each rotary action is tied to one of them: **2D Rotary (Chuck)** runs the Chuck profile, **2D
Rotary (Roller)** the Roller profile. Set each fixture up once; switching fixtures is just picking
the matching action. The **Fixture** selector at the top of the dialog chooses which profile the
page edits, and its **Enabled** box decides whether that fixture's action is offered in the
action list — untick the fixtures you don't own. (All three start enabled. A project that already
contains a hidden fixture's action still runs.) Everything below is per profile.

### Settings

- **Invert Direction** — flip the rotation direction for both jogging and marking.
- **Return to 0** — rotate back to the zero position when the job finishes (on by default).
  If a run is interrupted — cancelled or stopped for any reason — FocuZ always returns the
  rotary to zero so the part is never left at an arbitrary angle.
- **Rotation axis** — the axis the part **rotates around**. The artwork wraps *around* that axis: with
  X selected, the art's vertical (Y) direction wraps around the part; with Y selected, the
  art's horizontal (X) direction wraps. Match it to how the rotary sits under the laser.
- **Gear Ratio** — the drive ratio between motor and part, as *n* : 1. At 1 : 1 the motor's
  Steps/Rot is the part's steps per rotation; a 2 : 1 reduction means the motor turns twice
  per part rotation.
- **Roller Ø** — on the Roller profile, the drive rollers' diameter. Surface travel follows the
  roller, so both diameters matter: the part diameter for wrapping the artwork, the roller
  diameter for the motion math.

**Import markcfg7** on this dialog imports the motor parameters (steps/rotation, direction, gear
ratio, speeds, accel) into the profile currently shown. The Device Setup wizard's import seeds
all three profiles at once — check each page's gear ratio afterwards.

### Default Values

- **Diameter (default)** — a *default* part diameter for new 2D Rotary actions. Leave it blank
  if every job is a different part — each action carries its own diameter either way.
- **Split (default)** — entered exactly as in an action: pick **# of Splits** or **Max Split
  Size** from the dropdown and type the value. A new 2D Rotary action starts with the same
  dropdown choice and value. Smaller splits stay closer to the laser's focus and the field's
  sweet spot; larger splits mean fewer seams and faster jobs. Keep the strip shallow enough
  that its edges are still within your focus tolerance.
- **Overlap (default)** — a *default* overlap between neighboring strips, in mm. A little
  overlap can hide seam lines in fills.

The three defaults only pre-fill a new 2D Rotary action's fields; a blank default leaves the
action's field blank until you enter it there.

### Rotary Behavior
- **Outlines at seams** — how an outline or line that crosses a seam is divided between the two
  splits. Fills always share the full Overlap; this chooses the outline's window. **Exact seam**
  (the default) — divided exactly at the seam and marked once, nothing extended or doubled; a
  positioning error shows as a small break. **Stitch** — each split's outline runs a small fixed
  distance past the seam, the **Stitch** value (0.05 mm, about one spot), which covers positioning
  error without a visible doubled line. **Overlap** — outlines share the fill overlap too, so the
  segment inside it is marked by both splits (a doubled line the length of the overlap at every
  seam). Applies to layers and their sublayers.
- **Seam-aware splits (seams avoid geometry)** — lets each seam shift a little (up to about a
  quarter of the split size) to land in the widest nearby gap in the artwork, so seams fall
  *between* letters and shapes instead of through them. The **Gap** field beside it sets the
  narrowest empty band that counts as a seam home (default 0.1 mm) — lower it to let seams use
  very fine gaps, such as the grid lines of a checkerboard pattern.
- **Arc compensation (correct curvature per split)** — the laser projects each strip onto a
  flat plane, but the part surface curves away from it, so marks land slightly stretched near
  the strip edges. Arc compensation pre-corrects for the curvature so design distances land as
  true on-surface distances. The effect grows quickly with split size — it's what keeps
  geometry true when you use large splits, and it lets you size splits by focus alone. Fill lines are
  corrected the same way as outlines, and a fill pattern runs continuously from one split into
  the next. **On by default — keep it on.**
- **Backlash compensation (lash taken up before the first split)** — off by default. When on,
  the rotary overshoots the first strip slightly and comes back onto the position from the
  marking direction, so the first strip is approached from the same side as every later advance
  and gear or chuck play can't land in the first seam. Turn it on for any rotary that shows lash,
  however small — it only adds a short move per revolution.
- **Settle between splits** — the rest the laser takes between one mark and the next inside a
  rotary job: between splits, between layers and sublayers, and between revolutions. **None** (the
  default) starts the next mark as soon as the part is in position; **Short** adds a brief rest;
  **Full** rests as long as it does between separate marks. Step up if marks after a split start
  unevenly or the run pauses between splits. The job's very first mark always gets the full rest.

Splits are always distributed evenly across the artwork, so the last strip is the same size as
the rest — no thin leftover strip at the end.

## Multi-pass rotary jobs: where to put the Repeat

A rotary job can repeat in three places, and each one means something different:

| Repeat on… | What it does |
|---|---|
| a **layer** | Marks that layer again **on the split**, back to back, before the part turns. Each strip is taken to depth in one go — fewer rotary moves, so the job finishes sooner. |
| a **group** | Sends the group's layers **round the part again** — a fresh set of revolutions, with a return to zero between. |
| the **Rotary panel** (the box beside the *Rotary* title) | Runs **everything in the panel again**, a full turn of the part between. |

A **2D Grid** action has the same three places: its **Rotary** panel, the **Group** inside it, and each grid as
a **Layer** — so a layer's Repeat is still "on the split", the Group's is "round again", and the Rotary
panel's repeats the whole action. With its one Group the last two simply multiply.

For passes that let each strip cool — one pass on every split, then round again — put the count on
the **group** or on the **Rotary panel**, not on the layer. Seam artifacts are then spread across the
job rather than concentrated, which generally gives the better mark.

With 5 passes over 4 splits: a layer Repeat of 5 marks split 1 five times, then split 2 five times,
and so on; a Rotary-panel Repeat of 5 runs 5 laps of 4 splits. Backlash is taken up again at the
start of **every** lap, so each lap's first strip is entered from the marking side just like the
job's first strip.

**The pass count keeps running.** A fill that rotates its angle on each pass keeps stepping, and a
sublayer's **Run every** keeps counting, across group and Rotary-panel repeats — lap 4 is pass 4.

**Layers take turns around the part.** When an action has more than one layer on the same part,
each layer finishes its revolution before the next layer starts — the rotary never switches
between layers on the same split. That keeps consecutive splits on the same settings, which is
what lets them follow one another without a rest (see *Settle between splits* above); switching
settings on every split would cost a full rest each time.

!!! note "Per lap, in projects from earlier versions"
    Earlier versions had a **Per lap** checkbox on the layer. A layer saved with it ticked and more
    than one pass keeps the box and marks exactly as it did — one pass per revolution. Untick it and
    the layer's passes run on the split instead; the box then goes away. For new work, use the group
    or Rotary-panel Repeat.

### Motor

- **Steps/Rot** — motor steps per motor rotation (combine with Gear Ratio for the part).
- **Ramp Min / Max Speed** — each rotation ramps from Ramp Min up to Max Speed, in
  pulses/sec. Ramp Min is the starting speed, not a limit — a heavy chuck or part may need a
  lower one to start smoothly without losing steps; a light setup can start faster.
- **Accel** — acceleration ramp time, in ms.
- **Return Spd** — speed used when returning to zero.

### Jogging the rotary

Live rotary motion lives on the **Jog** card's **BJJCZ Rotary** strip (available while the
controller is connected): jog **CCW / CW** by the set angle, **Set Zero** to define the current
position as zero, and **Go to Zero** to rotate back to it at the Return Spd — with a live
position readout. See [Jog, Homing & Terminal](jog-terminal.md).

**Import Rotary from markcfg7…** pulls rotary parameters from an existing `markcfg7` file, the
same way as the main [device import](hardware-setup.md). The Device Setup window
([first-run setup](getting-started/first-run.md)) offers the same import in its Rotary Setup
section — including reusing the device's own `markcfg7` — so a rotary can be configured during
first run.

## The 2D Rotary action

The **2D Rotary (Chuck)** and **2D Rotary (Roller)** actions (Sequencer › Marking › **Rotary**) are
a 2D Import that marks through the rotary engine — the only way a job runs on the rotary. Pick
the one for the fixture on the bench: each runs its own Rotary Setup profile (the chuck action
uses chuck math, the roller action roller math), and only enabled fixtures are listed. Both carry
the same **Rotary** section above their content:

- **Part Diameter / Max Split Size / Number of Splits / Overlap** — the job's own values, saved
  with the project and set **once for the whole action** in the Rotary section that sits above
  the layers: one part per action, shared by everything the action marks. Values pre-fill from
  the Rotary Setup defaults when the action is created; fields with no default start blank.
  **Diameter, a split, and overlap are required** — the run and trace are blocked, with a message
  naming the missing field, until they're entered (an overlap of 0 counts as entered). Different
  actions (or different projects) can target different parts without touching the device setup.

    **Number of Splits is per revolution.** The part is divided into exactly that many strips —
    24 splits is 15° each on any diameter — with the grid starting at your artwork, so nudging the
    art moves the whole result round the part without re-cutting a single seam, and a full wrap
    closes on a seam. Strips that hold no artwork are simply skipped: a 90° logo on 24 splits marks
    6 of them. Numbers that divide 360 (24, 36, 12…) give whole-degree strips.

    **One box, two ways to fill it.** The dropdown beside the box chooses whether you are entering
    a **Max Split Size** or a **# of Splits**; switching it just shows the other value. Type a Max
    Split Size and FocuZ works out the fewest splits per revolution whose band (strip plus overlap)
    fits inside it; type a # of Splits and the size becomes the width that number gives. Changing
    the diameter or the overlap never changes a number you've chosen — the size follows it.
    Projects made before the count existed carry only a size and keep marking exactly as they did;
    enter a number (or retype the size) to move them onto the per-revolution grid.

    Below the fields, a readout shows what those values actually produce:

    ```
    C 40.527 mm · 1 step 2.53 µm · art wraps 337.6°
    15° per split · 23 of 24 marked · 666–667 steps (±1)
    ```

    **C** is the part's circumference, and **1 step** is how far the surface moves per motor
    step — the finest seam placement the rotary can manage on this part. **art wraps** is how
    far your artwork reaches around the part: `360.0° ✓` means it closes exactly, and anything
    past a full turn is flagged. The second line is the split itself — how many **degrees** of
    the part each split covers, how many of the splits actually mark, and how many motor steps
    the part turns between them (a range marked *seam-aware* means seams have shifted into gaps
    in the artwork). The count and size themselves sit in the split row above, so they are not
    repeated here. A band wider than the lens field, or wider than your Max Split Size, is
    flagged here too — the job is held until the field limit is met.
- **Start Offset** — optional, in part degrees: rotates the whole job's starting orientation
  on the part without changing the rotary's Set Zero position. Handy for marking at a specific
  clock position, or spacing repeat jobs around the same part. 0 (or blank) = none; Return to
  0 still returns to the true zero.
- **Sublayers on the rotary** — a **Mark** or **Groove** sublayer runs on every split, right after
  its parent's pass on that split. A **Jog** or **Terminal** sublayer runs once per **wrap**, after
  the pass it is attached to has completed all the way round the part. A sublayer's Repeat is how many times it runs each
  time it fires, exactly as on a flat layer, and never adds wraps.

Rotation axis, mode, motor settings, and the split-quality options still come from Rotary Setup — the
action carries only the job values. Because rotary is per-action, nothing is left switched on
afterward — other actions and later jobs are unaffected.

## The 2D Grid action

**2D Grid (Chuck)** (Sequencer › Marking › Rotary) is 2D Rotary with every split divided into a
grid of cells shared between two sets of settings — for checkerboard textures, comparing two
settings side by side around a part, or simply spreading heat by marking a split cell by cell
instead of all at once.

It reads like 2D Rotary:

| Shown as | What it is |
|---|---|
| **Rotary** (the panel on top) | The part: Part Diameter, splits, Overlap, Start Offset — and a **Repeat** that runs the whole action again. |
| **Group** (inside it) | Holds the grids. Its **Repeat** sends them round the part again; **+ Layer** adds another grid. |
| **Layer 1**, **Layer 2**, … | One grid each: its artwork, its cells, and a **Repeat** that marks it again on the split. |
| **Grid 1.1** and **Grid 1.2** | The two halves of Layer 1's checkerboard, each with its own settings. A renamed half reads **1.1 Logo**. |

- **Several grids in one action.** **+ Layer** on the Group's header adds another grid — Layer 2 with
  Grid 2.1 and 2.2 — with its own artwork and its own cells, order, link and padding. They all
  share the part values at the top. On each split every grid marks in turn — Layer 1, then Layer
  2 — before the part turns. To finish one grid all the way round before the next starts, put
  them in separate actions.
- **Content belongs to the grid.** The Content section sits at the top of each layer: import, size,
  location and transform apply to both of its halves. Below it, **Link Layers** (on by default)
  keeps the second half collapsed and gives it every setting of the first. Turn it off to open the
  second half and give its cells their own power, speed, fill and so on; turn it back on and it
  follows the first half again.
- **X # of Cells / Y # of Cells** divide each split. Along the wrap the cells are equal in
  **degrees**, so the grid is even around the part; along the rotation axis they are equal in
  **mm**, with the cell size to 5 decimals and the last row taking the remainder up to the edge of
  that grid's art. Beside each box the cell's size on that axis is shown — mm around the part for
  the wrap axis, mm of distance for the other — to three decimals, with a `~` when the true value
  has more. The readout adds a line with the cell size in degrees, and **Show splits on canvas**
  draws the cells inside the seams.
- **Cell padding** leaves an unmarked gap between cells — for melt pools or any breathing room you
  want. Every cell edge pulls in by half the padding, seams and the outer edges of the art
  included, so the gap is the same everywhere around the part, including where the wrap closes at
  360°. With a padding set, the seam Overlap and Stitch options do not apply to that grid (the
  padding is the gap); the Overlap box grays once every grid in the action has a padding. The
  canvas draws each padded cell as its own rectangle, and the cell-size labels add how much of
  each cell is marked.
- **Cells alternate between the two halves** in both directions — the upper-left cell of the first
  split is Grid 1.1 — and the pattern carries on across the seams, so an odd cell count still
  checkerboards. If the count around a fully wrapped part is odd the pattern cannot meet itself;
  the readout says so.
- **Marking order** is per split and always starts at the split's upper-left cell. **X First**
  marks left to right, then the next row down; **Y First** marks down the column, then the next
  column; **X Checker** and **Y Checker** mark every cell of the first half in that sweep, then
  every cell of the second. Each cell is finished before the next begins, and a grid's whole split
  streams as one pass, so the split timing matches 2D Rotary.
- **Repeats.** The halves have no Repeat of their own. A **Layer's Repeat** marks that grid again
  on each split; the **Group's Repeat** sends the grids round again and the **Rotary** panel's Repeat
  runs the whole action again — the same rule as every rotary action (see *Multi-pass rotary jobs* above). Clearing a half's Mark checkbox drops
  its cells. A grid's halves take no sublayers and Variation is not offered on a grid; the **Group**
  can carry [group sublayers](#group-sublayers). Importing a file with several
  layers asks which of them to bring in — all by default — and puts the chosen ones together into
  that grid.
- **Each half's eye shows its own cells.** With both eyes on the canvas shows the whole art as
  imported; hide one half and only the other's cells of the art remain, so you can see the
  checkerboard each will mark. Each half's fill preview is clipped to its own cells the same way.
  In the layer tree the shared art is listed after the two halves, since both mark it.

## Placing more than one piece of art

Position along the wrap direction is **absolute**: where art sits on the canvas is where it
lands on the part, measured around the circumference from the rotary's zero position. Moving a
piece of art along the wrap axis moves it *around the part*; moving it along the other axis
moves it along the part's length. That means two pieces of art always land in the same places
on the part no matter how you organize them — but *how* they mark differs:

| | Same layer | Two layers, one action | Two 2D Rotary actions |
|---|---|---|---|
| **Revolutions** | One | One — all of an action's layers share the same part values, so they share the revolution | Two — each action runs all of its splits before the next begins |
| **Splits & seams** | One split plan across the combined artwork | Same combined plan — seams line up for both pieces | Each action plans around its own artwork — seams fall in different places |
| **Position on the part** | Absolute — identical in all three arrangements | Same | Same |
| **Where filled shapes overlap** | Overlapping areas cancel to unfilled (with the default Even / Odd fill grouping) | Each layer fills independently — the overlap is **marked twice** | Marked twice |
| **Where outlines overlap** | Both mark, on top of each other | Same | Same |
| **Marking settings** | One set shared by everything in the layer | Independent per layer | Independent per layer |
| **Marking order** | All content together, split by split | Layer order *within* each split, then the part rotates | The first action completes entirely, then the second runs |
| **Fit circumference** | Fits the combined width of all the layer's art | Fits each layer's own art | Fits each layer's own art |

!!! tip "Which arrangement to use"
    Use the **same layer** when the pieces share settings and you want one revolution.
    Use **separate layers** for per-piece settings while keeping one revolution and aligned
    seams. Use **separate actions** only when the jobs must be sequenced independently — for
    example with a jog or an operator prompt between them — at the cost of a second revolution
    and seams that don't line up between the two.

Nothing warns about overlap: overlapping art simply marks as the table describes. Artwork that
reaches more than a full circumference **is** flagged in the Rotary readout
(`art wraps 395.9° ⚠ over 360°`) and still marks — everything past a full turn wraps onto
whatever already occupies that angle. The preview shows the true result either way.

## Previewing splits

In the [Preview](marking-tracing.md) of a 2D Rotary action, a vertical **split slider** appears
beside the playback slider, with one stop per split:

- By default the preview shows **one split at a time**, centered in the canvas — exactly the
  strip the galvo will see. Move the slider to step through the splits.
- The horizontal playback slider and the split slider follow each other: scrubbing playback
  advances the split; picking a split jumps playback to that split's beginning.
- The **All** button shows every split at once at its true position instead.

Seam-aware splits and arc compensation show up in the preview exactly as they will mark.

## Sublayers in rotary jobs

Sublayers fire at the same points as in flat marking — after the parent pass that **Run every**
names — but on the rotary each firing is a whole trip around the part rather than something that
happens on every split:

- A **Mark** or **Groove** sublayer takes its own revolution: once the parent's pass has gone all
  the way round, the sublayer goes all the way round, marking its **Repeat** passes back to back on
  each split. Tick **Per split** in the sublayer's header to weave it into the parent's revolution
  instead — on each split, right after the parent pass that fired it, while that strip is still
  under the lens (for a groove or cleanup pass that should follow the parent immediately).
  **Groove** (the rotary name for the Cut mode) marks its offset band clipped to each split — it is
  for grooving and deep engraving around the part, sectioned by splits like all rotary content, and
  is not a tube through-cutting mode.
- A **Jog** or **Terminal** sublayer fires once per wrap, between revolutions — a Z step is a
  whole-part event, so it never repeats on every split.

A layer runs all of its own passes in one revolution, so its sublayers follow that
revolution in pass order — the same number of firings Run every would give pass by pass.

### Group sublayers

On **2D Rotary** and **2D Rotary (Roller)** a sublayer can also be attached to a **group**: press
**+ Sublayer** on the group's header. A group sublayer is listed at the bottom of the group, below
its layers, and runs **after** them — per revolution, never on each split:

- **Mark** takes its own trip round the part with its own settings. It has no artwork of its own;
  its **Source** says what it marks:

    | Source | What it marks |
    |---|---|
    | **Each layer** | every layer of the group in turn, each inside its own border |
    | **Boundary** | one region around all of the group's artwork — overlapping art is marked once, and enclosed areas that are not artwork stay clear |
    | *a layer's name* | that layer's artwork; it follows the layer if you move, resize or rename it |

- **Jog** or **Terminal** fires once, between revolutions — the place for a Z step.
- **Run every** counts runs of the **group**, and keeps counting across the group's Repeat and the
  Rotary panel's Repeat: with Run every 2 it runs after the 2nd, 4th, 6th time the group goes round.
- **Repeat** is how many passes it marks on each split during its revolution.

If the layer a group sublayer points at is deleted, the Source shows it as missing and Run and Trace
stop until you pick another — it is never switched to a different layer for you.

**+ Group** sits on the Rotary panel's header on these actions.

#### On the 2D Grid action

The **Group** header of a [2D Grid](#the-2d-grid-action) action carries **+ Sublayer** as well. A
group sublayer sits at the bottom of the Group, under the last grid, and runs after the grids have
gone round — every **Run every** revolutions of the Group. Its **Source** lists the grids by the
names you see on screen (**Layer 1**, **Layer 2**, …) in place of layers.

A **Mark** group sublayer here is a small grid of its own. Under the Source it has its own
**Link halves**, **X # of Cells**, **Y # of Cells**, **Cell padding** and **Marking order**, and it
marks its source as its own checkerboard, split by split:

- With **Link halves** on, both halves of its checkerboard use the sublayer's settings.
- With it off, a second panel appears directly under the sublayer holding the second half's
  settings, starting as a copy of the first.
- Its cells do not have to match the cells of the grids it marks over.

**Jog** and **Terminal** work as above: once, between revolutions.

## Variation in rotary jobs

[Variation](sequencer.md#variation) is worked out on the whole design, not per split: a Layer or
Fill ramp runs once across the entire wrap, a Segment or Chord ramp continues through a seam on
the far side exactly where it left off, and Quadrant tiles are the design's tiles regardless of
where the seams fall. Nothing restarts at a split.

## Chuck vs. Roller

Each is a **fixture profile** in Rotary Setup with its own action:

- **Chuck** — the part is gripped and rotated directly. One motor rotation (through the gear
  ratio) is one part rotation, regardless of part size. Backlash compensation lives here.
- **Roller** — the part rests on powered rollers. The rollers move the *surface*, so surface
  travel depends on the roller diameter, and how far the part turns depends on both diameters.
  Enter the part diameter and the roller diameter and FocuZ handles the conversion.
- **Turntable** — a profile for a part that spins about the beam axis; its motor settings drive
  the **Rotary Jog** action today, and its marking action is on the roadmap.

## Rotary Jog

**Rotary Jog (BJJCZ)** (Sequencer › Motion) turns the part as a step inside a sequence — between
marks, or to present the next face. Choose the **fixture** (its profile's motor settings apply),
**Rotation (degrees)** or **Distance (mm)** of part surface, the direction, and the amount. A
distance needs the part's diameter — enter it on the action, or leave it blank to use the
profile's Part Ø default. The live jog buttons on the Jog card have the same fixture choice.

## See also

- [Hardware & Device Setup](hardware-setup.md) · [The Sequencer](sequencer.md) ·
  [Marking & Tracing](marking-tracing.md)
