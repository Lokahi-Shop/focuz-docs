# Getting Started

This section takes you from a fresh download to your first successful mark.

## The path

1. **[Installation & driver](installation.md)** — install FocuZ and the BJJCZ USB driver.
2. **[First-run setup](first-run.md)** — Device Setup: import your `markcfg7` and configure a lens.
3. **[Your first mark](your-first-mark.md)** — import art, set power/speed, trace it, and run it.

## Before you start

You'll need:

- A PC running **Windows 10 or later (64-bit)**.
- A **BJJCZ / JCZ fiber galvo controller** connected over USB.
- Your machine's **`markcfg7`** file and any **`.cor`** lens-correction files (the same files EZCad2
  uses). If you've run EZCad2 on this machine, you already have these.

!!! tip "Coming from EZCad2 or LightBurn?"
    FocuZ drives the same controller and reuses your `markcfg7` and `.cor` files — but it builds jobs
    differently. Skim **[How FocuZ works](../index.md#how-focuz-works)** first; the *sequence of actions*
    model is the main thing to understand.

## Trial & licensing (in brief)

FocuZ runs as a **trial** out of the box so you can evaluate it. To unlock continued use, activate a
license from the **License** menu. A license includes a period of free updates, with an in-app renewal
flow. Full details are in **[Updates & Licensing](../updates-licensing.md)**.

## Safety first

A fiber laser can burn, blind, and ignite. Always:

- Wear laser safety glasses rated for your laser's wavelength.
- Keep the enclosure/interlocks in place and the work area clear.
- Use **[Trace](../marking-tracing.md)** (the red-light preview, laser off) to confirm placement
  **before** you Run.

!!! danger "You are responsible for safe operation"
    FocuZ controls a laser. Understand your machine and follow its manufacturer's safety guidance. See the
    in-app license agreement for the full disclaimer.
