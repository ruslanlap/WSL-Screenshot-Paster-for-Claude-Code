# WSL-Screenshot-Paster-for-Claude-Code
Ось короткий та зрозумілий `README.md` англійською мовою, який ідеально підійде для вашого скрипта на GitHub або для збереження в архіві.

---

# WSL Screenshot Paster for Claude Code

## Description

This is a lightweight AutoHotkey v2 script for Windows 11. It allows you to seamlessly paste screenshots (taken via `Win + Shift + S`) directly into Claude Code running inside WSL via Windows Terminal.

Normally, pasting a screenshot into a CLI doesn't work. This script intercepts `Ctrl + V` in Windows Terminal. If it detects an image in your clipboard, it automatically finds the latest saved screenshot file, converts its Windows path to a WSL-compatible path (e.g., `/mnt/c/Users/...`), and pastes it. Claude Code instantly recognizes the path and converts it into an `[image#1]` tag.

## Prerequisites

* **OS:** Windows 11
* **Terminal:** Windows Terminal
* **Environment:** WSL (Windows Subsystem for Linux)
* **Tool:** [AutoHotkey v2](https://www.autohotkey.com/) (v1 will not work)

## Setup & Installation

1. Download and install AutoHotkey v2 from the official website.
2. Create a new file named `wsl_paste.ahk` anywhere on your PC.
3. Open the file in any text editor (Notepad, VS Code) and paste the script code into it.
4. Save the file.
5. Double-click `wsl_paste.ahk` to run it. You will see a green "H" icon in your system tray indicating it's active.

## How to Use

1. Take a screenshot using the standard Windows Snipping Tool (`Win + Shift + S`).
2. Focus your Windows Terminal window where Claude Code is running.
3. Press `Ctrl + V`.
4. *Magic happens:* The script fetches the correct WSL path, pastes it, and instantly restores your original image to the clipboard so you can still paste it elsewhere!

## Autostart on Boot (Optional)

If you want this script to run automatically every time you start your PC:

1. Press `Win + R` to open the Run dialog.
2. Type `shell:startup` and press Enter.
3. Create a shortcut to your `wsl_paste.ahk` file and place it in this Startup folder.