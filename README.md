# FocuZ documentation

Source for the **FocuZ user wiki**, published at **<https://wiki.lokahi.shop>**.

FocuZ is a Windows laser-control suite for BJJCZ galvo controllers, by
[Lokahi Innovation](https://lokahi.shop).

## How it's built

- Content lives in [`docs/`](docs/) as Markdown.
- Built with [MkDocs](https://www.mkdocs.org/) + the
  [Material](https://squidfunk.github.io/mkdocs-material/) theme (`mkdocs.yml`).
- A GitHub Action (`.github/workflows/deploy.yml`) builds the site and deploys it to
  GitHub Pages **only when changes land on `main`**.

## How changes are made (controlled updates)

`main` is the live site and is **never edited directly**. Every change goes through a
**pull request**:

1. A branch is created and the Markdown is edited there.
2. A PR is opened — its diff shows exactly **what is removed (red) and added (green)**.
3. CI builds the PR (`mkdocs build --strict`) and attaches the rendered site as a
   downloadable **`site-preview`** artifact so it can be reviewed before merge.
4. Edits can be made on the branch during review.
5. **Merging the PR is the approval** — only then does the site rebuild and deploy.

## Building locally (optional)

```bash
pip install -r requirements.txt
mkdocs serve          # live preview at http://127.0.0.1:8000
mkdocs build --strict # one-off build into ./site
```

## Screenshots

Images live in [`docs/assets/`](docs/assets/). `tools/capture-shot.ps1` captures the
FocuZ window to a PNG for use in pages.

---

© 2026 Lokahi Innovation. All rights reserved.
