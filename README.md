# nimish
Make Nim support C macro.

## Usage

**translate single file**

```bash
nimish example.nim.c
```

**translate all files(must be with the extension ".c")**
```bash
nimish --all
nimish -a
```

## Example

**example.nim.c**

```nim
#define text 12
#define name "string"
#define Add(a, b) a + b


proc hello(a: int) =
  echo "Hello, World!"
  echo text
  echo Add(3, 4)
  echo name
```

Type `nimish example.nim.c` ->

**example.nim**
```nim


# 1 "example.nim.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "example.nim.c"



proc hello(a: int) =
  echo "Hello, World!"
  echo 12
  echo 3 + 4
  echo "string"
```
