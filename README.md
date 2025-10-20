# Beecrowd Solutions in C++

Solving all Beecrowd problems using C++17 or newer.

## Goals
- C++17 (or newer), standard input/output only.
- One self-contained solution per problem ID.
- No problem statements or proprietary data; link to official pages only.

## Layout
- src/problem-id.cpp
- data/problem-id/{sample.in, sample.out} *(optional)*
- bin/ **(build outputs)** *(ignored by git)*
- obj/ **(intermediate files)** *(ignored by git)*

Example:
- src/1001.cpp

## Requirements
- g++ or clang++ with C++17
- make (optional)

## Build
- Single file:
```bash
    mkdir -p bin
    g++ src/problem-id.cpp -o bin/problem-id
```
- Using Makefile:
```bash
    make bin/problem-id
```
- Or build all (not recommended, may take time):
```bash
    make all
```

## Run
```bash
    ./bin/problem-id < data/problem-id/sample.in
```
- Or provide input via stdin as per Beecrowd.

## Adding a Solution
1) Create src/<id>.cpp
2) Implement with only stdin/stdout, no prompts.
3) Test locally with sample I/O and edge cases.
4) Commit with message: Solve <id>: <short-title>

## Testing
- Compare output:
```bash
    ./bin/problem-id < data/problem-id/sample.in > out.txt
    diff -u out.txt data/problem-id/sample.out
```

## Style
- Prefer fast I/O when needed (ios::sync_with_stdio(false); cin.tie(nullptr);).
- Deterministic formatting (fixed/precision) where the problem specifies.
- Avoid undefined behavior and platform-specific calls.

## Links
- Problem page pattern: https://www.beecrowd.com.br/judge/en/problems/view/<id>
- Do not publish problem statements or official test data.

## License
- Solutions are my own; Beecrowd content is owned by Beecrowd.