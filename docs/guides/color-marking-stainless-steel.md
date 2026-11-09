---
description: "How color laser marking (annealing) on stainless steel works on a fiber laser, how to find your colors with a test grid, and how to blend colors across one fill."
---

# Color marking stainless steel on a fiber laser

**Short answer:** the colors on stainless are a thin oxide layer grown by heat. How thick it grows, and so
which color you see, depends on how much heat each spot gets: speed, power, frequency, pulse width and
line spacing together. Find your colors with a test grid on your own steel, then use them.

[Video: Enter the Dragon — color laser annealing on stainless steel](https://www.youtube.com/watch?v=4P3CP-rRtsA)

## What changes the color

- **Heat per area.** Slower speed, tighter line spacing or more power puts in more heat and moves the
  color along the range.
- **Frequency and pulse width.** On MOPA sources, the pulse width (Q-Pulse) changes how the heat is
  delivered, which is why MOPA lasers have a wider color range.
- **The steel and the setup.** Alloy, surface finish, part thickness and focus all shift the result.
  A setting that's blue on one sheet can be purple on another.

## Finding your colors

Run a [test grid](finding-fiber-laser-settings-with-a-test-grid.md) on the same material as your part.
Right-click each square whose color you like and save it to your Library. Every setting is saved as a
template, so each color is easy to recall later.

## More than one color in a fill

**Fill variation** changes the settings along the fill itself: a ramp along each line, per chord or per
quadrant. One fill can then pass through a range of colors instead of sitting at one.
See [Variation](../sequencer.md#variation).

## Keep it repeatable

FocuZ marks the same settings line by line every run. The steel is what varies, so mark a small test square
on each new batch before a production run.
