# Importing Geometry

FocuZ imports both 2D art and full 3D models. 3D models are sliced into layers for depth-aware marking.

!!! info "This page is being written"
    The outline below is what it will cover. The [your first mark](getting-started/your-first-mark.md)
    quickstart shows a basic 2D import end to end.

## What this page will cover

- **Supported formats**
    - **2D vector:** SVG, DXF, AI
    - **3D solid:** STEP / STP (via the OCCT engine)
    - **3D mesh:** STL, OBJ, 3MF
    - **Images:** raster (for reference/preview)
- **2D import** — the multi-layer dialog (flatten vs. separate layers), choosing a **registration point**,
  setting **position / size / rotation**, and using a **border** file as a clipping boundary.
- **3D import & slicing** — registration in 3D, sizing and positioning along Z, **fill-through** behavior,
  and how slice count is determined.
- **Tips** — closing paths so fills work, units/scale on import, and re-importing/relinking files.

## See also

- [The Canvas](canvas.md) — placing and transforming imported geometry.
- [The Sequencer](sequencer.md) — turning imports into marking actions.
- [Marking & Tracing](marking-tracing.md) — 3D slice marking.
