# nimish
Make Nim support C macro.

## Usage

**translate single file**

```bash
nimish example.nish
```

**translate all files(must be with the extension ".nish")**
```bash
nimish --all
nimish -a
```

**Run as Nim file**

You can pass the same parameters as normal Nim's file, make
sure filename is at the end of the parameters list.

```bash
nimish c -r example.nish
```

## Example

**example.nish**

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


