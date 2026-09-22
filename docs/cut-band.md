# The Cut Band

A **cut band** is a strip of marking that runs *along* your artwork's paths rather than filling
inside them. You give it an offset and a width, FocuZ builds a band there, and marking that band
repeatedly is what cuts the part out.

Three places use it:

- **2D Cut** — a band around imported 2D art.
- **3D Cut** — a band around a 3D model's floor outline.
- **Cut sublayers** — a band added underneath any layer (see [below](#cut-sublayers)).

The controls below are the same in all three; only holding tabs are exclusive to the 2D Cut and
3D Cut *actions*.

## Where the band sits

Two values place it, both in the **Fill** section at the top:

- **Offset** — how far from the original path the band's **inner edge** starts. Positive moves it
  outward. Leave it at 0 to start on the path itself.
- **Distance** — the band's **width**, measured outward from the offset edge.

!!! tip "A Distance of 0 gives you a single line"
    With **Distance** at 0 there is no band to fill — the offset line itself becomes the cut. That
    is the setting you want for a plain single-pass score or a thin material where one line is
    enough. The band-only controls (outline sides, the Wobble fill) disappear, since there are no
    edges to talk about.

Together they mean: *"start cutting **Offset** mm out from my art, and make the cut **Distance** mm
wide."* Widening the band is how you make room for a real kerf on thicker material.

## Filling the band

The **Fill** dropdown picks the toolpath that covers the band. Every normal fill type is available,
plus one that only exists here:

- **Contour** — concentric rings following the band's shape. The usual choice for cutting: each
  ring is a continuous pass along the cut.
- **Wobble** — circles marched along the band's centreline, sized to touch both edges. Only offered
  once **Distance** is non-zero, since it needs a band to size itself against.
- **Unidirectional / Bidirectional / Cross / Snake / Hilbert Curve / Thatch** — the standard fills,
  applied within the band.
- **None** — no band fill. The outline controls are hidden with this setting, so if what you want
  is a single cut line, set **Distance** to 0 instead.

**Spacing** sets the gap between fill passes, exactly as it does for a normal fill.

## Edges and order

**Outline** marks the band's boundary lines in addition to its fill. The dropdown beside it chooses
which boundaries mark:

| Setting | Marks |
|---|---|
| **ID** | the inner edge only |
| **OD** | the outer edge only |
| **Both** | both edges (the default) |

**Direction** sets the order the band marks in — **ID>OD** works from the inner edge outward,
**OD>ID** from the outer edge inward. This is *radial* ordering, so it appears only when the fill is
**Contour**: concentric rings are the only fill that is actually arranged inner-to-outer. With any
other fill the band's passes have no inside-out sequence to reverse, so the control is hidden and
has no effect.

## Holding tabs

Cutting a shape free means it drops the moment the last pass completes. **Tabs** leave small uncut
bridges so the part stays attached until you remove it deliberately.

Tabs are available on the **2D Cut** and **3D Cut** actions. They are off until **# Tabs** is 1 or
more.

- **# Tabs** — how many bridges to leave. They are spaced evenly around each closed path.
- **Length** — how long each bridge is, measured along the path.
- **Radius** — rounds the corners where the cut stops and restarts, so the laser doesn't leave a
  sharp notch you have to file off.
- **Offset** — rotates all the tabs together around the path, in millimetres of travel. Use it to
  move a tab off a visible edge or a detail you don't want a witness mark on.
- **Start Depth** — at what point through the cut the tabs begin. At the default **70%**, the first
  70% of the layer's passes cut the band all the way around, and the remaining 30% skip the tab
  positions — so the bridges are only as tall as that last portion of the cut.

!!! note "Tabs need more than one pass"
    Start Depth divides the layer's **Repeat** (the pass count in the layer header) between full passes
    and tabbed passes. With a single pass there is nothing to divide, so raise **Repeat** before
    expecting tabs to hold. (**# of Passes** in the Parameters section is a different setting — see
    the parameters table on the Sequencer page.)

## Cut sublayers

A **Cut sublayer** adds a band underneath any layer, so one action can mark artwork and then cut it
out. Add one with **+ Sub** on the layer header and set its mode to **Cut**.

It carries the same **Offset**, **Distance**, fill, outline-side and direction controls as above,
plus one of its own:

- **Cut Source** — what the band is built around: **Import** (the layer's own art), **Perimeter**
  (the outline of what the layer marks), or **Border** (the layer's border shape).

Holding tabs are not offered on a sublayer — use a 2D Cut or 3D Cut action when you need them.

## See also

- [The Sequencer](sequencer.md) — where the 2D Cut and 3D Cut actions live.
- [Importing Geometry](importing.md) — getting the art in first.
- [The Settings Library](library.md) — saving a cut recipe and reusing it.
