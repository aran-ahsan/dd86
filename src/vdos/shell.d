/**
 * Virtual embedded interactive shell
 */
module vdos.shell;

import ddc;
import core.stdc.string : strcmp, strlen, memcpy, strncpy;
import vcpu.core : CPU, MEMORY, MEMORYSIZE, opt_sleep;
import vdos.loader : vdos_load;
import vdos.video;
import vdos.os;
import vdos.interrupts : INT;
import vdos.ecodes : PANIC_MANUAL;
import os.io, logger, appconfig;

extern (C):

enum : int { // Shell errors
	/// Command not found
	ESHL_COMMAND_NOT_FOUND = -1,
	/// Generic error (avoid to use)
	ESHL_GENERIC_ERROR = -2,
	/// Shell session exit
	ESHL_EXIT = -3,
}

/**
 * Enter virtual shell (vDOS), assuming all modules have been initiated.
 * Uses memory location __MM_SHL_DATA for input buffer
 */
void vdos_shell() {
	/// Internal input buffer
	char *inbuf = cast(char*)(MEMORY + __MM_SHL_DATA);
SHL_S:
	//TODO: Print $PROMPT
	if (os_gcwd(inbuf))
		video_printf("\n%s%% ", inbuf);
	else // In case of failure
		video_put("\n% ");

	video_updatecur; // update cursor pos
	video_update;

	vdos_readline(inbuf, __SHL_BUFSIZE);
	if (*inbuf == '\n') goto SHL_S; // Nothing to process

	switch (vdos_command(inbuf)) {
	case ESHL_COMMAND_NOT_FOUND:
		video_puts("Bad command or file name");
		goto SHL_S;
	case ESHL_GENERIC_ERROR:
		video_puts("Something went wrong");
		goto SHL_S;
	case ESHL_EXIT:
		//TODO: Proper application exit
		return;
	default: goto SHL_S;
	}
}

/**
 * Execute a command with its arguments, useful for scripting.
 * Params: command == Command string with arguments
 * Returns: Error code (ERRORLEVEL), see Note
 * Note: This function may return negative, non-DOS-related, error codes. See
 * ESHEL_* enumeration values.
 */
int vdos_command(const(char) *command) {
	char **argv = // argument vector, sizeof(char *)
		cast(char**)(MEMORY + __MM_SHL_DATA + __SHL_BUFSIZE + 1);
	const int argc = sargs(command, argv); /// argument count

	enum uint EXE_L = 0x6578652E; /// ".exe", LSB
	enum uint COM_L = 0x6D6F632E; /// ".com", LSB

	//TODO: TREE, DIR (waiting on OS directory crawler)
	//TODO: search for executable in (virtual, user set) PATH

	int argl = cast(int)strlen(*argv);

	if (os_pexist(*argv)) {
		if (os_pisdir(*argv)) return ESHL_COMMAND_NOT_FOUND;
		uint ext = *cast(uint*)&argv[0][argl-4]; // Gross but works
		// While it is possible to compare strings (even with slices),
		// this works the fastests. This will be changed when needed.
		//TODO: Lowercase here
		switch (ext) {
		case COM_L, EXE_L:
			vdos_load(*argv);
			CPU.run;
			return 0;
		default: return ESHL_COMMAND_NOT_FOUND;
		}
	} else { // Else, try with other extensions
		//TODO: Clean this up, move +ext checking to function
		char [512]appname = void;
		memcpy(cast(char*)appname, *argv, argl); // dont copy null
		uint* appext = cast(uint*)(cast(char*)appname + argl);
		*appext = COM_L;
		*(appext + 1) = 0;
		if (os_pexist(cast(char*)appname)) {
			vdos_load(cast(char*)appname);
			CPU.run;
			return 0;
		}
		*appext = EXE_L;
		if (os_pexist(cast(char*)appname)) {
			vdos_load(cast(char*)appname);
			CPU.run;
			return 0;
		}
	}

	lowercase(*argv); // Done after for case-sensitive systems

	//
	// Internal commands
	//

	// C

	if (strcmp(*argv, "cd") == 0 || strcmp(*argv, "chdir") == 0) {
		if (argc > 1) {
			if (strcmp(argv[1], "/?") == 0) {
				video_puts(
				"Display or set current working directory\n"~
				"  CD or CHDIR [FOLDER]\n\n"~
				"By default, CD will display the current working directory"
				);
			} else {
				if (os_pisdir(*(argv + 1))) {
					os_scwd(*(argv + 1));
				} else {
					video_puts("Directory not found or entry is not a directory");
				}
			}
		} else {
			if (os_gcwd(cast(char*)command))
				video_puts(command);
			else
				video_puts("Error getting current directory");
			return 2;
		}
		return 0;
	}
	if (strcmp(*argv, "cls") == 0) {
		video_clear;
		SYSTEM.cursor[SYSTEM.screen_page].row = 0;
		SYSTEM.cursor[SYSTEM.screen_page].col = 0;
		return 0;
	}

	// D

	if (strcmp(*argv, "date") == 0) {
		CPU.AH = 0x2A;
		INT(0x21);
		const(char) *dow = void;
		switch (CPU.AL) {
		case 0,7: dow = "Sunday"; break;
		case 1:   dow = "Monday"; break;
		case 2:   dow = "Tuesday"; break;
		case 3:   dow = "Wednesday"; break;
		case 4:   dow = "Thursday"; break;
		case 5:   dow = "Friday"; break;
		case 6:   dow = "Saturday"; break;
		default:  dow = "?";
		}
		video_printf("It is currently %s %u-%02d-%02d\n",
			dow, CPU.CX, CPU.DH, CPU.DL);
		return 0;
	}

	// E

	if (strcmp(*argv, "echo") == 0) {
		if (argc == 1) {
			video_puts("ECHO is on");
		} else {
			for (size_t i = 1; i < argc; ++i)
				video_printf("%s ", argv[i]);
			video_puts;
		}
		return 0;
	}
	if (strcmp(*argv, "exit") == 0) return ESHL_EXIT;

	// H

	if (strcmp(*argv, "help") == 0) {
		video_puts(
			"Internal commands available\n\n"~
			"CD .......... Change working directory\n"~
			"CLS ......... Clear screen\n"~
			"DATE ........ Get current date\n"~
			"DIR ......... Show directory content\n"~
			"EXIT ........ Exit interactive session or script\n"~
			"TREE ........ Show directory structure\n"~
			"TIME ........ Get current time\n"~
			"MEM ......... Show memory information\n"~
			"VER ......... Show emulator and MS-DOS versions"
		);
		return 0;
	}

	// M

	if (strcmp(*argv, "mem") == 0) {
		if (argc <= 1) goto MEM_HELP;

		if (strcmp(argv[1], "/stats") == 0) {
			const uint msize = MEMORYSIZE;
			const ubyte ext = msize > 0xA_0000; // extended?
			const size_t ct = ext ? 0xA_0000 : msize; /// convential memsize
			const size_t tt = msize - ct; /// total memsize excluding convential

			int nzt; /// Non-zero (total/excluded from conventional in some cases)
			int nzc; /// Convential (<640K) non-zero
			for (size_t i; i < msize; ++i) {
				if (MEMORY[i]) {
					if (i < 0xA_0000)
						++nzc;
					else
						++nzt;
				}
			}
			video_printf(
				"Memory Type             Zero +   NZero =   Total\n" ~
				"-------------------  -------   -------   -------\n" ~
				"Conventional         %6dK   %6dK   %6dK\n" ~
				"Extended             %6dK   %6dK   %6dK\n" ~
				"-------------------  -------   -------   -------\n" ~
				"Total                %6dK   %6dK   %6dK\n",
				(ct - nzc) / 1024, nzc / 1024, ct / 1024,
				(tt - nzt) / 1024, nzt / 1024, tt / 1024,
				(msize - nzt) / 1024, (nzt + nzc) / 1024, msize / 1024
			);
			return 0;
		} else if (strcmp(argv[1], "/debug") == 0) {
			video_puts("Not implemented");
		} else if (strcmp(argv[1], "/free") == 0) {
			video_puts("Not implemented");
		} else if (strcmp(argv[1], "/?") == 0) {
MEM_HELP:		video_puts(
				"Display memory statistics\n"~
				"MEM [OPTIONS]\n\n"~
				"OPTIONS\n"~
				"/DEBUG    Not implemented\n"~
				"/FREE     Not implemented\n"~
				"/STATS    Scan memory and show statistics\n\n"~
				"By default, MEM will show memory usage"
			);
			return 0;
		}
		video_puts("Not implemented. Only /stats is implemented");
		return 0;
	}

	// T

	if (strcmp(*argv, "time") == 0) {
		CPU.AH = 0x2C;
		INT(0x21);
		video_printf("It is currently %02d:%02d:%02d.%02d\n",
			CPU.CH, CPU.CL, CPU.DH, CPU.DL);
		return 0;
	}

	// V

	if (strcmp(*argv, "ver") == 0) {
		video_printf(
			"DD/86 v"~APP_VERSION~
			", reporting MS-DOS v%u.%u (compiled: %u.%u)\n",
			MajorVersion, MinorVersion,
			DOS_MAJOR_VERSION, DOS_MINOR_VERSION
		);
		return 0;
	}

	//
	// Debugging commands
	//

	if (strcmp(*argv, "??") == 0) {
		video_puts(
`?load FILE  Load an executable FILE into memory
?p          Toggle performance mode
?panic      Manually panic
?r          Print interpreter registers info
?run        Start vcpu at current CS:IP or EIP
?s          Print stack (Planned feature)
?set        Set option (Planned feature)
?v          Set verbose mode`
		);
		return 0;
	}
	if (strcmp(*argv, "?load") == 0) {
		if (argc > 1) {
			if (os_pexist(argv[1])) {
				CPU.CS = 0; CPU.IP = 0x100; // Temporary
				vdos_load(argv[1]);
			} else
				video_puts("File not found");
		} else video_puts("Executable required");
		return 0;
	}
	if (strcmp(*argv, "?run") == 0) {
		CPU.run;
		return 0;
	}
	if (strcmp(*argv, "?v") == 0) {
		const(char) *e = void;
		if (argc >= 2) {
			switch (argv[1][0]) {
			case '0', 's':
				LOGLEVEL = LogLevel.Debug;
				e = "DEBUG";
				break;
			case '1', 'c':
				LOGLEVEL = LogLevel.Fatal;
				e = "CRTICAL";
				break;
			case '2', 'e':
				LOGLEVEL = LogLevel.Error;
				e = "ERROR";
				break;
			case '3', 'w':
				LOGLEVEL = LogLevel.Warning;
				e = "WARNING";
				break;
			case '4', 'i':
				LOGLEVEL = LogLevel.Info;
				e = "INFORMAL";
				break;
			case '5', 'd':
				LOGLEVEL = LogLevel.Debug;
				e = "DEBUG";
				break;
			default:
				e = "(invalid), input was invalid";
			} // switch
			video_puts(e);
		} else if (LOGLEVEL) {
			LOGLEVEL = LogLevel.Silence;
			e = "SILENCE";
		} else {
			debug {
				LOGLEVEL = LogLevel.Debug;
				e = "DEBUG";
			} else {
				LOGLEVEL = LogLevel.Info;
				e = "INFO";
			}
		}
		video_printf("LOGLEVEL set to %s\n", e);
		return 0;
	}
	if (strcmp(*argv, "?p") == 0) {
		opt_sleep = !opt_sleep;
		video_printf("CPU SLEEP mode: %s\n", opt_sleep ? "ON" : cast(char*)"OFF");
		return 0;
	}
	if (strcmp(*argv, "?r") == 0) {
		vdos_print_regs;
		return 0;
	}
	if (strcmp(*argv, "?s") == 0) {
		vdos_print_stack;
		return 0;
	}
	if (strcmp(*argv, "?panic") == 0) {
		vdos_panic(PANIC_MANUAL);
		return 0;
	}

	return ESHL_COMMAND_NOT_FOUND;
}

/**
 * Read a line within DOS
 * Params:
 *   buf = Buffer
 *   len = Buffer size (maximum length)
 * Returns: String length
 */
int vdos_readline(char *buf, int len) {
	import vdos.structs : CURSOR;
	import os.term : Key, KeyInfo, ReadKey;

	CURSOR *c = &SYSTEM.cursor[SYSTEM.screen_page];
	const ushort x = c.col; // initial cursor col value to update cursor position
	const ushort y = c.row; // ditto
	videochar *v = &VIDEO[(y * SYSTEM.screen_col) + x];	/// video index
	uint s;	/// string size
	uint i;	/// selection index
READ_S:
	const KeyInfo k = ReadKey;
	switch (k.keyCode) {
	case Key.Backspace:
		if (s == 0) break;
		if (i == 0) break;

		--i;
		char *p = buf + i;
		videochar *vc = v + i;

		if (i == s) {
			*p = 0;
			vc.ascii = 0;
		} else {
			uint l = s - i + 1;
			while (--l > 0) {
				*p = *(p + 1);
				vc.ascii = (vc + 1).ascii;
				++p; ++vc;
			}
		}
		--s;
		break;
	case Key.LeftArrow:
		if (i > 0) --i;
		break;
	case Key.RightArrow:
		if (i < s) ++i;
		break;
	case Key.Delete: //TODO: delete key

		break;
	case Key.Enter:
		buf[s] = '\n';
		buf[s + 1] = 0;
		video_puts; // newline, mimics Enter key
		return s + 2;
	case Key.Home:
		i = 0;
		break;
	case Key.End:
		i = s;
		break;
	default:
		// no space in buffer, abort
		if (s + 1 >= len) break;
		// anything that doesn't fit a character, abort
		//TODO: Character converter
		if (k.keyChar < 32 || k.keyChar > 126) break;

		// 012345   s=6, i=6, i == s
		//       ^
		// 012345   s=6, i=5, i < s
		//      ^
		if (i < s) { // cursor is not at the end, see examples above
			//TODO: FIXME
			char *p = buf + s; // start at the end
			uint l = s - i;
			while (--l >= 0) { // and "pull" characters to the end
				*p = *(p - 1);
				--p;
			}
		}
		//TODO: translate character in case of special codes
		// depending on current charset (cp437 or others)
		v[i].ascii = buf[i] = k.keyChar;
		++i; ++s;
		break;
	}
	// Update cursor position
	int xi = x + i;
	int yi = y;
	if (xi >= SYSTEM.screen_col) {
		xi -= SYSTEM.screen_col;
		yi += (xi / SYSTEM.screen_col) + 1;
	}
	c.col = cast(ubyte)xi;
	c.row = cast(ubyte)yi;
	video_updatecur; // update to host
	video_update;
	goto READ_S;
}

/**
 * CLI argument splitter, supports argument quoting.
 * This function inserts null-terminators.
 * Uses memory base 1400h for arguments and increments per argument lengths.
 * Params:
 *   t = User input
 *   argv = argument vector buffer
 * Returns: argument count
 * Notes: Original function by Nuke928. Modified by dd86k.
 */
int sargs(const char *t, char **argv) {
	size_t j;
	int a;

	char* mloc = cast(char*)MEMORY + 0x1400;
	const size_t sl = strlen(t);

	for (size_t i; i <= sl; ++i) {
		const char c = t[i];
		if (c == 0 || c == ' ' || c == '\n') {
			argv[a] = mloc;
			mloc += i - j + 1;
			strncpy(argv[a], t + j, i - j);
			argv[a][i - j] = 0;
			while (t[i + 1] == ' ') ++i;
			j = i + 1;
			++a;
		} else if (c == '"') {
			j = ++i;
			while (c != '"' && c != 0) ++i;
			if (c == 0) continue;
			argv[a] = mloc;
			mloc += i - j + 1;
			strncpy(argv[a], t + j, i - j);
			argv[a][i - j] = 0;
			while(t[i + 1] == ' ') ++i;
			j = ++i;
			++a;
		}
	}

	return --a;
}

/**
 * Lowercase an ASCIZ string. Must be null-terminated.
 * Params: c = String pointer
 */
void lowercase(char *c) {
	int q = void;
LCASE:
	q = *c;
	if (q == 0) return;
	if (q >= 'A' && q <= 'Z')
		*c = cast(char)(q + 32);
	++c;
	goto LCASE;
}