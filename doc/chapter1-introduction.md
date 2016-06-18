# Introduction

## Rust

Some of the main features of Rust \cite{RustLang}:

- systems language
- zero-cost abstractions (like C++)
- guaranteed memory safety (if no `unsafe` blocks are used)
- threads without data races
- pattern matching
- type inference
- minimal runtime
- efficient C bindings

## Synthesizers

### Additive/Subtractive

### FM

### Sampler

## Open Sound Control (OSC)

Specification \cite{OSC10Spec}:

- open
- transport-independent, usually {TCP,UDP}/IP
- message based
- commonly used for communication between computers, sound synthesizers and other multimedia devices

### Data Types

OSC data is composed of the following fundamental data types:

- `int32` 32-bit big-endian signed integer
- `OSC-timetag` 64-bit big-endian fixed-point time tag
- `float32` 32-bit big-endian IEEE754 floating point-number
- `OSC-string` null-terminated sequence of non-null ASCII characters, followed by a series of padding null bytes (max. three)
- `OSC-blob`:
    - 32-bit integer size count
    - exactly size count bytes
    - padding bytes (max. of three)
- size of every atomic data type is a multiple of 32 bits (32-bit aligned)

### Packets

- transmission unit
- any application that sends OSC packets is an *OSC client*
- contrary, an *OSC server* is any application that receives OSC packets
- TCP streams should begin with an 32-bit integer that gives the size of the packet
- contents of the packet must be either an *OSC Message* or an *OSC Bundle*
- the first byte of the contents distinguishes between *Messages* and *Packets*

### Messages

structure:

- *OSC Address Pattern*
- *OSC Type Tag* String (older implementations may omit this field)
- zero or more *OSC Arguments*

Example Message:

```
header:
    path: /1/fader1
    format: ,f
float: 0.08842
```

#### Address Pattern

- OSC-string beginning with a `/`

#### Type Tag String

- OSC-string beginning with `,`
- followed by a sequence of characters corresponding to the number of OSC arguments in the message. Each character is called *OSC Type Tag*:
    - `i` 32-bit integer
    - `f` 32-bit IEEE754 float
    - `s` OSC-string
    - `b` OSC-blob
    - other unknown types should be discarded by the OSC application
- OSC applications can communicate among instances with nonstandard formats, that should be discarded by other applications that not recognize the specific format
     - any application that does use additional type tags, must encode them with type tags from this table ...

#### Arguments

- sequence of OSC arguments is represented by a contiguous sequence of the binary representation of each argument

#### OSC Bundles

- OSC-string `#bundle` followed by an *OSC Time Tag*
- followed by zero or more *OSC Bundle Elements*

## Signal Processing

### FFT

### DFFT

### z-Transform
