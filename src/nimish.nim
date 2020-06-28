import nimishpkg / command
import os


when isMainModule:
  if paramCount() >= 1:
    cmdopt()
  else:
    stdout.write("Error: no input files")
