# Introduction

## Objectives

The sound of audio synthesizers always fascinated me and ...

## Overview

Provide a quick summary of each chapter.

Chapter 2 gives an overview about common synthesis concepts and evaluates why Rust was choosen as the implementation language.

## Scope of this Thesis

It's not required for the reader to have any prior knowledge of soft- and hardware tools used in music production environments.
However, a basic knowledge of signal processing and some familiarity with computer programming is beneficial to grasp the presented concepts.

## Why Rust?

Realtime audio applications must finish their signal processing in tight time bounds to ensure that the sound card can output a continious audio stream.
Missing such a bound will result in unpleasant sound glitches, and---in the worst case---renders a whole song recording useless.
Additionally, the time bounds must be as tight as possible to reduce the latency between the user input (playing a note) and the output of the calculated signal in the speaker.
Therefore, (memory-)managed languages like [Java](https://en.wikipedia.org/wiki/Java_(programming_language)), [Go](https://golang.org) or [C#](https://en.wikipedia.org/wiki/C_Sharp_(programming_language)) that use a garbage collector, which can produce undeterministic program stops while examining the state of variable references, will not receive any further consideration.
Interpreted languages like [Python](https://www.python.org/) or [Ruby](https://www.ruby-lang.org/en/) face the same problems as compiled managed languages by also having increased runtime costs.
Audio application development in those languages is still possible but commonly requires to write the signal processing as C modules and interface with them through the languages foreign function interface (FFI) (e.g. pyo \cite{pyo} uses this approach). 
Unmanaged languages like [C](https://en.wikipedia.org/wiki/C_(programming_language)) and [C++](https://en.wikipedia.org/wiki/C%2B%2B) offer the control over memory that is needed to make reliable claims about the runtime behaviour while avoiding the overhead of an additional runtime environment.
This comes with a downside in memory safety and introduces a whole new class of possible bugs compared to managed languages.
Those bugs are very likely to cause *undefined behaviour* or to crash the program. Unfortunately, they are also very hard to debug.

One of the major selling points of [Rust](https://rust-lang.org) is guaranteed memory safety *without* garbage collection and *data race freedom*while providing the same level of control over memory as C/C++.
These goals are achieved through a variety of concepts like ownership, lifetimes and borrowing to know at compile when memory can be safely freed, and to enforce that there's only a single mutable access to any variable at any given time in the run of the program.
Explaining these concepts is outside the scope of this thesis and the official [Rust Book](https://doc.rust-lang.org/book/ownership.html) \cite{RustBook} does a great job doing this in detail, hence, this is left as an exercise for the interested reader.
The [Max Planck Institute for Software Systems](http://plv.mpi-sws.org/) has started the \cite{RustBelt} RustBelt research project in 2015 to develop formal foundations for the Rust programming language.
One of the main goals of the research group is to formally investigate if the claims made about data-race freedom, memory and type safety actually hold.
<!-- Furthermore, they want to provide formal tools for verifying safe encapsulation of `unsafe` code blocks. -->
As of the time of writing there is no evidence that the claims are untrue, therefore it's assumed that they're actually hold.

In the following I will describe a number of language features that were crucial in making the decision to use Rust for the implementation of the synthesizer:  

Generics (parametric polymorphism)
:	Generics allow to write a single implementation of a function or method so that it can be used with a number of different types.
	A *generic* type in the declaration is replaced by an *type parameter*.
	Such a parameter can also be constrained so it can only be replaced with types that implement certain traits.

	[Example](https://is.gd/Ob3eqr):
	```rust
	fn sum<T>(a: T, b: T) -> T::Output {
		a + b
	}

	println!(sum(3+4));
	```

Cross compilation
:	Cross compilation is the ability to compile statically linked binaries for different target platforms on a single machine, e.g. one can compile a windows executable on a linux machine.

Abstractions without overhead
:	The Rust compiler will create a separate implementation for each type that a generic function is used with in the code.
	This is called *monomorphization* and allows to statically dispatch calls to generic functions but comes with the cost of slightly increased binary sizes.
	Iterators and other high-level features will be compiled down to simpler constructs like *for* loops.

FFI
:	A foreign function interface allows the calling of functions written in other languages.
	Rust's FFI allows to easily call functions from a variety of languages but, as a systems language, it focuses on C as the default target.
	This is of great value because most audio APIs and I/O libraries, e.g. [portaudio](http://www.portaudio.com/) or [libsoundio](http://libsound.io/), are C libraries.
	The opposite directions is possible as well, because a Rust function can be defined to use the C ABI (application binary interface) so it can be called from C or other languages that provide a C FFI.

Algebraic data types and pattern matching
:	An algebraic data type is formed by combination of other types.
	The term *algebraic* refers to the operations that are used to form the type, which is either *sum*, i.e., the type is $A$ or $B$, or *product*, i.e., it is a combination of $A$ and $B$, where $A$ and $B$ are different types.
	Rust's `enum`s are formed as *sum* types whereas `tuple`s are formed by a *product* of types.
	A classic example for the former kind is the `Option` type, which can be either `None` or have `Some` value of type $T$:

	```rust
	enum Option<T> {
	    None,
		Some(T),
	}
	```

	Destructuring the values of such types is done through *pattern matching* in Rust.
	In contrast to C-like enums, the compiler knows how much variants such an algebraic data type has and won't compile if they aren't matched exhaustively, i.e. there is at least one unmatched variant of the type.

Iterators
:	Rust provides conventional `for` loops but additionally has *iterators*.
	An iterator is something that provides a sequence of things where you can loop over.
	The great benefit of using iterators over index based access in traditional `for` loops is, that it avoids the, mostly unintended, access of elements that are outside the iterators range.
	In addition, iterators provide a vast amount of methods to combine them, filter elements, do map-reduce like operations and in many cases even parallelize the computation \cite{Rayon}.

	Example: $\sum_{x\,\in\,v_1, v_2\;\wedge\;x > 3}$

	```rust
	let v1 = [1, 2, 3];
	let v2 = [3, 4, 5];
	let sum = v1.iter().chain(v2.iter())
				.filter(|val| **val > 3)
				.fold(|acc, val| acc + val, 0);
	assert_eq!(sum, 9)
	```

Toolchain
:	Rust has a standard package manager and build tool called *Cargo*, that is typically used to manage the dependencies of a project but also to run tests and benchmarks.

# User Interface

## Midi

Midi stands for ...

## OSC (Open Sound Control)

A standard

### Lemur

App

# Synthesizer Basics

## Oscillators

### BLITs

### Wavetables

## Synthesizing Methods

### Subtractive

### Additive

### FM

## Envelopes

## Polyphony

# Signal Generation

## Aliasing

## FFT

## Band-Limited Wavetables

## Limiting

## Mixing/Panning

# Sound Shaping

## Filter

## Waveshaper

# Effects

## Delay

## Reverb

# Implementation Details

## Ring Buffer

## Control Input

## Audio Output

# Outlook

## Optimizations

# Conclusion
