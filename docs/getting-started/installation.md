# Installation & driver

## 1. Install FocuZ

1. Download the latest **`FocuZ-<version>-Setup.exe`** from the
   [Releases page](https://github.com/Lokahi-Shop/FocuZ/releases/latest).
2. Run the installer. FocuZ installs **per-user** — **no administrator rights are required**.
3. If the **.NET 8 Desktop Runtime** is missing, the installer offers to install it automatically.
4. Launch **FocuZ** from the Start menu.

!!! note "Versions"
    Releases use calendar versioning — `YY.MM.DD.xx` (e.g. `26.06.06.01`). A plain version number is a
    stable release; builds tagged `-beta` or `-rc` are pre-releases. See
    [Updates & Licensing](../updates-licensing.md).

## 2. Install the BJJCZ USB driver

FocuZ talks to the controller through a **WinUSB** driver. If Windows hasn't already bound a WinUSB
driver to your controller (for example, if this PC has only ever run EZCad2 with its own driver), install
it with the free **Zadig** utility.

!!! info "Do I need this?"
    If FocuZ already lists your device under **Device ▸ Connection**, the driver is fine — skip this step.
    Only install a driver if the controller is plugged in but FocuZ can't see it.

!!! tip "Already using LightBurn? No driver change needed."
    FocuZ uses the **same WinUSB driver as LightBurn**, so a laser that runs from LightBurn runs from
    FocuZ as-is — and you can move between the two without ever touching the driver. Just close one
    program before connecting from the other.

    That also makes them a good pair. If you like LightBurn's drawing tools, keep using them: design in
    LightBurn, **export** the artwork (SVG or DXF), **import** it into FocuZ, and mark it with FocuZ's
    marking tools — 3D slicing, fill variation, the job sequencer, rotary splits and per-lens profiles.
    See [Switching from EZCad2 or LightBurn](../guides/switching-from-ezcad2-or-lightburn.md).

### Using Zadig

1. Download Zadig from **<https://zadig.akeo.ie/>**.
2. Make sure the **BJJCZ controller is connected** via USB.
3. Run Zadig (no admin required).
4. Open the **Options** menu → check **List All Devices**.
5. In the dropdown, select the device with **USB ID `9588:9899`**
   (it may show as *USBLMCV2*, *jczMod2*, or *Unknown Device*).
6. With that device selected (double-check it reads **`9588:9899`**):
    - Set the target driver to **WinUSB**.
    - Click **Install Driver** and wait for *"Driver installed successfully."*
7. Back in FocuZ, open **Device ▸ Connection** and click **Refresh**.

!!! warning "Pick the right device"
    Installing a WinUSB driver onto the **wrong** USB device can disable it. Only proceed when the USB ID
    reads exactly **`9588:9899`**.

## 3. Confirm the connection

FocuZ **connects automatically** when it starts and finds your controller — there's nothing to click.
When connected, the status indicator turns green and FocuZ shows the controller's firmware **version**
and **serial number**.

If it doesn't connect on its own (for example, the controller was switched on after FocuZ started), or
you have more than one controller plugged in and want a different one than it picked, open
**Device ▸ Connection**, click **Refresh**, select your controller and click **Connect**.

Next: **[First-run setup](first-run.md)**.
