# The Settings Library

The Library stores your proven marking settings as reusable **templates** and moves them between
jobs. Open it from the **Library** menu — it's a floating window, so the Sequencer stays live
behind it while you compare and apply settings.

The window has three columns:

- **Sources** (left) — your saved templates, or another project file to borrow from.
- **Template settings** (middle) — the full breakdown of the selected source: what's on offer.
- **Current file** (right) — the job that's open right now: what will change.

Above the panes sits the **mode selector** — **Update · Insert · Replace** — which picks what
the Library does with your selection:

| Mode | What it does |
|---|---|
| **Update** | Copies **values** onto settings the job already has. Nothing is added or removed. |
| **Insert** | **Adds structure** from the template — sublayers, layers, groups, or whole actions. Nothing existing is touched. |
| **Replace** | **Swaps one node for another**, in place — same spot, new recipe. |

![TODO screenshot: the Library window with the mode selector](assets/library-overview.png){ .screenshot }

Templates carry **settings only** — speeds, powers, fills, timings, structure — never artwork or
part data. Your imported geometry always stays with the project, and anything inserted or
replaced arrives with its rotary part values unset, so the run check reminds you to enter *your*
part before marking.

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
and every mode works from them exactly like a template — handy for "grab the settings from that
job last month" without saving a template first.

## Selecting — the same gestures everywhere

Both panes select the same way, and clicking anywhere in a pane makes it the **active** one
(it draws a highlighted border; **Ctrl+A** and **Esc** act on the active pane):

- **Click a heading** (action, group, layer, sublayer) to select everything under it.
- **Click a setting's name** to select just that setting. The **value** next to it is for
  editing (templates are editable in place — change values, then **Save** or **Revert**).
- **Ctrl+click** toggles one item in or out — carve a sublayer out of a selected layer, or add
  one more setting.
- **Shift+click** extends across same-kind neighbours — three layers in a row, or a run of
  settings inside one section.
- **Ctrl+A** selects everything in the pane; **Esc** clears it.

Selections persist when you switch modes — each mode simply grays what it can't use. Rotary part
values are never selectable: they describe your physical part, not the recipe. A sublayer's
**Mode** row isn't individually selectable either — changing what a sublayer *is* belongs to
Replace.

## Update — copy values onto matching settings

Update is deliberate: you select **what's on offer** on the left and **what will change** on the
right, and the two selections must line up perfectly before the button arms.

- Each selected setting needs its counterpart selected on the other side. A selected row with no
  matching selection turns **gray** — the gray rows are your to-do list, and the hint line names
  them. Select the counterpart, or deselect the row, and the gate opens.
- Headings pair by position: Layer 2 on the left updates Layer 2 on the right. Action types must
  match, and sublayers pair with sublayers of the same mode.
- Settings can also pair **across kinds** by name — select `Power` on a sublayer and `Power` on
  a layer, and the value flows across.
- The comparison lights up while you work: **✓** on a heading when everything selected matches,
  **≠ N** counting differences, and hovering a ≠ row shows the incoming value. The markers show
  only while exactly one clean pairing exists.
- **Changing a fill** through Update selects the new fill's own settings automatically and locks
  them — they travel with the fill. Settings on the target that the new fill removes show in
  *red italics*; if one of them is selected, Update stays blocked until you deselect it, so
  nothing disappears without you seeing it.

**Update current ▸** applies the values — nothing added, nothing deleted, one undo step.

## Insert — add structure from the template

Insert copies **whole nodes** into the job:

- Select whole sublayers and a **layer** on the right, whole layers and a **group**, or whole
  groups and an **action** — **◂ Insert** appends them after what's already there. Names come
  along; nothing existing moves.
- Select whole **actions** (or use Ctrl+A) with nothing chosen on the right, and they're
  appended to the job as new actions.
- Carving is allowed — a layer minus one sublayer inserts without it — but a *partially*
  selected node blocks with its name: Insert copies whole nodes or none.
- Containers that can't legally take your selection gray out, and their tooltip says why —
  a grayed row is exactly the error you'd otherwise hit on apply.
- If a value lands outside what the target machine allows, it's clamped — and the confirmation
  preview says so before you commit.

## Replace — swap a node, keep its place

Replace exchanges one node for another, exactly where it stands:

- Select **one whole node** on the left and one of the **same kind** on the right. The whole
  outgoing subtree previews in *red italics* so you can see everything the swap removes.
- Actions swap type-free — this is how a slot is re-made from a template of a different type.
  Groups and layers need matching action types. Sublayers may change mode through Replace (this
  is the one place mode conversion lives), as long as the target action supports that mode.
- **Replace ▸** performs the swap behind a preview, as a single undo step — undo restores the
  old node *and* any canvas art it owned.

## Removing several things at once

Select any mix of actions, groups, layers, and sublayers in the Current file column and press
**Del** — everything selected goes in one batch, and one Ctrl+Z brings it all back. The Library
keeps at least one group per action and one layer per group; a batch that would empty one is
blocked before anything happens. The **+ Act ▾ / + Grp / + Lyr / + Sub** buttons still add
structure to the live job, all undoable.

## Timings and the delay/jump toggle

The **Include delay and jump parameters** checkbox (above the template settings, default **off**)
decides whether timing travels:

- **Off** — timing is entirely the current job's business: Timing Mode and the delay/jump
  settings are hidden on *both* sides and never move.
- **On** — the template's Timing Mode travels. A **Custom** template brings its exact delay and
  jump values; a **Device** template tells the target to use the machine's own tuned timings.

Flipping the toggle starts both selections over — the visible settings are the coordinate
system, so they reset together.

!!! tip "Device timing makes templates portable"
    Save templates with Timing Mode = **Device** when the recipe should work on more than one
    machine — each laser then marks with its *own* calibrated delays. Use **Custom** only when
    the exact microsecond values matter more than the machine.
