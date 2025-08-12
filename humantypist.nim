import os, osproc, random, strutils

const
  googleDocsMode = true  # Set true if typing into Google Docs

proc normalizeQuotes(s: string, forGoogleDocs: bool): string =
  result = s.replace("’", "'")
  result = result.replace("‘", "'")
  result = result.replace("“", "\"")
  result = result.replace("”", "\"")

  if forGoogleDocs:
    # Replace dashes with double/triple hyphen for Google Docs autocorrect
    result = result.replace("—", "---")  # em dash
    result = result.replace("–", "--")   # en dash
    result = result.replace("…", "...")  # ellipsis
  else:
    result = result

proc humanTypeSystemWide(text: string, baseDelayMs = 80, jitterMs = 40) =
  for c in text:
    if c == '\n':
      discard execCmd("xdotool key Return")
    else:
      let escapedChar = if c == '"' : "\\\"" else: $c
      discard execCmd("xdotool type --delay 0 -- \"" & escapedChar & "\"")

    # base delay + random jitter for natural speed variance
    let delay = baseDelayMs + rand(-jitterMs .. jitterMs)
    os.sleep(delay)

    # Longer pauses after punctuation for human feel
    if c in {'.', '!', '?'}:
      os.sleep(300 + rand(0..300))
    elif c in {',', ';', ':'}:
      os.sleep(150 + rand(0..150))
    elif c == '\n':
      os.sleep(400 + rand(0..400))
    else:
      # small chance of thinking pause mid-sentence
      if rand(1..100) <= 2:
        os.sleep(500 + rand(0..800))

when isMainModule:
  var inputText = ""

  # Read from first CLI arg file if given, else from stdin
  if paramCount() >= 1:
    let filename = paramStr(1)
    if fileExists(filename):
      inputText = readFile(filename)
    else:
      echo "File not found: ", filename
      quit(1)
  else:
    echo "Paste your wall of text below (end with Ctrl+D):"
    inputText = newStringOfCap(1024)
    for line in stdin.lines:
      inputText.add(line)
      inputText.add('\n')

  inputText = normalizeQuotes(inputText, googleDocsMode)
  echo "\nNormalized input text:\n", inputText
  echo "\nTyping system-wide as a human will start in 10 seconds...\n"
  os.sleep(10000)
  echo "\nTyping now...\n"
  humanTypeSystemWide(inputText)
