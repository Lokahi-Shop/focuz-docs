# The Settings Library

The Library stores your proven marking settings as reusable **templates** and moves them between
jobs. Open it from the **Library** menu — it's a floating window, so the Sequencer stays live
behind it while you compare and apply settings.

The window has three columns:

- **Sources** (left) — your saved templates, or another project file to borrow from.
- **Template settings** (middle) — the full breakdown of the selected source.
- **Current file** (right) — the job that's open right now, as the target.

![TODO screenshot: the Library window with a template selected](assets/library-overview.png){ .screenshot }

Templates carry **settings only** — speeds, powers, fills, timings, structure — never artwork.
Your imported geometry always stays with the project.

## Saving templates

- **Save as Template…** (under the Current file column) captures the selected action's whole
  configuration — every group, layer, and sublayer with all their settings — plus a name, notes,
  and an optional reference image. The template remembers which **action type** it came from
  (2D Import, 2D Cut, 3D Slice, …).
- A template can hold **several actions**: with a template open, **+ Act ▾** in the middle column
  adds another action of your chosen type, so one template can describe a whole job.
- Manage templates from the list: **Duplicate**, **Rename**, **Delete**, and **Lock** (🔒 makes a
  template read-only so a good recipe can't be edited by accident — duplicate it to iterate).
- Templates live on your machine, outside any project — they're available in every job.

## Borrowing from another project

Switch the sources column from **Templates** to **Files (.focuz)** to open one of your recent
project files (or **Browse…** for any other). Its actions appear read-only in the middle column,
and you can push or pull from them exactly like a template — handy for "grab the settings from
that job last month" without saving a template first.

## Reading the breakdown

The middle and right columns show settings the same way the Sequencer does — same names, same
choices — and only show the settings that are **in use**: pick the Snake fill and you'll see its
settings, not Thatch's; a 2D Cut layer shows its cut band and tabs, not 3D slice settings. A
template opens fully expanded; click the ▶/▼ arrows to collapse sections.

Templates are editable in place — change values, then **Save** or **Revert** in the header.
Locked templates and browsed project files are view-only.

## Comparing and pushing settings

Selection is how you say *what* to push:

- Click a **heading** (an action, group, layer, or sublayer) to select everything under it.
- Click individual **setting names** to select just those. **Ctrl+click** a heading adds or
  carves a branch — e.g. a whole layer *minus* one sublayer.

Then click a target in the **Current file** column. The comparison lights up immediately:

- Each heading shows **✓** when everything selected matches, or **≠ N** counting the differences
  underneath it (collapsed sections can't hide a mismatch).
- Rows that differ are marked **≠** — those are *exactly* the settings a push would change, and
  hovering one shows the incoming value.

**Push to current ▸** applies the selection: matching settings are updated, missing groups,
layers, or sublayers are **added**, and nothing is ever deleted. Every push is a single undo
step — Ctrl+Z restores the job *and* any affected canvas art.

A couple of guardrails:

- **Action to action needs matching types.** A 2D Cut template won't push onto a 3D Slice action
  — the hint line explains why and what to pick instead.
- **Converting a sublayer's mode is all-or-none.** Pushing a Mark sublayer onto a Jog sublayer
  requires selecting all of its settings (a clean conversion) — partial pushes onto a different
  mode are blocked.

## Pulling and reshaping the job

- **◂ Pull** adds the selected source action to your job as a **new action** — correct action
  type, all settings applied, one undo step.
- The Current file column's **+ Act ▾ / + Grp / + Lyr / + Sub / Del** buttons add and remove
  actions, groups, layers, and sublayers in the live job without leaving the Library — all
  undoable.

## Timings and the delay/jump toggle

The **Include delay and jump parameters** checkbox (above the template settings, default **off**)
decides whether timing travels with a push:

- **Off** — timing is entirely the current job's business: Timing Mode and the delay/jump
  settings are hidden on the template side and a push never touches them.
- **On** — the template's Timing Mode travels. A **Custom** template brings its exact delay and
  jump values; a **Device** template tells the target to use the machine's own tuned timings.

!!! tip "Device timing makes templates portable"
    Save templates with Timing Mode = **Device** when the recipe should work on more than one
    machine — each laser then marks with its *own* calibrated delays. Use **Custom** only when
    the exact microsecond values matter more than the machine.
