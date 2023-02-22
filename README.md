# Work in progress...
This project is part of a bigger toolchain aimed to be in a 
hardware->software type sequence.

Building an operating system on the Raspberry Pi 2 with eventual 
implementation on the aarch64 Raspberry Pi 3 & 4. 

# Introduction
- RPI-OS aarch32 & aarch64 
- Project repo piggybacking off of many online tutorials on how to create a simple OS for aarch32
  raspberry pi 2. I will be exploring creation for aarch64 rpi 3 & 4

## About
Add details on completion

## Usage
TODO

### Installation
- Steps on how to install this project, to use it.

```
$ git clone git@github.com:akielaries/RPI-OS_tut.git
$ cd /build &&
make
```
- Be very detailed here, For example, if you have tools which run on different operating systems, write installation steps for all of them.

```
$ add installations steps if you have to.
```

### Commands
- Commands to start the project.

## Development
- Langs close to the metal only

### Pre-Requisites
This project assumes you are using a linux dev environment. I am using
Kali linux on x86_64. Here are some of the prereqs for getting this 
project srtarted.
- <a href="https://docs.brew.sh/Homebrew-on-Linux" target="_blank">Install homebrew for linux</a> 
- <a href="https://developer.arm.com/downloads/-/gnu-a" target="_blank">Download the ARM GCC compiler</a>
install ARM GCC compiler via homebrew. <br>
- "elf" : bare metal
- "linux" : linux-based applications
```
$ brew install aarch64-elf-gcc
$ sudo apt-get install gcc-aarch64-linux-gnu
```
- <a href="" target="_blank"> </a>
- <a href="" target="_blank"> </a>


- A tool
- B tool

### Development Environment
Write about setting up the working environment for your project.
- How to download the project...
- How to install dependencies...


### File Structure
Add a file structure here with the basic details about files, below is an example.

```
.
├── boot
│   ├── boot_aarch32.S      // kernel entry pt for aarch32
│   └── boot_aarch64.S      // kernel entry pt for aarch64
├── build
│   ├── linker_aarch64.ld   // links our boot_*.S file w/ our dependent C files
│   ├── Makefile            // compiles our project
│   └── Makefile_cpy        // used this as ref from prev projs
├── CONTRIBUTING.md
├── docs
│   ├── bug_report.md
│   ├── feature_request.md
│   └── pull-request.md
├── imgs
│   └── img                 // includes images of project
── include
│   └── core
│       ├── stdio.h
│       ├── stdlib.h
│       └── uart.h
├── kernel
│   └── kernel.c
├── lib
│   └── core
│       ├── stdio.c
│       ├── stdlib.c
│       └── uart.c
├── LICENSE                 // licensing information
├── README.md               // some details on this project (always WIP)
└── src
    └── src.c
```

### Build
Write the build Instruction here.

### Deployment
Write the deployment instruction here.

### Contribution
Todo

### Guideline

Use common sense... <br>
**braces**: <br>
the open brace ({) goes at the end of the line before the start of the code block. <br>
the close brace (}) goes on its own line, indented to match the beginning of the line <br>
containing the corresponding open brace, and include a descriptor on the closing brace <br>
line that indicates which opening brace it matches <br>

## Resources
Add important resources here
https://developer.arm.com/downloads/-/gnu-a <br>
https://developer.arm.com/Processors/Cortex-A7 <br>
https://developer.arm.com/documentation/ddi0464/f/ <br>
https://github.com/raspberrypi <br>
https://www.raspberrypi.com/documentation/computers/linux_kernel.html <br>
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf <br>


## Gallery
add some pictures when its  time...

## Credit/Acknowledgment
  * Raspberry Pi
  * OSDevWiki
  * Adam Greenwood-Byrne
  * Paul Wratt
  * Jake Sandler
  * Akiel Aries
