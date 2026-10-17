# Theo doi cac file slide; khi luu file thi tu chay sync.ps1 de day len GitHub Pages
$dir   = "C:\Users\Thuy\vietnamese-legal-rag\docs"
$names = @("slides-bm25-dense.html", "minh-hoa-cong-viec.html")
$sync  = Join-Path $PSScriptRoot "sync.ps1"
$log   = Join-Path $PSScriptRoot "watch.log"

$fsw = New-Object System.IO.FileSystemWatcher $dir
$fsw.NotifyFilter = [IO.NotifyFilters]'LastWrite, FileName, Size'
$fsw.EnableRaisingEvents = $true

"[$(Get-Date -Format s)] dang theo doi $($names -join ', ') trong $dir" | Add-Content $log
while ($true) {
  $r = $fsw.WaitForChanged([IO.WatcherChangeTypes]::All, 3600000)
  if ($r.TimedOut -or $names -notcontains $r.Name) { continue }
  Start-Sleep -Seconds 2   # cho editor ghi xong, gom nhieu lan luu thanh mot
  try {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $sync *>> $log
  } catch { "[$(Get-Date -Format s)] loi: $_" | Add-Content $log }
}
