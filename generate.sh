create_gitignore() {
    cat <<EOL > .gitignore
moulinette
unit_test.sh
create_project.sh
EOL
}

create_unit_test() {
    cat <<EOL > unit_test.sh
#!/bin/bash

moulinette() {
    executable=\$1
    expected_code=\$2
    expected_output_path=\$3

    output=\$(eval "\$executable" 2>&1)
    exit_code=\$?

    if [ -s "\$expected_output_path" ]; then
        expected_output=\$(cat "\$expected_output_path")
        echo "\$output" > temp_actual_output
        diff_result=\$(diff -u "\$expected_output_path" temp_actual_output)
        output_check=true
    else
        diff_result=""
        output_check=false
    fi

    if [ \$exit_code -eq \$expected_code ] && [ -z "\$diff_result" ]; then
        echo -e "\e[32mTest Passed: Output and exit code as expected. \$expected_output_path\e[0m"
    else
        echo -e "\e[31mTest Failed:\e[0m"
        if [ \$exit_code -ne \$expected_code ]; then
            echo "Expected exit code: \$expected_code, but got \$exit_code"
        fi
        if [ "\$output_check" = true ] && [ ! -z "\$diff_result" ]; then
            echo "Differences in output detected:"
            echo "\$diff_result"
        fi
    fi

    rm -f temp_actual_output
}

moulinette "./gary" 84 "./moulinette/prompt_gary_error"
moulinette "./gary 1" 0 "./moulinette/prompt_gary"

EOL

    chmod +x unit_test.sh

    mkdir -p moulinette
    rm -f moulinette/prompt_gary_error
    rm -f moulinette/prompt_gary
    echo -e "work" > moulinette/prompt_gary
    touch moulinette/prompt_gary_error
}
create_project() {
    cat <<EOL > create_project.sh
#!/bin/bash

create_makefile() {
    cat <<EOF > Makefile
SOURCES_DIR := sources
INCLUDES_DIR := includes
BUILD_DIR := build

SOURCES := \\\$(shell find \\\$(SOURCES_DIR) -type f -name '*.c')
INCLUDES := \\\$(shell find \\\$(INCLUDES_DIR) -type f -name '*.h')

NAME := gary

CC := gcc
CFLAGS := -I\\\$(INCLUDES_DIR) \\\$(OPT_FLAGS) \\\$(LD_FLAGS)
LD_FLAGS := -Wall -Wextra
LIB_FLAGS := 
OPT_FLAGS := -O3

OBJECTS := \\\$(SOURCES:\\\$(SOURCES_DIR)/%.c=\\\$(BUILD_DIR)/%.o)

GREEN := \033[0;32m
BLUE := \033[0;34m
NC := \033[0m

all: \\\$(NAME)

\\\$(NAME): \\\$(OBJECTS)
	@echo -e "\\\$(BLUE)Linking \\\$(NAME)\\\$(NC)"
	@\\\$(CC) \\\$(OBJECTS) -o \\\$(NAME) \\\$(LIB_FLAGS)
	@echo -e "\\\$(GREEN)Build complete!\\\$(NC)"

\\\$(BUILD_DIR)/%.o: \\\$(SOURCES_DIR)/%.c \\\$(INCLUDES)
	@mkdir -p \\\$(dir \\\$@)
	@echo -e "\\\$(BLUE)Compiling \\\$<\\\$(NC)"
	@\\\$(CC) \\\$(CFLAGS) -c \\\$< -o \\\$@

clean:
	@echo -e "\\\$(BLUE)Cleaning object files...\\\$(NC)"
	@rm -rf \\\$(BUILD_DIR)

fclean: clean
	@echo -e "\\\$(BLUE)Removing executable...\\\$(NC)"
	@rm -f \\\$(NAME)

re: fclean all

lazy: re
	@echo -e "\\\$(GREEN)Running unit tests...\\\$(NC)"
	@./unit_test.sh

.PHONY: all clean fclean re lazy
EOF
}

create_basic() {
    mkdir -p sources
    mkdir -p includes
    mkdir -p build

    rm -f sources/main.c
    rm -f includes/main.h

    echo -e "#include \"main.h\"\n\nint main(int ac, char **av)\n{\n\tif (ac != 2)\n\t\t return 84;\n\tprintf(\"work\\\\\\\\n\");\n\treturn 0;\n}\n" > sources/main.c
    echo -e "#ifndef __MAIN_H_\n#define __MAIN_H_\n\n#include <stdio.h>\n#endif" > includes/main.h
}

create_basic
create_makefile

EOL

    chmod +x create_project.sh
}

create_gitignore
create_unit_test
create_project