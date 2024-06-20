# Epilazy

Epilazy is a simple C project setup tool designed to streamline the creation of basic C projects with a pre-configured Makefile, unit tests, and directory structure.

## Project Structure

The project is structured as follows:

```
Epilazy/
├── .gitignore
├── create_project.sh
├── includes/
│   └── main.h
├── Makefile
├── moulinette/
│   ├── prompt_gary
│   └── prompt_gary_error
├── sources/
│   └── main.c
├── unit_test.sh
└── build/
```

## Getting Started

### Prerequisites

- Bash
- GCC (GNU Compiler Collection)

### Installation

Clone the repository and navigate into the project directory:

```sh
git clone <repository-url>
cd Epilazy
```

### Usage

1. **Create Project Structure**

   Run the `create_project.sh` script to set up the basic project structure:

   ```sh
   ./create_project.sh
   ```

   This script will create the necessary directories (`sources`, `includes`, `build`), a basic `main.c` file, a `main.h` header file, and a `Makefile`.

2. **Build the Project**

   Use the `make` command to compile the project:

   ```sh
   make
   ```

   This will compile the source files and produce an executable named `gary`.

3. **Clean the Project**

   To remove the object files, run:

   ```sh
   make clean
   ```

   To remove both object files and the executable, run:

   ```sh
   make fclean
   ```

4. **Rebuild the Project**

   To clean and rebuild the project, run:

   ```sh
   make re
   ```

5. **Run Unit Tests**

   The project includes a `unit_test.sh` script to run basic unit tests. Execute it using:

   ```sh
   make lazy
   ```

   This will rebuild the project and run the unit tests.

## Files and Directories

- `.gitignore`: Specifies files and directories to be ignored by Git.
- `create_project.sh`: Script to set up the basic project structure.
- `includes/`: Directory containing header files.
- `sources/`: Directory containing source files.
- `Makefile`: Makefile for building the project.
- `moulinette/`: Directory containing expected outputs for unit tests.
- `unit_test.sh`: Script for running unit tests.
- `build/`: Directory for compiled object files.

## Unit Test Script (`unit_test.sh`)

The `unit_test.sh` script includes a function `moulinette` to run tests on the compiled executable. It checks the output and exit code against expected values:

```sh
moulinette "./gary" 84 "./moulinette/prompt_gary_error"
moulinette "./gary 1" 0 "./moulinette/prompt_gary"
```

- `moulinette "./gary" 84 "./moulinette/prompt_gary_error"`: Expects the executable `gary` to return an exit code `84` and match the output in `prompt_gary_error`.
- `moulinette "./gary 1" 0 "./moulinette/prompt_gary"`: Expects the executable `gary` with argument `1` to return an exit code `0` and match the output in `prompt_gary`.

## Contributors

### Axel Deliaud [(Jard)](https://github.com/axeldld)
### Jacques Marques [(Stolym)](https://github.com/Stolym)