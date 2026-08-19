# Jog, Homing & Terminal

This section covers the **FocuZ:grbl controller** — the motion-and-accessory controller FocuZ pairs with
your galvo controller — and the **Jog** and **Terminal** screens that drive it.

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

![TODO screenshot: Jog window](assets/jog-card.png){ .screenshot }

<!-- TODO screenshot: Jog window -->

### Homing

- **Home X / Home Y / Home Z** home each axis independently; **Home All** runs them in sequence.
- Each axis tracks its own **homing status**. An axis must be homed for its absolute position to be
  trustworthy; homing is what establishes a known origin (by touching the limit switch).
- After an **alarm** (e.g. a limit hit) an axis loses its homed status and must be re-homed before its
  position is trusted again — see [Troubleshooting & FAQ](troubleshooting.md).

### Motorized axes (Enable X / Y / Z)

Tell FocuZ which axes it drives with the **Enable X / Y / Z** checkboxes — found on
**Device ▸ Connection** (below the FocuZ:grbl port selector) and in **Device ▸ Laser Setup**'s
**Motorized Axis (FocuZ controlled)** section (both show the same setting). Enabling an axis includes it in operations
that need confident absolute positioning and shows its jog controls and Home button here on the Jog
tab; a disabled axis is hidden. Whether a run requires a given axis to be homed depends on which axes
are enabled and what the job does.

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

The **FocuZ Jog** section is a directional pad: **Y+ / Y− / X− / X+** arranged as a cross, with
**Z+ / Z−** beside it. Set the **Step** (mm) and **Feed** for XY and for Z beneath their buttons,
then click to move by that step. Axes that aren't enabled in Device/Laser Setup show grayed out.

- **Home & Jog to Lens 0** homes Z and moves to the active lens's saved focal height in one step — handy
  for getting straight to focus (see [Lenses, Corrections & Calibration](lenses-corrections.md)).

### BJJCZ Rotary

The Jog window's **BJJCZ Rotary** strip jogs the rotary axis (it runs on the laser controller, so
it's live whenever the laser is connected): jog **CCW / CW** by the set angle, **Set Zero** to
define the current position as zero, and **Go to Zero** to rotate back to it — with a live
position readout. See [Rotary Marking](rotary.md).

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

![TODO screenshot: Terminal window](assets/terminal-card.png){ .screenshot }

<!-- TODO screenshot: Terminal window -->

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
