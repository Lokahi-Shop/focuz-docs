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

## Undo / Redo

**Undo** (`Ctrl+Z`) and **Redo** (`Ctrl+Y` / `Ctrl+Shift+Z`) cover sequence and parameter edits — adding and
deleting actions/layers/sublayers, parameter changes, object transforms, and arrow-key nudges.

## Preferences (Edit ▸ Preferences)

- **Nudge step sizes** — the arrow-key move distances (with modifier variants).
- **Allow multiple layer selection and manipulation** — off by default (one layer at a time; typing into a
  layer's fields selects that layer). On: the layer tree is the main selection tool — select across layers,
  edit their combined Size / Location; clicking or typing in the sequencer never changes the tree selection.
- **Log** — the rolling log line cap, and a button to clear the log.
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
