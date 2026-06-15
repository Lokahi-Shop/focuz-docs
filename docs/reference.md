# Reference

Quick-reference material.

## Keyboard shortcuts

| Action | Shortcut |
|---|---|
| New project | `Ctrl+N` |
| Open project | `Ctrl+O` |
| Save | `Ctrl+S` |
| Save As | `Ctrl+Shift+S` |
| Undo | `Ctrl+Z` |
| Redo | `Ctrl+Y` (or `Ctrl+Shift+Z`) |
| Nudge selection | Arrow keys (step set in [Preferences](projects-files.md#preferences-edit-preferences)) |

*(More shortcuts will be added as they're confirmed.)*

## Supported file formats

| Kind | Formats |
|---|---|
| 2D vector | SVG, DXF, AI |
| 3D solid | STEP / STP |
| 3D mesh | STL, OBJ, 3MF |
| Images | common raster formats |
| Project | `.focuz` |
| Device profile | `markcfg7` (imported) |
| Lens correction | `.cor` (imported) |

## File & settings locations

FocuZ stores per-user settings and logs under **`%AppData%\FocuZ`**. The user log is a text file in that
folder — include it when contacting [Support](support.md). *(Exact filenames to be documented.)*

## Glossary

| Term | Meaning |
|---|---|
| **Galvo controller** | The BJJCZ board that steers and fires the laser. |
| **FocuZ:grbl controller** | The paired GRBL-based controller for X/Y/Z motion and accessory relays. |
| **`markcfg7`** | The device profile file (field size, axis mapping) imported to configure FocuZ. |
| **`.cor`** | A lens distortion-correction file (same format as EZCad2 / LightBurn). |
| **WCS** | Work Coordinate System — the work origin; FocuZ stores a WCS offset per lens. |
| **MPos / LPos** | Machine (absolute) position vs. the work position FocuZ derives from it. |
| **Fill** | The pattern used to engrave a closed area (line, Hilbert, snake, contour, thatch). |
| **Hilbert** | A space-filling curve used as a fill pattern. |
| **MO** | The laser's master oscillator (opened before firing). |
| **Trace** | The red-light, laser-off preview of where a job will mark. |

## See also

- [Troubleshooting & FAQ](troubleshooting.md) · [Support](support.md)
