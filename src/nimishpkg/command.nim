import os, osproc
import strformat, strutils
import parseopt


proc translate(filename: string): string {.inline.} =
  let 
    src = filename.addFileExt("c")

  result = filename
  result.removeSuffix(".c")
  result = result.addFileExt("nim")
  moveFile(filename, src)
  discard execProcess(fmt"gcc -E {src} -o {result}")


proc cmdopt*() =
  var
    op = initOptParser()
    filename: string
    compile = false
  while true:
    op.next()
    case op.kind
    of {cmdLongOption, cmdShortOption}:
      case op.key
      of "help", "h":
        stdout.write("Usage: nimish file...")
      of "all", "a":
        for file in walkFiles("*.c"):
          discard translate(file)
      of "run", "r":
        compile = true
      else:
        discard
    of cmdArgument:
      filename = op.key
    of cmdEnd:
      break

  if filename.len != 0:
    let dest = translate(filename)
    if compile:
      var command = "nim "
      for i in 1 ..< paramCount():
        command.add(paramStr(i) & " ")
      command.add(dest)
      stdout.write execProcess(command)
