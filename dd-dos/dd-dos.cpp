/*
 * dd-dos.cpp : Defines the entry point for the console application.
 */

#include "dd-dos.hpp"
#include "stdio.h"
#include "poshub.cpp"
#include "Interpreter.cpp"

#include <iostream>
#include <string>
#include <vector>

static const char *version = "0.0.0";

static poshub Con;

void DisplayVersion()
{
	std::cout << "DD-DOS - " << version << std::endl;;
	std::cout << "Project page: <https://github.com/dd86k/dd-dos>" << std::endl;
	exit(0);
}

void DisplayHelp(const char *program_name)
{
	std::cout << "Usage: " << std::endl;
	std::cout << "  " << program_name << " [<Options>] [<Program>]" << std::endl;
	std::cout << std::endl;
	std::cout << "  -h | --help       Display help and quit." << std::endl;
	std::cout << "  -v | --version    Display version and quit." << std::endl;
	exit(0);
}

int main(int argc, char **argv)
{
	std::vector<std::string> args(argv, argv + argc);

	for (const std::string &arg : args) {
		if (arg == "-v" || arg == "--version") {
			DisplayVersion();
		} else if (arg == "-h" || arg == "--help") {
			DisplayHelp(argv[0]);
        }
    }

    Con = poshub();
    Con.Init();

    Boot();

    return 0;
}
