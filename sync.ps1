# Dong bo slide tu repo chinh len GitHub Pages
$src = "C:\Users\Thuy\vietnamese-legal-rag\docs\slides-bm25-dense.html"
Set-Location $PSScriptRoot
Copy-Item $src "$PSScriptRoot\index.html" -Force
git add -A
if (git status --porcelain) {
  git commit -m ("update slide " + (Get-Date -Format "yyyy-MM-dd HH:mm"))
  git push
} else { Write-Host "Khong co thay doi." }
