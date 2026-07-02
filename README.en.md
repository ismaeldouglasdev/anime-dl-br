<p align="center">
  <a href="README.md">🇧🇷 Português</a> &nbsp;|&nbsp; <strong>🇺🇸 English</strong>
</p>

# anime-dl-br

Download anime from Brazilian sources (AnimeFire, AnimesOnlineCC).
Works on **PC (Linux)** and **Android (via Termux)**.

## Features

- 🔍 **Search** — search anime on AnimeFire and AnimesOnlineCC with automatic fallback
- 📋 **List episodes** — shows all available episodes of an anime
- ⬇️ **Download** — download single episodes, ranges, or full seasons
- 🧠 **Smart slug resolution** — if search on AnimeFire fails, tries common slug patterns automatically
- 🔄 **Automatic fallback** — if one source doesn't have the episode, tries the other
- 📱 **Android** — runs on Termux with home screen shortcuts
- 🎥 **Player** — watch episodes directly on your phone without internet
- 📊 **Tracking** — logs downloaded episodes to history database

---

## 📱 Android Installation (Termux)

> ⚠️ Install **Termux** from [F-Droid](https://f-droid.org/packages/com.termux/) (Play Store version is outdated).
> Recommended: [Termux:Widget](https://f-droid.org/packages/com.termux.widget/) for home screen shortcuts.

```bash
# Download and run setup
curl -fsSL https://raw.githubusercontent.com/ismaeldouglasdev/anime-dl-br/main/setup-termux.sh -o setup-termux.sh
bash setup-termux.sh
```

The script does everything automatically:
1. ✅ Installs Python, ffmpeg, yt-dlp, and cloudscraper
2. ✅ Downloads `anime-dl-br` and installs it to PATH
3. ✅ Creates `Internal storage/Download/Animes/` folder (downloads go there)
4. ✅ Creates home screen shortcuts (if Termux:Widget is installed)

### Available shortcuts (Termux:Widget)

| Shortcut | Function |
|----------|----------|
| **Buscar Anime** | Type name, show results |
| **Baixar Episódio** | Type name + episode, download directly |
| **Listar Episódios** | Show available episodes of an anime |
| **Assistir Episódio** | Open episode in phone's video player |

### Watch offline

After downloading, episodes are in:
```
Internal storage > Download > Animes/
```
Open with **VLC for Android** or **mpv-android** — **no internet needed**.

---

## 💻 PC Installation (Linux)

### Dependencies

```bash
pip install curl-cffi
```

Optional (for Blogger video extraction):
```bash
pip install playwright
playwright install chromium
```

### Install

```bash
# Copy to PATH
cp anime-dl-br ~/.local/bin/
chmod +x ~/.local/bin/anime-dl-br
```

---

## Usage

```bash
# Search anime
anime-dl-br search "one piece"

# List episodes
anime-dl-br episodes "one-piece-tv"

# Download single episode
anime-dl-br download "one-piece" 1070

# Download episode range
anime-dl-br download "one-piece" --range 1050-1070

# Download full season
anime-dl-br download "one-piece" --all

# Choose specific source
anime-dl-br download "one-piece" 1070 --source animefire

# Choose quality
anime-dl-br download "one-piece" 1070 --quality 1080p

# Watch with mpv
anime-dl-br watch "one-piece" 1070

# Save to specific directory
anime-dl-br download "one-piece" --all --dir ~/Videos/Animes
```

> On Android (Termux), the same commands work — detection is automatic.

## Supported Sources

| Source | Status | Quality |
|--------|--------|---------|
| AnimeFire | ✅ Working | SD, HD, Full HD |
| AnimesOnlineCC | ✅ Working (with Blogger fallback) | SD, HD |

## License

MIT
