# Julia Optimization Tutorial

This repository contains code for a tutorial on mathematical optimization in Julia that I prepared for PhD students and employees of the algorithmics research group of TU Delft.

## Before You Get Started

Install [Julia](https://julialang.org/downloads/) and an optimizer such as [Gurobi](https://www.gurobi.com/) or [HiGHS](https://highs.dev/). The latter is open-source but unfortunately does not support some types of mathematical programming, for example, conic optimization.

In my examples, I also use [VSCode](https://code.visualstudio.com/download) as an IDE, but if you prefer you can use a different environment.

[Julia for Visual Studio Code](https://www.julia-vscode.org) is a useful extension of VSCode if you work with Julia. In VSCode, press press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd> (or <kbd>⇧</kbd> + <kbd>⌘</kbd> + <kbd>X</kbd> if you are using MacOS) and search the extension by its name.

## Julia REPL in VSCode

In VSCode, open/create a project, and press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> (or <kbd>⇧</kbd> + <kbd>⌘</kbd> + <kbd>P</kbd> if you are using MacOS) to open the command palette and find `Julia: Start REPL`. This will open Julia REPL in the terminal panel (usually at the botom of the IDE).

You can also run REPL from terminal. Go to the directory of your project, and run `julia`:

```bash
cd <project-directory>
julia
```

To quit REPL, use:


```bash
julia> exit()
```

When in Julia REPL, you can open Julia's package manager by pressing <kbd>]</kbd>. The terminal will change to something like:

```bash
(@v1.9) pkg>
```

The expression in brackets shows the environment that is currently active. To quit the package mode, press <kbd>←</kbd> (backspace).

## Starting a Julia Environment

In the package mode, run the following commands:

```julia
pkg> activate .   # activates a new environment 
pkg> instantiate  # install missing packages and create the manifest
```
