# Theo doi file slide; khi luu file thi tu chay sync.ps1 de day len GitHub Pages
$dir  = "C:\Users\Thuy\vietnamese-legal-rag\docs"
$name = "slides-bm25-dense.html"
$sync = Join-Path $PSScriptRoot "sync.ps1"
$log  = Join-Path $PSScriptRoot "watch.log"

$fsw = New-Object System.IO.FileSystemWatcher $dir
$fsw.NotifyFilter = [IO.NotifyFilters]'LastWrite, FileName, Size'
$fsw.EnableRaisingEvents = $true

"[$(Get-Date -Format s)] dang theo doi $dir\$name" | Add-Content $log
while ($true) {
  $r = $fsw.WaitForChanged([IO.WatcherChangeTypes]::All, 3600000)
  if ($r.TimedOut -or $r.Name -ne $name) { continue }
  Start-Sleep -Seconds 2   # cho editor ghi xong, gom nhieu lan luu thanh mot
  try {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $sync *>> $log
  } catch { "[$(Get-Date -Format s)] loi: $_" | Add-Content $log }
}
