import os, osproc
import strformat, strutils
import parseopt


proc translate(filename: string) {.inline.} =
  let 
    src = filename.addFileExt("c")

  var dest = filename
  dest.removeSuffix(".c")
  dest = dest.addFileExt("nim")
  moveFile(filename, src)
  discard execProcess(fmt"gcc -E {src} -o {dest}")


proc cmdopt*() =
  var
    op = initOptParser()
  while true:
    op.next()
    case op.kind
    of {cmdLongOption, cmdShortOption}:
      case op.key
      of "help", "h":
        stdout.write("Usage: nimish file...")
      of "all", "a":
        for file in walkFiles("*.c"):
          translate(file)
      else:
        discard
    of cmdArgument:
      translate(op.key)
    of cmdEnd:
      break
