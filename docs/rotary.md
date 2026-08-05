# Rotary Marking

Mark cylindrical parts — tumblers, rings, shafts, pens — by rotating the part between marking
passes. The galvo can only mark a flat window at a time, so FocuZ wraps your artwork around the
part in **splits**: it marks one strip, rotates the part, marks the next strip, and so on until
the whole design is on the surface.

Rotary marking always runs through the [**2D Rotary** action](#the-2d-rotary-action) in the
Sequencer — the action carries the job's part and split values, so nothing has to be switched
on or off app-wide. The rotary hardware itself (motor, mode, axis) is configured once under
**Device ▸ Rotary Setup**.

![TODO screenshot: the Rotary Setup dialog](assets/rotary-setup.png){ .screenshot }

## Rotary Setup

### Settings

- **Invert Direction** — flip the rotation direction for both jogging and marking.
- **Return to 0** — rotate back to the zero position when the job finishes (on by default).
  If a run is interrupted — cancelled or stopped for any reason — FocuZ always returns the
  rotary to zero so the part is never left at an arbitrary angle.
- **Mode** — **Chuck** grips the part and turns it directly; **Roller** turns the part by
  spinning drive rollers underneath it (see [Chuck vs. Roller](#chuck-vs-roller)).
- **Axis** — which axis of the artwork wraps around the part (X or Y). Match it to how the
  rotary sits under the laser.
- **Gear Ratio** — the drive ratio between motor and part, as *n* : 1. At 1 : 1 the motor's
  Steps/Rot is the part's steps per rotation; a 2 : 1 reduction means the motor turns twice
  per part rotation.
- **Roller Ø** — in Roller mode, the drive rollers' diameter. Surface travel follows the
  roller, so both diameters matter: the part diameter for wrapping the artwork, the roller
  diameter for the motion math.

### Part (defaults)

- **Diameter** — a *default* part diameter for new 2D Rotary actions. Leave it blank if every
  job is a different part — each action carries its own diameter either way.

### Split

- **Size (default)** — a *default* strip width for new 2D Rotary actions, in mm of part
  surface. Smaller splits stay closer to the laser's focus and the field's sweet spot; larger
  splits mean fewer seams and faster jobs. Keep the strip shallow enough that its edges are
  still within your focus tolerance.
- **Overlap (default)** — a *default* overlap between neighboring strips, in mm. A little
  overlap can hide seam lines in fills.

The three defaults only pre-fill a new 2D Rotary action's fields; a blank default leaves the
action's field blank until you enter it there.
- **Overlap fills only (outlines marked once)** — with an overlap set, fills keep the overlap
  but outlines are trimmed to the exact seam, so outline strokes are never double-marked. Use
  this when overlap helps your fills but doubles up your outlines.
- **Seam-aware splits (seams avoid geometry)** — lets each seam shift a little (up to about a
  quarter of the split size) to land in the widest nearby gap in the artwork, so seams fall
  *between* letters and shapes instead of through them.
- **Arc compensation (correct curvature per split)** — the laser projects each strip onto a
  flat plane, but the part surface curves away from it, so marks land slightly stretched near
  the strip edges. Arc compensation pre-corrects for the curvature so design distances land as
  true on-surface distances. The effect grows quickly with split size — it's what keeps
  geometry true when you use large splits, and it lets you size splits by focus alone.

Splits are always distributed evenly across the artwork, so the last strip is the same size as
the rest — no thin leftover strip at the end. Before the first strip, the rotary takes up gear
backlash by overshooting slightly and approaching from the marking direction, so the first seam
lands exactly where it should.

### Motor

- **Steps/Rot** — motor steps per motor rotation (combine with Gear Ratio for the part).
- **Ramp Min / Max Speed** — each rotation ramps from Ramp Min up to Max Speed, in
  pulses/sec. Ramp Min is the starting speed, not a limit — a heavy chuck or part may need a
  lower one to start smoothly without losing steps; a light setup can start faster.
- **Accel** — acceleration ramp time, in ms.
- **Return Spd** — speed used when returning to zero.

### BJJCZ Controls

Live rotary motion for setup, available while the controller is connected: jog **CCW / CW** by
the **Jog Dist** angle, **Set Zero** to define the current position as zero, and **Go to Zero**
to rotate back to it at the Return Spd — with a live position readout.

**Import Rotary from markcfg7…** pulls rotary parameters from an existing `markcfg7` file, the
same way as the main [device import](hardware-setup.md). The Device Setup window
([first-run setup](getting-started/first-run.md)) offers the same import in its Rotary Setup
section — including reusing the device's own `markcfg7` — so a rotary can be configured during
first run.

## The 2D Rotary action

The **2D Rotary** action (in the Sequencer's Marking group) is a 2D Import that marks through
the rotary engine — it's the one and only way a job runs on the rotary. It carries its own
**Rotary** section above its content:

- **Part Diameter / Split Size / Overlap** — the job's own values, saved with the project.
  They pre-fill from the Rotary Setup defaults when the action is created; fields with no
  default start blank. **All three are required** — the run and trace are blocked, with a
  message naming the missing field, until they're entered (an overlap of 0 counts as entered).
  Different actions (or different projects) can target different parts without touching the
  device setup.
- **Start Offset** — optional, in part degrees: rotates the whole job's starting orientation
  on the part without changing the rotary's Set Zero position. Handy for marking at a specific
  clock position, or spacing repeat jobs around the same part. 0 (or blank) = none; Return to
  0 still returns to the true zero.

Axis, mode, motor settings, and the split-quality options still come from Rotary Setup — the
action carries only the job values. Because rotary is per-action, nothing is left switched on
afterward — other actions and later jobs are unaffected.

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

Sublayers run inside each split, just as they do in flat marking — jog sublayers fire between
passes, and cut sublayers mark their bands clipped to the current strip.

## Chuck vs. Roller

- **Chuck** — the part is gripped and rotated directly. One motor rotation (through the gear
  ratio) is one part rotation, regardless of part size.
- **Roller** — the part rests on powered rollers. The rollers move the *surface*, so surface
  travel depends on the roller diameter, and how far the part turns depends on both diameters.
  Enter the part diameter and the roller diameter and FocuZ handles the conversion.

## See also

- [Hardware & Device Setup](hardware-setup.md) · [The Sequencer](sequencer.md) ·
  [Marking & Tracing](marking-tracing.md)
