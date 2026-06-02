#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
#  setup-termux.sh — Instala anime-dl-br no Termux (Android)
#  Uso: bash setup-termux.sh
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}══════════════════════════════════════════════${NC}"
echo -e "${CYAN}  anime-dl-br — Setup para Termux${NC}"
echo -e "${CYAN}══════════════════════════════════════════════${NC}"
echo ""

# ── Detectar Termux ──────────────────────────────────────────
if [ -z "$TERMUX_VERSION" ]; then
    echo -e "${RED}❌ Este script deve ser executado no Termux (Android)${NC}"
    echo "   Baixe em: https://f-droid.org/packages/com.termux/"
    exit 1
fi

echo -e "${GREEN}✅ Termux detectado (v$TERMUX_VERSION)${NC}"

# ── Dar permissão de armazenamento ───────────────────────────
echo ""
echo -e "${YELLOW}📂 Solicitando acesso ao armazenamento...${NC}"
termux-setup-storage 2>/dev/null || true
echo -e "${GREEN}✅ Armazenamento configurado${NC}"

# ── Atualizar pacotes ────────────────────────────────────────
echo ""
echo -e "${YELLOW}📦 Atualizando pacotes do Termux...${NC}"
pkg update -y -o Dpkg::Options::="--force-confnew"
pkg upgrade -y -o Dpkg::Options::="--force-confnew"

# ── Instalar dependências ────────────────────────────────────
echo ""
echo -e "${YELLOW}📦 Instalando dependências...${NC}"
pkg install -y \
    python \
    ffmpeg \
    yt-dlp \
    git \
    curl \
    libxml2 \
    libxslt

echo -e "${GREEN}✅ Dependências instaladas${NC}"

# ── Instalar cloudscraper (fallback do curl_cffi) ────────────
echo ""
echo -e "${YELLOW}🐍 Instalando cloudscraper (via pip)...${NC}"
pip install cloudscraper

echo -e "${GREEN}✅ cloudscraper instalado${NC}"

# ── Instalar anime-dl-br ─────────────────────────────────────
SCRIPT_SRC="https://raw.githubusercontent.com/ismaeldouglasdev/anime-dl-br/main/anime-dl-br"
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

echo ""
echo -e "${YELLOW}⬇️  Baixando anime-dl-br...${NC}"
curl -fsSL "$SCRIPT_SRC" -o "$INSTALL_DIR/anime-dl-br"
chmod +x "$INSTALL_DIR/anime-dl-br"

echo -e "${GREEN}✅ anime-dl-br instalado em $INSTALL_DIR/anime-dl-br${NC}"

# ── Criar diretório de downloads ─────────────────────────────
DOWNLOAD_DIR="$HOME/storage/downloads/Animes"
mkdir -p "$DOWNLOAD_DIR"
echo -e "${GREEN}📁 Downloads: $DOWNLOAD_DIR${NC}"

# ── Configurar PATH ──────────────────────────────────────────
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    SHELL_CONFIG="$HOME/.bashrc"
    echo "" >> "$SHELL_CONFIG"
    echo "# anime-dl-br" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_CONFIG"
    echo -e "${YELLOW}➕ $INSTALL_DIR adicionado ao PATH em $SHELL_CONFIG${NC}"
fi

export PATH="$PATH:$INSTALL_DIR"

# ── Instalar atalhos Termux:Widget ───────────────────────────
WIDGET_DIR="$HOME/.shortcuts"
mkdir -p "$WIDGET_DIR"

# Atalho: Buscar Anime
cat > "$WIDGET_DIR/Buscar Anime" << 'SHEOF'
#!/data/data/com.termux/files/usr/bin/bash
cd ~ && termux-wifi-connectioninfo > /dev/null 2>&1
echo "🔍 Nome do anime:"
read -r QUERY
clear
anime-dl-br search "$QUERY"
echo ""
echo "Pressione ENTER para fechar"
read
SHEOF

# Atalho: Baixar Episódio
cat > "$WIDGET_DIR/Baixar Episódio" << 'SHEOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "📺 Nome/slug do anime:"
read -r TITLE
echo "📀 Episódio (ex: 1 ou 1-12):"
read -r EP
clear
if echo "$EP" | grep -q '-'; then
    anime-dl-br download "$TITLE" --range "$EP"
else
    anime-dl-br download "$TITLE" "$EP"
fi
echo ""
echo "Pressione ENTER para fechar"
read
SHEOF

# Atalho: Assistir Último
cat > "$WIDGET_DIR/Assistir Episódio" << 'SHEOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "📺 Nome do anime (como está na pasta):"
read -r TITLE
echo "📀 Episódio:"
read -r EP
clear
anime-dl-br watch "$TITLE" "$EP"
SHEOF

# Atalho: Listar Episódios
cat > "$WIDGET_DIR/Listar Episódios" << 'SHEOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "📺 Slug do anime:"
read -r SLUG
echo "📀 Fonte (animefire / animesonline):"
read -r SOURCE
clear
anime-dl-br episodes "$SLUG" --source "$SOURCE"
echo ""
echo "Pressione ENTER para fechar"
read
SHEOF

chmod +x "$WIDGET_DIR"/*

echo -e "${GREEN}✅ Atalhos instalados em $WIDGET_DIR/${NC}"
echo "   📱 Adicione o widget Termux:Widget na tela inicial"
echo "      para acessar os atalhos."

# ── Testar ───────────────────────────────────────────────────
echo ""
echo -e "${CYAN}══════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Setup concluído!${NC}"
echo ""
echo -e "${CYAN}📱 Comandos disponíveis:${NC}"
echo -e "   ${YELLOW}anime-dl-br search \"one piece\"${NC}"
echo -e "   ${YELLOW}anime-dl-br episodes \"one-piece-tv\"${NC}"
echo -e "   ${YELLOW}anime-dl-br download \"one piece\" 1${NC}"
echo -e "   ${YELLOW}anime-dl-br download \"one piece\" --range 1-12${NC}"
echo -e "   ${YELLOW}anime-dl-br watch \"one piece\" 1${NC}"
echo ""
echo -e "${CYAN}📱 Ou use os atalhos do Termux:Widget na tela inicial!${NC}"
echo ""
echo -e "${YELLOW}📂 Os episódios baixados estão em:${NC}"
echo -e "   Internal storage > Download > Animes/"
echo -e "   (assista offline com VLC ou mpv-android)"
echo ""
