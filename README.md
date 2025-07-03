This script helps you:
- Install required Sinhala fonts (`Noto Sans Sinhala`, `Noto Serif Sinhala`, `LKLUG`)
- Apply fontconfig rules to fix broken or boxy Sinhala letters
- Choose between user-only or system-wide font configuration
- Rebuild font cache and verify it
- Ensure smooth Sinhala rendering in browsers, system UI, VLC subtitles, etc.
---

## 🛠️ How to Use

1. Clone or download this repo:
```bash
git clone https://github.com/pamodmalith/sinhala-font-fix.git
```
2. Go inside folder
```bash
cd sinhala-font-fix
```
3. Make the script executable:
```bash
chmod +x sinhala-font-setup.sh
```
4. Run the script:
```bash
./sinhala-font-setup.sh
```

---

## 📸 Screenshot

> _(Optional)_ You can add a terminal screenshot showing script steps here.

---
## 🧹 Uninstallation

To undo the changes:
```bash
chmod +x uninstall-sinhala-font-config.sh
./uninstall-sinhala-font-config.sh
```

> This will remove the Sinhala font override config from your system or user directory.
---
## 📦 What Fonts Are Used?

- [`fonts-noto-sinhala`](https://packages.debian.org/sid/fonts-noto-sinhala)
- [`fonts-lklug-sinhala`](https://packages.ubuntu.com/focal/fonts-lklug-sinhala)
- `fonts-noto-core` for overall support
## 🧪 Tested on

- Linux Mint 21/22 (Cinnamon)
- Ubuntu 22.04+
## 🧠 Why Use This?

- Fixes issues like:
    - Boxes/garbage shown instead of Sinhala
    - VLC subtitle rendering (when paired with `Noto Sans Sinhala` font)
    - Missing proper font priority for `si` language
- No need to manually mess with fontconfig XML files
## 📚 Fonts Used

- `fonts-noto-sinhala`
- [`fonts-lklug-sinhala`](https://packages.ubuntu.com/focal/fonts-lklug-sinhala)
- `fonts-noto-core` for fallback support
## 🧪 Tested on

- Linux Mint 21/22 (Cinnamon)
- Ubuntu 22.04+
---
## 👨💻 Author

**Pamod Malith Theekshana**  
📧 dev.pamodmalith@gmail.com
