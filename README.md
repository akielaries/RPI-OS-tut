# Work in progress...

Project repo piggybacking off a tutorial on how to create a simple OS for a raspberry pi...

# Introduction
- RPI-OS aarch32 & aarch64 
- Project repo piggybacking off a tutorial on how to create a simple OS for aarch32
  raspberry pi 2. I will be following that tutorial as well as exploring creation
  for aarch64 rpi 3 & 4

## Index

- [About](#beginner-about)
- [Usage](#zap-usage)
  - [Installation](#electric_plug-installation)
  - [Commands](#package-commands)
- [Development](#wrench-development)
  - [Pre-Requisites](#notebook-pre-requisites)
  - [Developmen Environment](#nut_and_bolt-development-environment)
  - [File Structure](#file_folder-file-structure)
  - [Build](#hammer-build)  
  - [Deployment](#rocket-deployment)  
- [Community](#cherry_blossom-community)
  - [Contribution](#fire-contribution)
  - [Branches](#cactus-branches)
  - [Guideline](#exclamation-guideline)  
- [FAQ](#question-faq)
- [Resources](#page_facing_up-resources)
- [Gallery](#camera-gallery)
- [Credit/Acknowledgment](#star2-creditacknowledgment)
- [License](#lock-license)

## About
Add details on completion

## Usage
TODO

### Installation
- Steps on how to install this project, to use it.
- Be very detailed here, For example, if you have tools which run on different operating systems, write installation steps for all of them.

```
$ add installations steps if you have to.
```

### Commands
- Commands to start the project.

## Development
- Langs close to the metal only

### Pre-Requisites
List all the pre-requisites the system needs to develop this project.
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
├── build
│   ├── linker_aarch64.ld   // links our boot_*.S file with our dependent C files
│   ├── Makefile            // compiles our project
│   └── Makefile_cpy
├── hello.c
├── lib
│   ├── core
│   │   ├── stdio.h
│   │   └── stdlib.h
│   └── kernel
│       └── uart.h
├── LICENSE
├── README.md
└── src
    ├── core
    │   ├── stdio.c
    │   └── stdlib.c
    └── kernel
        ├── boot_aarch32.S   // kernel entry pt for aarch32 
        ├── boot_aarch64.S   // kernel entry pt for aarch64
        ├── kernel.c
        └── uart.c

```

| No | File Name | Details 
|----|------------|-------|
| 1  | index | Entry point

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

## License
TODO
