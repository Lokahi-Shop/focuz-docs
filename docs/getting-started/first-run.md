# First-run setup

The first time you launch FocuZ, the **Device Setup** window opens automatically. It also re-opens if you
try to Run or Trace before the device is configured. You can revisit it any time from **Device ▸ Device
Setup**.

!!! important "Marking is blocked until the device is configured"
    FocuZ won't let you **Run** or **Trace** until you've imported a `markcfg7`. This prevents marking
    with an unconfigured axis mapping.

The window has two sections: **Device Setup** on top and **Lens Setup** below it.

## Device Setup

> *Import your markcfg7 (in the EZCad2 ▸ plug folder) to configure the device.*

1. Click **Import markcfg7** and select your machine's `markcfg7` file — the same file EZCad2 uses. It
   lives in EZCad2's **plug** folder.
2. The status line confirms **"Device configured (markcfg7 imported)."** and Run and Trace unlock.

One import sets up everything device-wide: the **laser** settings (galvo axis mapping, speed and timing
defaults), the **rotary** motor settings, the **red light**, the **power map** and the **I/O** port
assignments. If you only want to re-import one of those later, each has its own **Import markcfg7**
button on its own panel in the **Device** menu.

FocuZ supports **fiber** lasers. The laser type is read from the file: a `markcfg7` for another laser type
still imports, but FocuZ tells you so and keeps marking and tracing disabled.

!!! note "Rotary settings come in with the import"
    If your machine has a rotary, its motor settings — steps per rotation, gear ratio, direction and
    speeds — are applied to all three fixture profiles (**Chuck**, **Roller** and **Turntable**). Check
    and fine-tune each one later under **Device ▸ Rotary Setup**: that's where each fixture's own settings
    live, along with the default part diameter and split values for new rotary actions. See
    [Rotary Marking](../rotary.md).

## Lens Setup

> *Configure the lens(es) you'll mark with — pick each lens, name it, and set its correction (a .cor file
> or manual values).*

1. Pick the **Lens** you're using (**L1–L8**). FocuZ keeps settings **per lens**, so each lens has its own
   field size, scale and angle, and correction. Give it a short **Label** (for example "110" or "174") —
   the label follows the lens everywhere it's shown, including the lens dropdown.
2. Click **Corrections…** to open the correction dialog and either:
    - **load a `.cor` file** (recommended — the same lens file EZCad2 and LightBurn use), or
    - enter **manual** correction values — typed in directly, imported with **From device markcfg7**
      (reuses the file you imported above), or imported from any file with **Choose markcfg7…**.
3. *(Later)* set the lens's **focal Z height** from the **Lens** menu — see
   [Lenses, Corrections & Calibration](../lenses-corrections.md).

You can configure **more than one lens** here — pick a lens, set it up, then switch to another and come
back; each keeps its own settings. You can fine-tune any lens later from **Device ▸ Lens Corrections**.

See **[Lenses, Corrections & Calibration](../lenses-corrections.md)** for what each correction setting does.

## Finish

Click **Apply All** to keep your setup, or **Cancel** to discard every change made in this window and
return to how it was before.

Next: **[Your first mark](your-first-mark.md)**.
