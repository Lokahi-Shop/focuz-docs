# Updates & Licensing

FocuZ is a **pay-once** product: your license never expires, and it comes with a year of
software updates. Everything lives under the **License** menu.

## How the license works

- **Buy once, use forever.** A FocuZ license never expires. Every version released during your
  update period is yours to use — and reinstall — for life.
- **One year of updates included.** Your license includes all updates released within a year of
  purchase. After that, your installed version keeps working forever; renewing is only for
  getting newer releases.
- **Three computers.** A license can be active on up to **3 computers** at a time — for
  example, a design laptop, a shop PC, and a spare. Moving to a new computer is self-service:
  deactivate on one machine and activate on the other.
- **Connects only for a few clear reasons.** FocuZ contacts the internet for licensing actions you
  start — activating, deactivating, renewing, or redeeming a code — for **update checks** (by
  default each time FocuZ starts; every check also confirms your license — change it under
  **License ▸ Software Updates**), and for a one-time verification of your trial or license. Apart
  from these, it never contacts us on its own. See [When FocuZ connects](#when-focuz-connects-to-the-internet).

## Trial

FocuZ runs as a **30-day trial** with full functionality so you can evaluate it before
activating. No license key is needed. The 30 days count from the first time you start FocuZ on
that computer; marking and tracing become available once the trial is registered, which happens
**once**, the first time FocuZ can reach the internet — after that it needs no connection to run
(update checks, when on, also confirm the trial). A trial is available once per computer;
reinstalling doesn't restart it.

When the trial ends, **marking and tracing turn off** until you activate a license:

- **If FocuZ is open when it happens**, a job that's already running is allowed to finish; it's
  the next Run or Trace that's turned off. You can keep editing and save your work.
- **The next time FocuZ starts**, it opens to the **License** panel and stays there until a
  license is activated. Your project files are untouched — everything you built during the
  trial opens normally once you're licensed.

Activating a license unlocks FocuZ immediately — no restart. So does a trial-extension code.

If FocuZ finds that its record of the date has been tampered with during a trial (or your PC's
clock was once set far ahead), it asks to confirm the trial with the license server: connect to
the internet and click Run or Trace again, or use **Check for Updates** on the License panel.

!!! tip "Run or Trace says it's locked?"
    The message tells you why. If it asks you to connect, make sure the computer is online and
    click Run or Trace again — verification happens automatically and is only needed once.

## Activating a license

Open the **License** panel:

1. Enter the **license key** from your purchase email and your email address, then click
   **Activate**. Activation needs a one-time internet connection; after that, FocuZ needs no
   connection to run (update checks, when on, also refresh your license).
2. Reinstalling FocuZ — or using a second Windows account on the same computer — **reuses**
   that computer's activation; it does not consume another one.
3. Activating a different license key on a computer automatically releases that computer's
   previous activation.

If all three activations are in use, the message names the computers holding them. Deactivate
FocuZ on one of those machines to free a spot — or if you no longer have access to one of
them, contact **info@lokahi.shop** and we'll free it for you.

**Deactivate License** releases this computer's activation (for example, before selling or
retiring a PC). **Refresh License Info** re-reads your license details from the server — handy
right after renewing from another device. If the License panel says your license is **not
verified yet** (for example after a hardware change), Refresh License Info offers to re-activate
it with your saved key.

## Updates

- **What's New** — after updating, FocuZ shows the changes in the new version.
- **Check for Updates** — see whether a newer version is available and get the download. How
  often FocuZ checks is up to you, under **License ▸ Software Updates**: **When FocuZ starts** (the default,
  turned on for everyone from 26.10), **Daily**, **Weekly**, **Monthly**, or **None (Manual only)**. A start-up check is quiet —
  it only speaks up when there is an update, and a version you dismissed stays quiet until a newer one comes. On a new
  install the license screen asks first: untick *Check for updates each time FocuZ starts* for manual checks only.
- **Release channels** — by default the update check offers **stable releases only**. To also
  be offered **beta / release-candidate** builds, tick *Update checks include beta /
  release-candidate builds* under **License ▸ Software Updates** (off by default). Whichever is newest for your
  channel wins — a stable release that supersedes an RC is still what you're offered.
  (Versions are dated — `YY.MM.DD.xx`; see
  [Installation](getting-started/installation.md).)
- **After your update period ends**, every version released before it ended remains yours: the
  update dialog points you to the newest release you're entitled to, which you can download
  and reinstall at any time.

## Renew updates

**Renew Updates** (License menu) opens a checkout for another year of updates — current
pricing is shown at checkout. Renewing never costs you time you already have: the new year is
added on top of your remaining update period, and renewing **before** your period ends adds
**two bonus months** on top of that. There are no subscriptions and no automatic charges —
renew only when you want another year of new releases.

## Selling your laser?

A license may be transferred **as a whole** — for example together with your laser or business
— to a single new owner. Deactivate your own copies, hand over the license key, and email
**info@lokahi.shop** so we can update the license record. Splitting a license between people
isn't permitted.

## When FocuZ connects to the internet

FocuZ works offline. It contacts the internet only at these specific moments, and never sends
usage data or telemetry:

- **Checking for updates** — by default each time FocuZ starts, or at the frequency you chose (or only
  when you click *Check for Updates* with **None (Manual only)**). Every check — automatic or manual — retrieves
  the newest version for your channel and, on licensed machines, also refreshes your license status and update
  entitlement in the same breath — it sends your license key, computer name, and a non-reversible hardware
  identifier. During a trial it confirms the trial.
- **License actions you start** — activating, deactivating, renewing, refreshing your license info, or redeeming a code talks
  to the license server at that moment, with the same identifiers. Starting a renewal also sends
  your license email so checkout is pre-filled.
- **One-time verification** — registering your trial sends only the non-reversible hardware
  identifier (and the date your trial began on this computer, if known); during the trial, an
  update check also confirms the trial with that same identifier. Verifying a license on a
  computer where it isn't verified yet sends the same identifiers as activation. Until it
  succeeds, FocuZ retries at start-up and when you click Run or Trace; once verified, it never
  repeats. Moving an activation to new hardware also sends the identifier earlier FocuZ versions
  used and your previous license record, so the activation moves instead of using another seat.
- **Update-period dates** *(licensed computers only, when needed)* — if your license's
  update-period dates weren't available yet, FocuZ retries fetching them at start-up; and when a
  version newer than your confirmed update period starts, it confirms the dates first. Same
  identifiers as activation.
- **Accepting the license terms** *(once per terms version)* — records that you accepted: the
  date, the terms version and wording, the FocuZ version, a machine identifier, and your news-and-offers choice.
  (The first time you accept on a computer, the same screen also asks whether to check for updates
  each time FocuZ starts — that choice stays on your computer and isn't sent.)
  No name or email is asked for; on trial machines the record isn't tied to you at all (a
  license activated later links it to your license email).

That's the whole list. Logs stay on your computer unless you choose to share them with support,
and no personal data is sold or shared for marketing. The full wording lives in the EULA's Data
Collection section (below).

## Offline licensing and custom solutions

FocuZ needs an internet connection **once** — to register your trial or verify your license — and
otherwise only for the update checks described above. If your setup can't connect at all (an
air-gapped shop, a strict security policy), you need licensing without any online contact, or you
have another need FocuZ doesn't cover out of the box, email **info@lokahi.shop**. These are handled
**case by case**: offline licensing and further customization are possible, and we'll work out what
fits your situation.

## Legal documents

The bottom of the License panel opens the two documents that ship with FocuZ:

- **End User License Agreement** — the terms you accepted on first run (that first screen also
  has the *Check for updates each time FocuZ starts* box). You can re-read it any
  time, **Save** a copy, or tick **Show this on next application start** to see the acceptance
  screen again.
- **Third-Party Licenses** — attribution and license text for the open-source components FocuZ
  is built on. Opens in its own window, with **Save** to keep a copy.

## See also

- [Getting Started](getting-started/index.md) · [Support](support.md)
