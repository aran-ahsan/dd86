module test_utils;

import std.stdio;

enum SPACES = 30;

void test(string s) {
	writef("%-*s: ", SPACES, s);
}
void section(string s) {
	writef("\n--------- %s\n", s);
}
void sub(string s) {
	writef("\n\t%s\n", s);
}
void OK() {
	writeln("OK");
}
void TODO() {
	writeln("TODO");
}