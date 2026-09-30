<div align="center">

# tiki-script

**open-source · deobfuscated · community-built**

A deobfuscated build of the Slayers 2 script, cleaned up and packaged for daily use.

[![Status](https://img.shields.io/badge/status-active-48e6a0?style=for-the-badge)](.)
[![License](https://img.shields.io/badge/license-open--source-ba6eff?style=for-the-badge)](.)
[![Made by](https://img.shields.io/badge/maintained%20by-Tiki-ffbe37?style=for-the-badge)](.)

</div>

---

## what this is

`tiki-script` is a deobfuscated, readable build of the original Slayers 2 script — the one everyone was already running, just cleaned up so you can actually see what it does.

No mystery chunks. No hidden loadstrings. Just the code, formatted, documented, and ready to drop into your executor.

Built for tinkerers, modders, writers, and anyone who wants to know how the thing works instead of just running it blind.

---

## features

- **fully deobfuscated** — every chunk readable, no runtime compile tricks
- **one-file loader** — UI shell and gameplay backend compile in isolated Luau chunks to dodge register limits
- **modular tabs** — Farm · Progress · Boss · Dungeons · Quest · Teleport · Player · Loot · Activities · Misc · Server
- **theme system** — 8 built-in palettes, live switching, no restart
- **open-source** — fork it, patch it, learn from it

---

## quick start

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/trustedscript/tiki-script/main/main.lua"))()
