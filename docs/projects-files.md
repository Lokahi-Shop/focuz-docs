# Projects & Files

Save and reopen your work as **`.focuz`** project files, and set editor preferences.

## Projects

From the **File** menu:

- **New** (`Ctrl+N`), **Open** (`Ctrl+O`), **Save** (`Ctrl+S`), **Save As** (`Ctrl+Shift+S`).
- **Recent Files** — quick access to recent projects (with a *Clear Recents* option).
- FocuZ prompts you to save **unsaved changes** before closing or opening another project.

A `.focuz` project stores your sequence — groups, layers, sublayers, actions, and their parameters.
Each saved project also records the FocuZ version that wrote it, as do Library entries and settings
exports — useful when you send a file in for support.

### Embedding imported art

When saving, you can **embed** imported files in the project so it's self-contained and travels with the
`.focuz` file. Without embedding, the project references the original files and FocuZ will prompt to
**relink** them if they've moved when you reopen it.

!!! note "Lens check on open"
    If a project was made with a different lens than the one currently active, FocuZ warns you — the project
    still opens, but double-check the correction/field size match your setup before marking.

### Projects from earlier versions

When you open a project saved by an earlier FocuZ, it is brought up to date for you:

1. FocuZ converts it to the current format and **checks** it: nothing has moved, every layer will stay
   where it is on its next edit, and everything it refers to still exists. Anything with a known right
   answer is corrected (for example *"Layer 1 (model.stl): placement updated"*).
2. The **original is backed up**, and the converted project is saved under its own name. A message says
   *"Older FocuZ format detected. Conversion to the new format complete. The original was backed up."*
3. If the project's folder can't be written to, **Save As** opens so you can save it somewhere else. Run
   and Trace stay locked until it is saved.
4. If something can't be corrected automatically, the original is left untouched, the message lists what
   needs your attention, and **Run and Trace stay locked** until it is fixed and saved. (The first save
   backs the original up before it is replaced.) If you have checked the listed items yourself, answer
   **Yes** to *"Allow marking anyway?"*.
5. Items on **rotated** layers are shown as *"Please check"* notes and don't lock marking.
6. If a layer's **Size and Location** can't be converted, they're cleared: the boxes are empty and red. Type the
   correct values again — Run and Trace wait for them (the empty boxes are saved with the project).

**Rotary projects saved before 2026-08-13** can't be opened — rebuild the job in the current version. Rotary projects
saved since then open as usual.

Every open is checked this way, so a damaged file (for example a cloud-sync conflict copy) is caught too.

**Projects from a newer FocuZ** are not opened: you're asked to update FocuZ first — the message has a
**Check for updates** button. Keep every computer you use with FocuZ on the same (current) version.

**Where the backups are**

- **Projects:** the `converted` folder inside the FocuZ install folder, normally
  `%LocalAppData%\FocuZ\converted`. If FocuZ was installed for all users (under Program Files, which
  can't be written to), they go to `%LocalAppData%\FocuZ\converted` instead.
- **Library templates:** `%AppData%\FocuZ\library\converted`.

Each backup is named after the original with the old format number, the date and time, and a short code
for the folder it came from, for example `Coaster.focuz.s2.20261007-153012.3f9a.conv_bak` (so two
`Coaster.focuz` files from different folders are told apart). `index.txt` in the same folder lists each
backup with the full path of the original. Backups are never overwritten and never appear in Recent Files.
Uninstalling keeps them, unless you choose to remove your settings and data.
To use one, copy it out and rename it back to `.focuz` (or `.focuzlib` for a template); an older FocuZ will
open it as it was.

**Library templates** from an earlier version are converted the same way the first time the Library
opens, with one summary message. A template that needs attention is marked and can't be inserted or used
for Replace until you review it. Templates from a newer FocuZ are marked too, and can't be used or changed
until FocuZ is updated. **Rotary templates from before 2026-08-13** are marked and can't be used — rebuild them.

> Projects saved by this version should not be opened in FocuZ 26.10.01.01-rc or earlier: those versions
> read 3D model placement differently.

## Undo / Redo

**Undo** (`Ctrl+Z`) and **Redo** (`Ctrl+Y` / `Ctrl+Shift+Z`) cover sequence and parameter edits — adding and
deleting actions/layers/sublayers, parameter changes, object transforms, and arrow-key nudges.

## Preferences (Edit ▸ Preferences)

- **Nudge step sizes** — the arrow-key move distances (with modifier variants).
- **Allow multiple layer selection and manipulation** — off by default (one layer at a time; typing into a
  layer's fields selects that layer). On: the layer tree is the main selection tool — select across layers,
  edit their combined Size / Location; clicking or typing in the sequencer never changes the tree selection.
- **Log** — the rolling log line cap, and a button to clear the log.
- **Canvas preview ▸ Solid fill below spacing (mm)** — default **0.05**. Fills spaced below this show on the
  canvas as a solid area instead of lines ([what you see](canvas.md#what-you-see)); **0** always shows the lines.
  Range 0 – 10 mm. It changes the screen only, never what marks.
- **Layout** — layer-panel docked vs. overlay.

The motion controller's **After a run, set positioning mode (G90/G91)** setting is in **Device ▸ Laser Setup**, under
**Motorized Axis (FocuZ controlled)** — see [Distance mode](jog-terminal.md#distance-mode-g90-g91).

## Number format

FocuZ uses **US number format** on every PC: decimals are entered and shown with a **dot** (`12.5`).
If Windows is set to a different regional format, FocuZ tells you once at start-up; the numeric
keypad's decimal key types a dot automatically. To ask for your region to be supported, email
[info@lokahi.shop](mailto:info@lokahi.shop).

Number fields in sequencer actions and the Test Grid (delay, feedrate, rotary angle and part
diameter, grid size and spacing…) take **digits and a decimal point only** — other characters are
ignored as you type, and a paste that isn't a plain number is refused. Text fields such as names,
labels and command boxes accept anything.

If an earlier version saved values with a decimal comma (for example a lens height of `12,5`),
FocuZ converts them to the dot form. Before it changes anything it makes a copy — of your settings,
or of the project you opened — in `%AppData%\FocuZ\backups`, and it shows you a list of every value
**before → after** together with where that copy is. Check the list; a project file keeps its old
values until you save it.

## See also

- [The Sequencer](sequencer.md) · [Importing Geometry](importing.md) · [Reference](reference.md)
