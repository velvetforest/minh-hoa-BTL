# Dong bo cac trang html tu repo chinh len GitHub Pages
$docs = "C:\Users\Thuy\vietnamese-legal-rag\docs"
# ten file nguon -> ten file tren Pages
$pages = @{
  "slides-bm25-dense.html" = "index.html"
  "minh-hoa-cong-viec.html" = "minh-hoa-cong-viec.html"
}
Set-Location $PSScriptRoot
foreach ($k in $pages.Keys) { Copy-Item (Join-Path $docs $k) (Join-Path $PSScriptRoot $pages[$k]) -Force }
git add -A
if (git status --porcelain) {
  git commit -m ("update " + (Get-Date -Format "yyyy-MM-dd HH:mm"))
  git push
} else { Write-Host "Khong co thay doi." }
