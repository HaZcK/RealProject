# ChromaHub 🎨
> Universal Roblox Script Hub — by HaZcK

![Version](https://img.shields.io/badge/version-1.0.0-blueviolet)
![Executor](https://img.shields.io/badge/executor-Delta%20Android-orange)
![Status](https://img.shields.io/badge/status-active-brightgreen)
![Creator](https://img.shields.io/badge/By-Khafidz-Blue?logo=github)
![POWERED_BY](https://img.shields.io/badge/Gemini-AI-Purple)

---

## 📖 Deskripsi

**ChromaHub** adalah script hub universal untuk Roblox yang secara otomatis mendeteksi game yang sedang dimainkan, lalu mengeksekusi script yang sesuai. Dilengkapi loading screen animasi kustom dan UI berbasis WindUI.

---

## ✨ Fitur Utama

- 🎬 **Loading screen animasi** — typewriter effect, fade in/out, step-by-step logs
- 🔍 **Auto game detection** — deteksi `game.PlaceId` secara otomatis
- 📦 **Modular system** — tiap game punya script sendiri di folder `ScriptGame/`
- 🎨 **WindUI-based** — UI modern, clean, dan responsif
- 🛠️ **Library utilities** — NoClip, Inf Jump, Anti AFK, Loop, Teleport, dll
- ⚡ **Delta Android compatible**

---

## 📁 Struktur File

```
ChromaHub/
│
├── CoreScript.lua              ← Loader utama (jalankan ini di executor)
├── Gameid.json                 ← Daftar semua game yang didukung
│
└── ScriptGame/
    ├── LibraryScript.lua       ← WindUI wrapper + utility functions
    ├── TemplateScript.lua      ← Boilerplate untuk buat script game baru
    ├── BloxFruits.lua          ← (contoh) script Blox Fruits
    └── DaHood.lua              ← (contoh) script Da Hood
```

---

## 🚀 Cara Pakai

### 1. Jalankan di Executor

Copy script berikut ke executor kamu (Delta Android atau lainnya), lalu execute:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/HaZcK/ChromaHub/main/CoreScript.lua"))()
```

### 2. Proses Loading

Setelah dieksekusi, ChromaHub akan otomatis:

| Step | Keterangan |
|------|-----------|
| `loading Place..` | Fetch `Gameid.json` — scan semua game yang didukung |
| `loading Script..` | Cek `game.PlaceId` kamu — cari game yang cocok |
| `Installation Ui..` | Download & load script game dari `ScriptGame/` |

### 3. Selesai!

UI game script akan muncul otomatis setelah loading selesai.

---

## ➕ Cara Tambah Game Baru

### Step 1 — Tambah ID di `Gameid.json`

```json
{
  "games": [
    {
      "id": 2753915549,
      "name": "Blox Fruits",
      "script": "BloxFruits"
    },
    {
      "id": 123456789,
      "name": "Nama Game Baru",
      "script": "NamaGameBaru"
    }
  ]
}
```

> **Cara cari PlaceId game:** Buka halaman game di Roblox.com → lihat angka di URL.
> Contoh: `roblox.com/games/`**`2753915549`**`/Blox-Fruits`

### Step 2 — Buat script di `ScriptGame/`

Salin `TemplateScript.lua` → rename sesuai field `"script"` di Gameid.json.

Contoh: kalau `"script": "NamaGameBaru"` → buat file `ScriptGame/NamaGameBaru.lua`

### Step 3 — Edit script-nya

Buka file baru tersebut dan sesuaikan logic di bagian Callback setiap elemen UI.

---

## 🧩 LibraryScript — Utility Functions

LibraryScript diload otomatis oleh setiap game script. Tersedia via `getgenv().ChromaLib`.

### Window

```lua
local Window = lib.CreateWindow({
    Title    = "ChromaHub",
    SubTitle = "Blox Fruits",
    Acrylic  = true,
    Theme    = "Dark",
})
```

### Notifikasi

```lua
-- ntype: "info" | "success" | "warning" | "error"
lib.Notify("Judul", "Pesan notifikasi", 3, "success")
```

### Konfirmasi Dialog

```lua
lib.Confirm("Judul", "Pesan konfirmasi", function(jawaban)
    if jawaban then
        -- user klik "Ya"
    end
end)
```

### Loop Utility (Auto Farm, dll)

```lua
local stopLoop = lib.Loop(0.1, function()
    -- logic yang dijalankan tiap 0.1 detik
end)

-- Untuk hentikan:
stopLoop()
```

### Teleport

```lua
lib.TeleportTo(Vector3.new(0, 10, 0))
```

### No Clip

```lua
lib.SetNoclip(true)   -- aktifkan
lib.SetNoclip(false)  -- matikan
```

### Infinite Jump

```lua
lib.SetInfJump(true)   -- aktifkan
lib.SetInfJump(false)  -- matikan
```

### Anti AFK

```lua
lib.AntiAFK()  -- cukup panggil sekali
```

### Get Humanoid

```lua
local hum = lib.GetHumanoid()
if hum then
    hum.WalkSpeed = 100
end
```

---

## 🎨 TemplateScript — Elemen UI Lengkap

TemplateScript berisi contoh **semua elemen WindUI** yang bisa langsung disalin.

| Elemen | Fungsi |
|--------|--------|
| `Toggle` | Switch on/off fitur |
| `Button` | Tombol aksi |
| `Slider` | Input angka dengan range |
| `Input` | Text input dari user |
| `Dropdown` | Pilihan dari list |
| `ColorPicker` | Pilih warna |
| `Keybind` | Hotkey keyboard |
| `Label` | Teks statis |
| `Paragraph` | Teks panjang + judul |
| `Separator` | Garis pembatas section |
| `Section` | Header group elemen |

### Contoh Penggunaan Elemen

```lua
-- Toggle
Tab:CreateToggle("Auto Farm", false, function(state)
    print("Auto Farm:", state)
end)

-- Button
Tab:CreateButton("Execute", function()
    -- logic
end)

-- Slider
Tab:CreateSlider("Walk Speed", {Min = 16, Max = 500, Default = 16}, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

-- Input
Tab:CreateInput("Username", "Ketik username...", function(text)
    print("Input:", text)
end)

-- Dropdown
Tab:CreateDropdown("Mode", {"Mode A", "Mode B", "Mode C"}, function(selected)
    print("Dipilih:", selected)
end)

-- ColorPicker
Tab:CreateColorPicker("Warna ESP", Color3.fromRGB(255, 0, 0), function(color)
    print("Warna:", color)
end)

-- Keybind
Tab:CreateKeybind("Fly (Hotkey)", Enum.KeyCode.F, function()
    print("Fly toggled!")
end)

-- Label
Tab:CreateLabel("Ini teks label statis.")

-- Paragraph
Tab:CreateParagraph({
    Title   = "Judul",
    Content = "Isi paragraf di sini.\nBisa multi-line.",
})
```

---

## 🎮 Game yang Didukung

| Game | Place ID | Script File |
|------|----------|-------------|
| Blox Fruits | 2753915549 | `BloxFruits.lua` |
| Pet Simulator X | 292439477 | `PetSimX.lua` |
| Fruit Battlegrounds | 1537690962 | `FruitBattlegrounds.lua` |
| Da Hood | 6872265039 | `DaHood.lua` |
| Natural Disaster Survival | 189707 | `NaturalDisaster.lua` |

> Mau tambah game? Ikuti panduan di bagian **Cara Tambah Game Baru** di atas.

---

## ⚙️ Konfigurasi CoreScript

Ganti nilai berikut di `CoreScript.lua` jika URL repo berubah:

```lua
local RAW_URL    = "https://raw.githubusercontent.com/HaZcK/ChromaHub/main/"
local GAMEID_URL = RAW_URL .. "Gameid.json"
local SCRIPT_URL = RAW_URL .. "ScriptGame/"
```

---

## 📋 Catatan Penting

- Pastikan repo GitHub kamu **Public** agar `game:HttpGet()` bisa akses raw file
- Setiap file `.lua` di `ScriptGame/` harus nama filenya **sama persis** dengan field `"script"` di `Gameid.json`
- LibraryScript menggunakan `getgenv()` untuk share data antar script — pastikan executor kamu support ini
- Tested di **Delta Android executor**

---

## 👤 Credits

```
Developer  : HaZcK
GitHub     : github.com/HaZcK/ScriptHub  
Roblox     : KHAFIDZKTP
UI Library : WindUI by Footagesus
Version    : 1.0.0
```

---

> *ChromaHub — built different.*
> 
