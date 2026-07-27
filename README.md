# MktOps — Live de Marketing & Vendas com IA (toda quinta, 19h30)

Landing page de captura + página de obrigado. Identidade MktOps Brand Book v2.0, fundo claro (Paper).

```
index.html      captura — hero + seção "quem conduz a live" + modal de formulário
obrigado.html   obrigado — CTA do grupo do WhatsApp
assets/         a foto original recortada (a página usa a cópia embutida em base64)
```

Versão escura aprovada: fundo preto, verde na logo e nos detalhes. A versão clara está no
histórico do git (`git show da723d9`) caso precise voltar.

Ambos os arquivos são **autocontidos**: CSS, JS e a fonte DM Sans (woff2 em base64) estão embutidos.
Zero requisição externa — carrega rápido e não depende do Google Fonts (bom pra LGPD).

---

## 1. Configuração (2 minutos)

### `index.html` — bloco `CONFIG` no final do arquivo

```js
var CONFIG = {
  endpoint: "",              // URL que recebe o lead (webhook n8n / Make / CRM). Vazio = só redireciona.
  redirect: "obrigado.html"  // página de obrigado
};
```

O payload enviado via `POST` (JSON):

```json
{
  "email": "voce@empresa.com.br",
  "whatsapp": "+5511987654321",
  "origem": "lp-live-quinta",
  "pagina": "https://...",
  "referrer": "...",
  "enviado_em": "2026-07-25T20:00:00.000Z",
  "utm_source": "...", "utm_medium": "...", "utm_campaign": "..."
}
```

> Se o endpoint falhar, o visitante **mesmo assim** vai para a página de obrigado — a conversão nunca trava por erro de integração.

### `obrigado.html` — bloco no final do arquivo

Já preenchido com o grupo da live:

```js
var WHATSAPP_GROUP_URL = "https://chat.whatsapp.com/J28wV9mCUYf4f8ubTB4Mk2";
```

Se o convite do grupo for trocado, é só substituir essa linha e dar push.

---

## 2. Status: já está no ar

**URL de produção:** https://helio-debug.github.io/live-mktops/

GitHub Pages servindo `main` / `(root)`, HTTPS automático, sem dependência de DNS.
Todo `git push` na `main` republica sozinho em ~30 segundos.

---

## 3. Para o dev — mover para `live.studioartemis.co` (opcional)

A página funciona hoje no domínio do GitHub. Só siga isto se quiser o subdomínio próprio.
São dois passos e nada no código muda.

**Passo 1 — DNS** (onde estiver o DNS do `studioartemis.co`; hoje é Cloudflare):

| Campo | Valor |
|---|---|
| Type | `CNAME` |
| Name | `live` |
| Target | `helio-debug.github.io` |
| Proxy | **DNS only** — nuvem cinza |

> Se o proxy ficar laranja, o GitHub não consegue validar o domínio e não emite o certificado.
> O site cai em erro de SSL. Esse é o único detalhe que costuma dar problema.

**Passo 2 — repo:** o arquivo `CNAME.exemplo` já contém o domínio. Renomeie para `CNAME`,
commite e suba:

```bash
mv CNAME.exemplo CNAME && git add -A && git commit -m "custom domain" && git push
```

O GitHub lê o arquivo `CNAME` e configura o domínio sozinho. Depois que o certificado
for emitido (alguns minutos), ligue o HTTPS:

```bash
gh api -X PUT repos/helio-debug/live-mktops/pages -F https_enforced=true
```

Para usar o domínio raiz em vez do subdomínio, troque o conteúdo do `CNAME` pelo domínio
e use quatro registros `A`: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`.

### Alternativa sem GitHub — WordPress

O `studioartemis.co` roda WordPress. Subindo os arquivos por FTP ou pelo gerenciador de
arquivos da hospedagem para uma pasta `live/` na raiz, a página responde em
`studioartemis.co/live/` na hora — sem DNS, sem propagação. São 3 arquivos: `index.html`,
`obrigado.html` e a pasta `assets/`.

---

## 4. Pixels e rastreamento

Cole antes de `</head>` nas duas páginas (Meta Pixel, GA4, GTM).
O evento de conversão deve disparar no **carregamento de `obrigado.html`** — o redirecionamento
preserva a query string, então as UTMs continuam disponíveis lá.

---

## 5. Checagens já feitas

| Item | Status |
|---|---|
| Dobra única em 1440×900 (sem scroll) | ok |
| Página de obrigado em 1440×900 (sem scroll) | ok |
| Layout mobile 390×844 | ok |
| Erros de console / JS | nenhum |
| Máscara de WhatsApp `(11) 98765-4321` | ok |
| Validação de e-mail e telefone bloqueando envio inválido | ok |
| Redirecionamento para `obrigado.html` preservando UTMs | ok |
| Modal: foco automático, ESC, clique fora, focus trap, honeypot anti-spam | ok |
| `prefers-reduced-motion` respeitado | ok |

---

## Identidade aplicada

| Token | Valor |
|---|---|
| Paper (fundo) | `#F3EEE6` |
| Soft (cards) | `#ECE6DB` |
| Texto e glifo | `#000000` (preto) |
| Accent (destaque) | `#A8E87A` |
| Accent-dark | `#88C45E` |
| Tipografia | DM Sans — display 500, body 400, label 500 uppercase tracking .14em |
| Glifo | quadrado 26px, `clip-path: polygon(0 0,100% 0,100% 60%,60% 60%,60% 100%,0 100%)` |

Fundo bege chapado (sem gradiente), todo texto em preto, lime apenas em botões, pill, marcadores e no destaque da headline.
