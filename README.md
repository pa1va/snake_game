# 🐍 Snake Game \[BETA]

[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
\[![Status](https://img.shields.io/badge/status-Beta-yellow)]

**Snake Game** is a classic game written in **x86 Assembly**, currently in **beta**, developed for learning, fun, and practicing low-level programming skills.

> ⚠️ **Warning:** This is a test version. Features may change in the final release.

---

## Prerequisites

Before running the game, install the following software:

### 1. NASM (Netwide Assembler)

Required to compile the Assembly code.

```bash
sudo apt update
sudo apt install nasm
```

### 2. DOSBox

DOS emulator required to run the game.

```bash
sudo apt update
sudo apt install dosbox
```

---

## How to Compile and Run

1. Compile the Assembly code (if using the source code):

```bash
nasm -f bin snake.asm -o snake.com
```

2. Open DOSBox and mount the folder where the game is located:

```dos
mount c /home/your_username/path/to/game
c:
```

3. Run the game:

```dos
snake.com
```

4. Enjoy! 🐍

---

## About the Project

* Developed in **x86 Assembly**.
* Purpose: To practice low-level programming and game logic.
* Future plans: Release a complete version with more features.

---
