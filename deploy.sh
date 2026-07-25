#!/usr/bin/env bash
# Publica a LP no GitHub Pages.
# Uso:  ./deploy.sh <usuario-ou-org>/<repositorio>
set -euo pipefail
REPO="${1:?informe o repositorio, ex: ./deploy.sh live-mktops  (ou helio-debug/live-mktops)}"
[[ "$REPO" == */* ]] || REPO="helio-debug/$REPO"   # default do owner

git init -q 2>/dev/null || true
git add -A
git -c commit.gpgsign=false commit -qm "LP live de quinta — MktOps" || echo "nada novo para commitar"
git branch -M main
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/${REPO}.git"
git push -u origin main --force

cat <<TXT

Feito. Agora, uma vez só, no GitHub:
  Settings -> Pages -> Source: Deploy from a branch -> main / (root)
  Settings -> Pages -> Custom domain: live.studioartemis.co -> Save -> Enforce HTTPS

E no Cloudflare (studioartemis.co):
  Tipo CNAME | Nome: live | Destino: helio-debug.github.io | Proxy: DNS only (nuvem cinza)

TXT
