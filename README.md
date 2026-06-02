# anime-dl-br

Download de animes de fontes brasileiras (AnimeFire, AnimesOnlineCC).
Funciona no **PC (Linux)** e no **celular (Android via Termux)**.

## Funcionalidades

- 🔍 **Busca** — pesquisa animes no AnimeFire e AnimesOnlineCC com fallback automático
- 📋 **Listar episódios** — exibe todos os episódios disponíveis de um anime
- ⬇️ **Download** — baixa episódios únicos, ranges ou temporadas completas
- 🧠 **Resolução inteligente de slugs** — se a busca no AnimeFire falha, tenta padrões comuns de slug automaticamente
- 🔄 **Fallback automático** — se uma fonte não tem o episódio, tenta a outra
- 📱 **Android** — roda no Termux com atalhos na tela inicial
- 🎥 **Player** — assiste episódios direto no celular sem internet
- 📊 **Tracking** — registra episódios baixados no banco de histórico

---

## 📱 Instalação no Android (Termux)

> ⚠️ Instale o **Termux** pelo [F-Droid](https://f-droid.org/packages/com.termux/) (o da Play Store é desatualizado).
> Recomendado também: [Termux:Widget](https://f-droid.org/packages/com.termux.widget/) para atalhos na tela inicial.

```bash
# Baixar e executar o setup
curl -fsSL https://raw.githubusercontent.com/ismaeldouglasdev/anime-dl-br/main/setup-termux.sh -o setup-termux.sh
bash setup-termux.sh
```

O script faz tudo automático:
1. ✅ Instala Python, ffmpeg, yt-dlp e cloudscraper
2. ✅ Baixa o `anime-dl-br` e instala no PATH
3. ✅ Cria a pasta `Internal storage/Download/Animes/` (downloads vão pra lá)
4. ✅ Cria atalhos na tela inicial (se tiver Termux:Widget)

### Atalhos disponíveis (Termux:Widget)

| Atalho | Função |
|--------|--------|
| **Buscar Anime** | Digita o nome, mostra resultados |
| **Baixar Episódio** | Digita nome + episódio, baixa direto |
| **Listar Episódios** | Mostra episódios disponíveis de um anime |
| **Assistir Episódio** | Abre o episódio no player de vídeo do celular |

### Assistir offline

Após o download, os episódios estão em:
```
Internal storage > Download > Animes/
```
Abra com **VLC for Android** ou **mpv-android** — **sem precisar de internet**.

---

## 💻 Instalação no PC (Linux)

### Dependências

```bash
pip install curl-cffi
```

Opcional (para extração de vídeos Blogger):
```bash
pip install playwright
playwright install chromium
```

### Instalar

```bash
# Copiar para o PATH
cp anime-dl-br ~/.local/bin/
chmod +x ~/.local/bin/anime-dl-br
```

---

## Uso

```bash
# Buscar anime
anime-dl-br search "one piece"

# Listar episódios
anime-dl-br episodes "one-piece-tv"

# Baixar episódio único
anime-dl-br download "one-piece" 1070

# Baixar range de episódios
anime-dl-br download "one-piece" --range 1050-1070

# Baixar temporada completa
anime-dl-br download "one-piece" --all

# Escolher fonte específica
anime-dl-br download "one-piece" 1070 --source animefire

# Escolher qualidade
anime-dl-br download "one-piece" 1070 --quality 1080p

# Assistir com mpv
anime-dl-br watch "one-piece" 1070

# Salvar em diretório específico
anime-dl-br download "one-piece" --all --dir ~/Videos/Animes
```

> No Android (Termux), os comandos são os mesmos — a detecção é automática.

## Fontes Suportadas

| Fonte | Status | Qualidade |
|-------|--------|-----------|
| AnimeFire | ✅ Funcional | SD, HD, Full HD |
| AnimesOnlineCC | ✅ Funcional (com fallback Blogger) | SD, HD |

## Licença

MIT
