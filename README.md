# Human Typing Bot

A Nim-based typing automation tool that simulates human typing system-wide with realistic pauses and punctuation handling. Ideal for testing typing bots or automating typing tasks while mimicking natural human input.

## Features

* Simulates human typing with configurable delays and random jitter
* Handles punctuation with natural pauses (commas, periods, question marks, etc.)
* Normalizes special characters and quotes for better compatibility
* Supports a Google Docs mode to handle dash autocorrection quirks
* Reads input text from a file or standard input
* No dependency on heavy GUI libraries; uses `xdotool` for system-wide input simulation

## Requirements

* Nim compiler (tested with Nim 1.6+)
* `xdotool` installed and available in PATH (Linux only)
* Compatible Linux environment

## Usage

Compile the Nim script:

```bash
nim c -r humantypist.nim <inputfile.txt>
```

If no input file is provided, the program reads from standard input until EOF (Ctrl+D).

Example:

```bash
nim c -r humantypist.nim sample.txt
```

## Configuration

Edit the constants at the top of `humantypist.nim` to customize behavior:

* `googleDocsMode`: Set to `true` to auto-replace dashes with double hyphens for Google Docs compatibility.
* `baseDelayMs` and `jitterMs`: Adjust typing speed and natural randomness.

## How It Works

The program normalizes special quotes and dashes, then uses `xdotool` to type each character with realistic human pauses, including longer pauses after punctuation and occasional thinking pauses.

## Sample Test Essay

Use the included `test.txt` file or your own text to test the bot. The bot is designed to handle a wide variety of English grammar and punctuation correctly.