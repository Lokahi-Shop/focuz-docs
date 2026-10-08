# Jog, Homing & Terminal

This section covers the **Jog** and **Terminal** screens and the **FocuZ:grbl controller** — the
motion-and-accessory controller FocuZ pairs with your galvo controller.

!!! info "What works today"
    **Rotary jogging works now** — it runs on your BJJCZ laser controller, so the Jog window's
    [BJJCZ Rotary](#bjjcz-rotary) strip and the **Rotary Jog (BJJCZ)** sequencer action need nothing
    extra. The **FocuZ:grbl controller is coming soon**: X / Y / Z motion, homing, the Terminal and the
    accessory relays described below light up once it's available and connected.

## The FocuZ:grbl controller

FocuZ uses **two** controllers that work together:

- the **galvo controller** (BJJCZ) steers the laser beam and fires it (see
  [Hardware & Device Setup](hardware-setup.md)), and
- the **FocuZ:grbl controller** — a custom GRBL build — moves the **X / Y / Z axes** (stage, gantry, or
  Z focus) and switches **accessory relays**.

FocuZ detects the FocuZ:grbl controller automatically when it connects (it identifies itself on the wire),
so the homing, jogging, and accessory features described here light up once it's connected.

!!! note "Two controllers, one job"
    The galvo marks; the FocuZ:grbl controller handles motion and accessories. A job can interleave both —
    for example, jog an axis, switch on air assist, mark, then switch it off. How they coordinate within a
    run is covered in [Marking & Tracing](marking-tracing.md).

## Jog

Open **Jog** from the menu. The Jog window gives you homing, axis control, and live position. It's a
separate window, so you can leave it open beside the canvas and keep working — close it with the ✕ or
reopen it from the menu at any time.

### Homing

- **Home X / Home Y / Home Z** home each axis independently; **Home All** runs them in sequence.
- **Home + X0 / Home + Y0** (under Home X / Home Y) home that axis and then move it to 0. X/Y 0 is the
  machine's 0: on an axis that homes toward +, that is right at the limit switch and can trip it.
  While they (or **Home + Jog Lens 0**) are moving, the jog pad and the lens dropdown are locked, and the
  Terminal only sends real-time keys (`?` `!` `~`) and `$G`. If the move to 0 is interrupted, FocuZ says so.
- Each axis tracks its own **homing status**. An axis must be homed for its absolute position to be
  trustworthy; homing is what establishes a known origin (by touching the limit switch).
- After an **alarm** (e.g. a limit hit) an axis loses its homed status and must be re-homed before its
  position is trusted again — see [Troubleshooting & FAQ](troubleshooting.md).
- **Z always homes upward.** Mount the Z limit switch at the **top** of travel (the Z+ end) so homing
  moves the head *away* from the work. FocuZ checks the controller's Z homing direction when it
  connects and keeps Z homing locked if it is set to home downward. X and Y may home in either
  direction.
- Every Z homing also resets the controller's Z work offset to zero, so FocuZ's saved lens heights
  always refer to the same place — whichever Home button or command you used.

!!! note "While a sequence is running"
    The **Jog** and **Home** buttons are grayed out while a sequence runs or is paused — a manual move
    in the middle of a run would change positions the run was checked against. They come back as soon
    as the run finishes or is cancelled.

!!! note "While an axis is homing"
    The **Run / Pause** button becomes **Cancel All** (red). A homing cycle can't be paused, so Cancel All
    resets the controller — that stops all motion and ends the sequence. FocuZ then unlocks the controller
    and asks you to home again before the next absolute move. While any axis homes — from a Home button, a
    Home action, or `$H` typed in the Terminal — the jog pad and the lens dropdown are grayed out, and the
    Terminal only sends real-time keys, `$G` and `$X`.

### Motorized axes (Enable X / Y / Z)

Tell FocuZ which axes it drives with the **Enable X / Y / Z** checkboxes — found on
**Device ▸ Connection** (below the FocuZ:grbl port selector) and in **Device ▸ Laser Setup**'s
**Motorized Axis (FocuZ controlled)** section (both show the same setting). Enabling an axis includes it in operations
that need confident absolute positioning and shows its jog controls and Home button here on the Jog
tab; a disabled axis is hidden. Whether a run requires a given axis to be homed depends on which axes
are enabled and what the job does.

The same Laser Setup section holds **After a run, set positioning mode (G90/G91)** — which mode the controller is left
in when a sequence finishes; see [Distance mode](#distance-mode-g90-g91).

!!! important "These axes move through the FocuZ:grbl controller"
    "Motorized Axis (FocuZ controlled)" means an axis FocuZ *itself* drives through the
    **FocuZ:grbl controller** (see [above](#the-focuzgrbl-controller)). Enable an axis only if that
    controller is connected and wired to move it. If you focus or position an axis by hand — a
    manual-focus knob, a fixed-focus lens, or a stage FocuZ doesn't control — leave it **off**; FocuZ
    won't try to home or move it.

All three axes are **off by default**. Your choices persist until you change them.

### Position & limits

- **MPos** is the machine (absolute) position; **LPos** is the work position FocuZ derives from it.
- Limit-switch status is shown per axis/direction so you can confirm switches before homing.

### Manual jogging

The **FocuZ (custom GRBL)** section is a directional pad: **Y+ / Y− / X− / X+** arranged as a cross, with
**Z+ / Z−** beside it. Set the **Step** (mm) and **Feed** for XY and for Z beneath their buttons,
then click to move by that step. Axes that aren't enabled in Device/Laser Setup show grayed out.
The **Feed** boxes take 100 mm/min up to your controller's **maximum rate** for that axis (`$110` X, `$111` Y,
`$112` Z; the XY box uses the lower of X and Y). A value outside that, or an empty box, is set to the nearest
limit when you leave the box, and jogs use the value shown.

These controls appear only while a FocuZ compatible controller is connected — every one of them
sends a jog, so without the controller the section shows a note asking you to connect one and the
window closes up around it. The **BJJCZ Rotary** strip below is never hidden: it runs on the laser
controller and simply grays out when the laser isn't connected.

- **Home & Jog to Lens 0** homes Z and moves to the active lens's saved focal height in one step — handy
  for getting straight to focus (see [Lenses, Corrections & Calibration](lenses-corrections.md)).

### BJJCZ Rotary

The Jog window's **BJJCZ Rotary** strip jogs the rotary axis (it runs on the laser controller, so
it's live whenever the laser is connected): jog **CCW / CW** by the set angle, **Set Zero** to
define the current position as zero, and **Go to Zero** to rotate back to it — with a live
position readout. To turn the rotary as a step inside a job, use the **Rotary Jog (BJJCZ)** action in
the Sequencer (see [Rotary Jog](rotary.md#rotary-jog)). See [Rotary Marking](rotary.md).

Like the Jog and Home buttons, **CCW / CW, Set Zero and Go to Zero are grayed out while a sequence
runs or is paused, and during a **Full** or **Single** red-light trace** — those turn a rotary part
themselves. **Hull, Perimeter and Area** traces never turn the part, so the strip stays usable
during them — handy for lining the part up while the outline is shown. The position readout
updates again when the run or trace ends.

!!! warning "How jogging really behaves (open-loop)"
    The FocuZ:grbl controller is **open-loop** and **queues** moves:

    - Clicking a jog button several times runs the jogs **one after another** — each click queues another move.
    - A move is "done" when the controller reports **Idle**, not when the axis is *confirmed* to have
      physically arrived. With no encoder, a stall, a disabled driver, or missed steps are **not** detected.
    - Positional confidence comes from **homing** (hitting the limit switch), not from per-move confirmation.

## Terminal

Open **Terminal** to talk to the FocuZ:grbl controller directly. Type a command, press Enter (or Send), and
the output window shows what you sent (`> …`) and the controller's replies. Use it to run G-code, check
status, or switch accessory outputs (below).

Like Jog, the Terminal is its own window and can stay open beside the canvas. Drag its edges to resize it —
the output area grows with the window so you can watch a long session, and the command box always stays
in view along the bottom.

### Commands FocuZ doesn't send

FocuZ works in one coordinate system (**G54**), in **millimetres**, and keeps every lens and fixture
offset itself. A command that would change that underneath it could move where FocuZ's own moves end
up, so the Terminal answers with a one-line reason and **does not send** it:

| Not sent | Why |
| --- | --- |
| `G55`–`G59` | FocuZ runs in G54 |
| `G10`, `G92`, `G43.1`, `G49` | FocuZ manages work offsets itself |
| `G20`, `G93` | FocuZ works in mm, at units-per-minute feed |
| `G2`, `G3`, `G38` | arcs and probing aren't supported |
| `$N…` (startup lines), `$C` (check mode) | not supported with FocuZ |
| `$23Z=1`, `$10` without machine position, `$13=1` | settings FocuZ depends on (Z homes up; status reports in mm with machine position) |

The same rules apply to **GRBL - Command** actions and **Terminal** sublayers: a job containing one of
these lines is stopped at **Run** with the line and the reason listed, so you can correct it.
In a job, homing (`$H…`) and controller settings are refused too — use a **Home** action to home. Everything
else — moves, `G53`, `G90` / `G91`, `$J=` jogs, M-codes, queries — is sent as typed. In the Terminal itself,
homing and the other settings are sent as typed.

Moves FocuZ makes itself (an Axis Jog, a Jog sublayer, Home + X0 / Y0, Home + Jog Lens 0, a Home action's
return to 0) run at your controller's **homing seek rate** (`$25`), so they suit your machine. They leave the
controller's G0/G1, feed and G90/G91 exactly as they found them.

### Feed rate on G1 lines

With a **FocuZ compatible controller**, the controller starts with **no feed rate** (F0) after connecting and after
every reset. Until you set one, a `G1` line without an **F** word is refused (`error:22`, undefined feed rate) — a
safety stop, so a slow cut never runs at a feed you didn't choose. Put an **F** on your `G1` lines (for example
`G1 X10 F500`) in the Terminal, in **Command** actions and in **Terminal** sublayers. `G0` rapids don't need one.
When you press **Run**, FocuZ checks the job's Command and Terminal-sublayer lines and lists any `G1` that would
be refused, so it's caught before the job starts rather than halfway through. It also lists any line with a
letter that has no number after it (for example the `X` in `G1 X F500`) — the controller would refuse that
whole line. A **Command** action left blank is fine: it sends nothing and the job carries on.

FocuZ's own moves (the Jog panel, Axis Jog, Jog sublayers, the Return and Home actions) always carry their own
feed, and they put the controller's G0/G1, feed and G90/G91 back the way they found them — so they never set a feed
for you, and never remove one you set.

### Distance mode (G90 / G91)

The small **G90 / G91** label beside the command box shows whether the controller is currently in
absolute (`G90`) or incremental (`G91`) mode; it shows **—** while disconnected.

- The mode is **yours**: type `G91` and it stays `G91` until you type `G90`. FocuZ's own moves (jog
  buttons, lens moves, sublayer jogs, return actions) leave it the way they found it.
- **Every sequence run starts in `G90`.** If a job needs incremental moves, put `G91` in the job
  itself (on the line, or earlier in the same Terminal block) — a `G91` typed before the run is not
  carried into it.
- After a run, the mode goes back to what it was before the run. To always finish in `G90` or `G91`
  instead, set **After a run, set positioning mode (G90/G91)** in **Device ▸ Laser Setup**'s **Motorized Axis (FocuZ
  controlled)** section: **As it was before the run** (default), **Absolute (G90)** or
  **Incremental (G91)**. The change applies as soon as you pick it.

### While a sequence is running

Only the status query `?` and `$G` (show current modes) are sent while a sequence runs or is paused.
Anything else is answered with "a sequence is running" and not sent. To stop a run, use **Pause** /
**Cancel** in FocuZ (or **Soft Reset**, which also cancels it).

## Accessory relays — air, vacuum & more

The FocuZ:grbl controller has several **auxiliary relay outputs** (switched 24 V / 5 V) you can wire to
peripherals — most commonly **air assist** and a **vacuum / extraction** fan, but any on/off accessory works.

Each output is switched with an **M-code**. You can send these:

- **manually**, by typing the M-code in the **Terminal**, or
- **as a job step**, with a **GRBL - Command** action in the [Sequencer](sequencer.md) — e.g. turn air on
  before a marking action and off after it, so it's automatic every run.

!!! example "Air assist around a mark (in a job)"
    1. **GRBL - Command** — switch the air-assist output **on**.
    2. **2D Import** (or **3D Slice**) — the marking action.
    3. **GRBL - Command** — switch the output **off**.

!!! warning "Confirm the codes for your wiring"
    Which M-code maps to which physical output (and therefore to air vs. vacuum) depends on how your
    controller is wired and configured. Test each output from the **Terminal** and label them before relying
    on them in a job. *(Exact output-code table to be documented for the standard FocuZ:grbl build.)*

## See also

- [Hardware & Device Setup](hardware-setup.md) — the galvo controller side.
- [The Sequencer](sequencer.md) — GRBL - Jog / GRBL - Command job steps.
- [Marking & Tracing](marking-tracing.md) — how motion + marking coordinate in a run.
- [Troubleshooting & FAQ](troubleshooting.md) — alarms, re-homing, connection.
