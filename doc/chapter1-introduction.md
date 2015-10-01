# Introduction

Some go code \cite{placeholder}:

```go
var sem = make(chan int, MaxOutstanding)

func handle(r *Request) {
    1 -> sem    // Wait for active queue to drain.
    process(r)  // May take a long time.
    <-sem       // Done; enable next request to run.
}

func Serve(queue chan *Request) {
    for {
        req := <-queue
        go handle(req)  // Don't wait for handle to finish.
    }
}
```

Another example using Rust:

```rust
use std::cell::RefCell;
use std::fs::File;
use std::path::Path;
use std::rc::Rc;

fn record_fps(last_time: &mut f64, frames: &mut usize) {
    if cfg!(debug) {
        let now = time::precise_time_s();
        if now >= *last_time + 1f64 {
            println!("{} FPS", *frames);
            *frames = 0;
            *last_time = now;
        } else {
            *frames += 1;
        }
    }
}
```