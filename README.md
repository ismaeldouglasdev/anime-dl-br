# anime-dl-br

Download de animes de fontes brasileiras (AnimeFire, AnimesOnlineCC).

## Funcionalidades

- 🔍 **Busca** — pesquisa animes no AnimeFire e AnimesOnlineCC com fallback automático
- 📋 **Listar episódios** — exibe todos os episódios disponíveis de um anime
- ⬇️ **Download** — baixa episódios únicos, ranges ou temporadas completas
- 🧠 **Resolução inteligente de slugs** — se a busca no AnimeFire falha, tenta padrões comuns de slug automaticamente
- 🔄 **Fallback automático** — se uma fonte não tem o episódio, tenta a outra
- 🎥 **Player** — assiste episódios diretamente no terminal via mpv
- 📊 **Tracking** — registra episódios baixados no banco de histórico

## Instalação

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

## Fontes Suportadas

| Fonte | Status | Qualidade |
|-------|--------|-----------|
| AnimeFire | ✅ Funcional | SD, HD, Full HD |
| AnimesOnlineCC | ✅ Funcional (com fallback Blogger) | SD, HD |

## Licença

MIT
