module Logger;

import core.stdc.stdio;
import std.string : format;

debug void _debug(string msg) {
	printf("[ ~~ ] %s\n", cast(char*)msg);
}
/// Log an informational message
/// Params: msg = Message
void log(string msg) {
	printf("[INFO] %s\n", cast(char*)msg);
}
/// Log a warning message
/// Params: msg = Message
void warn(string msg) {
	printf("[WARN] %s\n", cast(char*)msg);
}
/// Log an error
/// Params: msg = Message
void error(string msg) {
	printf("[ERR!] %s\n", cast(char*)msg);
}

/// Log hex byte
void loghb(string msg, ubyte op,) {
	log(format("%s%02X\0", msg, op));
}

/// Log decimal
void logd(string msg, long op) {
	log(format("%s%d\0", msg, op));
}

debug void logexec(string msg, ushort seg, ushort ip, ubyte op) {
	_debug(format("%s | %04X:%04X    %02Xh\0", msg, seg, ip, op));
}