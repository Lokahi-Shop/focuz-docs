<#
.SYNOPSIS
    Capture the FocuZ window (or the full screen) to a PNG for the docs.

.DESCRIPTION
    Finds the FocuZ main window by title, brings it to the foreground, and saves a
    screenshot to docs/assets/<Name>.png. Use this for the capture-assist workflow:
    drive FocuZ to the screen you want documented, then run this with a -Name.

.PARAMETER Name
    Output file name (without extension). Saved under -OutDir as <Name>.png.

.PARAMETER OutDir
    Output directory. Defaults to the repo's docs/assets folder.

.PARAMETER Match
    Window-title substring to match. Defaults to "FocuZ".

.PARAMETER Delay
    Seconds to wait before capturing (time to switch to/arrange the window).

.PARAMETER FullScreen
    Capture the entire primary screen instead of just the FocuZ window.

.EXAMPLE
    ./tools/capture-shot.ps1 -Name sequencer-overview -Delay 3
#>
param(
    [Parameter(Mandatory = $true)][string]$Name,
    [string]$OutDir = (Join-Path $PSScriptRoot "..\docs\assets"),
    [string]$Match = "FocuZ",
    [int]$Delay = 2,
    [switch]$FullScreen
)

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$sig = @"
using System;
using System.Runtime.InteropServices;
public class Win32Capture {
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT r);
}
"@
if (-not ("Win32Capture" -as [type])) { Add-Type -TypeDefinition $sig }

if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }
$outPath = Join-Path $OutDir ("{0}.png" -f $Name)

if ($Delay -gt 0) { Write-Host "Capturing in $Delay s — switch to the screen you want..."; Start-Sleep -Seconds $Delay }

if ($FullScreen) {
    $b = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
} else {
    $proc = Get-Process | Where-Object { $_.MainWindowTitle -like "*$Match*" -and $_.MainWindowHandle -ne 0 } | Select-Object -First 1
    if (-not $proc) {
        Write-Warning "No window matching '*$Match*' found. Re-run with -FullScreen, or check the app is open."
        return
    }
    [Win32Capture]::ShowWindow($proc.MainWindowHandle, 9) | Out-Null   # SW_RESTORE
    [Win32Capture]::SetForegroundWindow($proc.MainWindowHandle) | Out-Null
    Start-Sleep -Milliseconds 400
    $r = New-Object Win32Capture+RECT
    [Win32Capture]::GetWindowRect($proc.MainWindowHandle, [ref]$r) | Out-Null
    $b = New-Object System.Drawing.Rectangle($r.Left, $r.Top, ($r.Right - $r.Left), ($r.Bottom - $r.Top))
}

$bmp = New-Object System.Drawing.Bitmap($b.Width, $b.Height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($b.Location, [System.Drawing.Point]::Empty, $b.Size)
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()

Write-Host "Saved $outPath ($($b.Width)x$($b.Height))"
