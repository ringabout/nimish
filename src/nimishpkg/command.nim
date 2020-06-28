import os, osproc
import strformat
import parseopt


proc translate(filename: string, local = false): string {.inline.} =
  let
    (dir, name, _) = filename.splitFile

  var cacheDir: string
  if not local:
    cacheDir = getTempDir() / "nimishcache"
  else:
    cacheDir = dir / "nimishcache"
  let
    cacheFile = cacheDir / (name & ".c")

  createDir(cacheDir)

  if existsFile(filename):
    result = cacheDir / (name & ".nim")
    copyFile(filename, cacheFile)
    discard execProcess(fmt"gcc -E {cacheFile} -o {result}")
  else:
    raise newException(IOError, filename & "doesn't exist.")


proc cmdopt*() =
  var
    op = initOptParser()
    filename: string
    compile = false
    local = true
  while true:
    op.next()
    case op.kind
    of {cmdLongOption, cmdShortOption}:
      case op.key
      of "help", "h":
        stdout.write("Usage: nimish file...")
      of "all", "a":
        for file in walkFiles("*.nish"):
          discard translate(file)
      of "run", "r":
        compile = true
        local = false
      else:
        discard
    of cmdArgument:
      filename = op.key
    of cmdEnd:
      break

  if filename.len != 0:
    let dest = translate(filename, local)
    if compile:
      var command = "nim "
      for i in 1 ..< paramCount():
        command.add(paramStr(i) & " ")
      command.add(dest)
      stdout.write execProcess(command)
