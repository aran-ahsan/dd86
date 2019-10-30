import test_utils;
import vcpu.core, vcpu.v16, vcpu.mm, vcpu.utils;

unittest {
	section("16-bit Instructions (8086)");

	// ADD

	// 00h  ADD R/M8, REG8
	CPU.CL = 0x20; // address
	CPU.AL = 12;
	mmiu8(0b11_000_001, CPU.EIP + 1);
	mmiu8(13, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 25);
	CPU.CL = 13;
	CPU.AL = 0x20; // address
	mmiu8(0b11_001_000, CPU.EIP + 1);
	mmiu8(16, CPU.AL);
	exec16(0x00);
	assert(mmfu8(CPU.AL) == 29);
	CPU.CL = 0x20; // address
	CPU.DL = 12;
	mmiu8(0b11_010_001, CPU.EIP + 1);
	mmiu8(23, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 35);
	CPU.CL = 0x20; // address
	CPU.BL = 12;
	mmiu8(0b11_011_001, CPU.EIP + 1);
	mmiu8(4, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 16);
	CPU.CL = 0x20; // address
	CPU.AH = 12;
	mmiu8(0b11_100_001, CPU.EIP + 1);
	mmiu8(4, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 16);
	CPU.CX = 0x04_20; // address:20h
	mmiu8(0b11_101_001, CPU.EIP + 1);
	mmiu8(52, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 56);
	CPU.CL = 0x20; // address
	CPU.DH = 12;
	mmiu8(0b11_110_001, CPU.EIP + 1);
	mmiu8(22, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 34);
	CPU.CL = 0x20; // address
	CPU.BH = 56;
	mmiu8(0b11_111_001, CPU.EIP + 1);
	mmiu8(4, CPU.CL);
	exec16(0x00);
	assert(mmfu8(CPU.CL) == 60);

	// 01h  ADD R/M16, REG16
	CPU.CX = 0x200; // address
	CPU.AX = 22;
	mmiu8(0b11_000_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 45);
	CPU.CX = 23;
	CPU.AX = 0x200; // address
	mmiu8(0b11_001_000, CPU.EIP + 1);
	mmiu16(23, CPU.AX);
	exec16(0x01);
	assert(mmfu16(CPU.AX) == 46);
	CPU.CX = 0x200; // address
	CPU.DX = 24;
	mmiu8(0b11_010_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 47);
	CPU.CX = 0x200; // address
	CPU.BX = 25;
	mmiu8(0b11_011_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 48);
	CPU.CX = 0x200; // address
	CPU.SP = 26;
	mmiu8(0b11_100_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 49);
	CPU.CX = 0x200; // address
	CPU.BP = 27;
	mmiu8(0b11_101_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 50);
	CPU.CX = 0x200; // address
	CPU.SI = 28;
	mmiu8(0b11_110_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 51);
	CPU.CX = 0x200; // address
	CPU.DI = 29;
	mmiu8(0b11_111_001, CPU.EIP + 1);
	mmiu16(23, CPU.CX);
	exec16(0x01);
	assert(mmfu16(CPU.CX) == 52);
	
	// 02h  ADD REG8, R/M8
	CPU.CL = 0x20; // address
	CPU.AL = 12;
	mmiu8(0b11_000_001, CPU.EIP + 1);
	mmiu8(13, CPU.CL);
	exec16(0x02);
	assert(CPU.AL == 25);
	CPU.CL = 13;
	CPU.AL = 0x20; // address
	mmiu8(0b11_001_000, CPU.EIP + 1);
	mmiu8(16, CPU.AL);
	exec16(0x02);
	assert(CPU.CL == 29);
	CPU.CL = 0x20; // address
	CPU.DL = 12;
	mmiu8(0b11_010_001, CPU.EIP + 1);
	mmiu8(23, CPU.CL);
	exec16(0x02);
	assert(CPU.DL == 35);
	CPU.CL = 0x20; // address
	CPU.BL = 12;
	mmiu8(0b11_011_001, CPU.EIP + 1);
	mmiu8(4, CPU.CL);
	exec16(0x02);
	assert(CPU.BL == 16);
	CPU.CL = 0x20; // address
	CPU.AH = 12;
	mmiu8(0b11_100_001, CPU.EIP + 1);
	mmiu8(4, CPU.CL);
	exec16(0x02);
	assert(CPU.AH == 16);
	CPU.CX = 0x04_20; // address:20h
	mmiu8(0b11_101_001, CPU.EIP + 1);
	mmiu8(52, CPU.CL);
	exec16(0x02);
	assert(CPU.CH == 56);
	CPU.CL = 0x20; // address
	CPU.DH = 12;
	mmiu8(0b11_110_001, CPU.EIP + 1);
	mmiu8(22, CPU.CL);
	exec16(0x02);
	assert(CPU.DH == 34);
	CPU.CL = 0x20; // address
	CPU.BH = 56;
	mmiu8(0b11_111_001, CPU.EIP + 1);
	mmiu8(4, CPU.CL);
	exec16(0x02);
	assert(CPU.BH == 60);

	// 03h  ADD REG16, R/M16
	CPU.CX = 400; // address
	CPU.AX = 40;
	mmiu16(280, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x03);
	assert(CPU.AX == 320);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// 04h  ADD AL, IMM8
	mmiu8(4, CPU.EIP + 1);
	CPU.AL = 12;
	exec16(0x04);
	assert(CPU.AL == 16);

	// 05h  ADD AX, IMM16
	mmiu16(4, CPU.EIP + 1);
	CPU.AX = 1200;
	exec16(0x05);
	assert(CPU.AX == 1204);

	// PUSH ES

	// 06h  PUSH ES
	CPU.ES = 189;
	exec16(0x06);
	assert(mmfu16(address(CPU.SS, CPU.SP)) == 189);

	// POP ES

	// 07h  POP ES
	CPU.ES = 83;
	exec16(0x07);
	assert(CPU.ES == 189); // sanity check

	// OR R/M8, REG8

	// 08h  OR R/M8, REG8
	CPU.CL = 160; // address
	CPU.AL = 0b0101;
	mmiu8(0b1010, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x08);
	assert(mmfu8(CPU.CL) == 0xF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// OR R/M16, REG16

	// 09h  OR R/M16, REG16
	CPU.CX = 0x4000; // address
	CPU.AX = 0xFF;
	mmiu16(0xFF00, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x09);
	assert(mmfu16(CPU.CX) == 0xFFFF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// OR REG8, R/M8

	// 0Ah  OR REG8, R/M8
	CPU.CL = 0x40; // address
	CPU.AL = 0xF;
	mmiu8(0xF0, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x0A);
	assert(CPU.AL == 0xFF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// OR REG16, R/M16

	// 0Bh  OR REG16, R/M16
	CPU.CX = 0x4000; // address
	CPU.AX = 0xFF;
	mmiu16(0xFF00, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x0B);
	assert(CPU.AX == 0xFFFF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// OR AL, IMM8

	// 0Ch  OR AL, IMM8
	mmiu8(0xF0, CPU.EIP + 1);
	CPU.AL = 0xF;
	exec16(0x0C); // OR CPU.AL, 3
	assert(CPU.AL == 0xFF);

	// OR AX, IMM16

	// 0Dh  OR AX, IMM16
	mmiu16(0xFF00, CPU.EIP + 1);
	exec16(0x0D); // OR CPU.AX, F0h
	assert(CPU.AX == 0xFFFF);

	// PUSH CS

	// 0Eh  PUSH CS
	CPU.CS = 318;
	exec16(0x0E);
	assert(mmfu16(address(CPU.SS, CPU.SP)) == 318);

	// ADC R/M8, REG8

	test("10h  ADC R/M8, REG8");
	TODO;

	// ADC R/M16, REG16

	test("11h  ADC R/M16, REG16");
	TODO;

	// ADC REG8, R/M8

	test("12h  ADC REG8, R/M8");
	TODO;

	// ADC REG16, R/M16

	test("13h  ADC REG16, R/M16");
	TODO;

	// ADC AL, IMM8

	test("14h  ADC AL, IMM8");
	TODO;

	// ADC AX, IMM16

	test("15h  ADC AX, IMM16");
	TODO;

	// PUSH SS

	// 16h  PUSH SS
	CPU.SS = 202;
	exec16(0x16);
	assert(mmfu16(address(CPU.SS, CPU.SP)) == 202);

	// POP SS

	// 17h  POP SS
	exec16(0x17);
	assert(CPU.SS == 202);

	// SBB R/M8, REG8

	test("18h  SBB R/M8, REG8");
	TODO;

	// SBB R/M16, REG16

	test("19h  SBB R/M16, REG16");
	TODO;

	// SBB REG8, R/M16

	test("1Ah  SBB REG8, R/M16");
	TODO;

	// SBB REG16, R/M16

	test("1Bh  SBB REG16, R/M16");
	TODO;

	// SBB AL, IMM8

	test("1Ch  SBB AL, IMM8");
	TODO;

	// SBB AX, IMM16

	test("1Dh  SBB AX, IMM16");
	TODO;

	// PUSH DS

	// 1Eh  PUSH DS
	CPU.DS = 444;
	exec16(0x1E);
	assert(mmfu16(address(CPU.SS, CPU.SP)) == 444);

	// POP DS

	// 1Fh  POP DS
	CPU.DS = 128;
	exec16(0x1F);
	assert(CPU.DS == 444);

	// AND R/M8, REG8

	// 20h  AND R/M8, REG8
	CPU.CL = 160; // address
	CPU.AL = 0xF;
	mmiu8(0b11, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x20);
	assert(mmfu8(CPU.CL) == 0b11);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// AND R/M16, REG16

	// 21h  AND R/M16, REG16
	CPU.CX = 0x4000; // address
	CPU.AX = 0xFF;
	mmiu16(0xFFFF, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x21);
	assert(mmfu16(CPU.CX) == 0xFF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// AND REG8, R/M8

	// 22h  AND REG8, R/M8
	CPU.CL = 0x40; // address
	CPU.AL = 0xFF;
	mmiu8(0xF, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x22);
	assert(CPU.AL == 0xF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// AND REG16, R/M16

	// 23h  AND REG16, R/M16
	CPU.CX = 0x4000; // address
	CPU.AX = 0xFFFF;
	mmiu16(0xFF, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x23);
	assert(CPU.AX == 0xFF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// AND AL, IMM8

	// 24h  AND AL, IMM8
	CPU.AL = 0xFF;
	mmiu8(0xF, CPU.EIP + 1);
	exec16(0x24);
	assert(CPU.AL == 0xF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// AND AX, IMM16

	// 25h  AND AX, IMM16
	CPU.AX = 0xFFFF;
	mmiu16(0xFF, CPU.EIP + 1);
	exec16(0x25);
	assert(CPU.AX == 0xFF);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// ES:

	// 26h  ES:
	exec16(0x26);
	assert(CPU.Segment == SEG_ES);

	// DAA
	// Examples taken from the Intel's reference manual.

	// 27h  DAA
	CPU.AF = 0;
	CPU.CF = 0;
	CPU.AL = 0xAE;
	exec16(0x27);
	assert(CPU.AL == 0x14);
	assert(CPU.AF);
	assert(CPU.PF);
	assert(CPU.CF);
	assert(CPU.SF == 0);
	assert(CPU.ZF == 0);
	CPU.AF = 0;
	CPU.CF = 0;
	CPU.AL = 0x2E;
	exec16(0x27);
	assert(CPU.AL == 0x34);
	assert(CPU.AF);
	//assert(CPU.PF == 0);
	//assert(CPU.CF);
	assert(CPU.SF == 0);
	assert(CPU.ZF == 0);

	// SUB R/M8, REG8

	// 28h  SUB R/M8, REG8
	CPU.CL = 160; // address
	CPU.AL = 40;
	mmiu8(70, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x28);
	assert(mmfu8(CPU.CL) == 30);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// SUB R/M16, REG16

	// 29h  SUB R/M16, REG16
	CPU.CX = 0x5000; // address
	CPU.AX = 1000;
	mmiu16(24000, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x29);
	assert(mmfu16(CPU.CX) == 23000);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// SUB REG8, R/M8

	// 2Ah  SUB REG8, R/M8
	CPU.CL = 0x40; // address
	CPU.AL = 200;
	mmiu8(50, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x2A);
	assert(CPU.AL == 150);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// SUB REG16, R/M16

	// 2Bh  SUB REG16, R/M16
	CPU.CX = 0x4000; // address
	CPU.AX = 65000;
	mmiu16(64000, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x2B);
	assert(CPU.AX == 1000);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// SUB AL, IMM8

	// 2Ch  SUB AL, IMM8
	mmiu8(21, CPU.EIP + 1);
	CPU.AL = 21;
	exec16(0x2C);
	assert(CPU.AL == 0);
	assert(CPU.ZF);

	// SUB AX, IMM16

	// 2Dh  SUB AX, IMM16
	CPU.AX = 2500;
	mmiu16(2500, CPU.EIP + 1);
	exec16(0x2D);
	assert(CPU.AX == 0);
	assert(CPU.ZF);

	// CS:

	// 2Eh  CS:
	exec16(0x2E);
	assert(CPU.Segment == SEG_CS);

	// DAS

	test("2Fh  DAS");
	TODO;

	// XOR

	// 30h  XOR R/M8, REG8
	CPU.CL = 200; // address
	CPU.AL = 25;
	mmiu8(50, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x30);
	assert(mmfu8(CPU.CL) == 43);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// 31h  XOR R/M16, REG16
	CPU.CX = 0x5000; // address
	CPU.AX = 2500;
	mmiu16(5000, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x31);
	assert(mmfu16(CPU.CX) == 6732);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// 32h  XOR REG8, R/M8
	CPU.CL = 0x40; // address
	CPU.AL = 100;
	mmiu8(50, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x32);
	assert(CPU.AL == 86);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// 33h  XOR REG16, R/M16
	CPU.CX = 0x4000; // address
	CPU.AX = 8086;
	mmiu16(3770, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x33);
	assert(CPU.AX == 4396);
	assert(CPU.OF == 0);
	assert(CPU.ZF == 0);

	// 34h  XOR AL, IMM8
	mmiu8(5, CPU.EIP + 1);
	CPU.AL = 0xF;
	exec16(0x34); // XOR CPU.AL, 5
	assert(CPU.AL == 0xA);

	// 35h  XOR AX, IMM16
	mmiu16(0xFF00, CPU.EIP + 1);
	CPU.AX = 0xAAFF;
	exec16(0x35); // XOR CPU.AX, FF00h
	assert(CPU.AX == 0x55FF);

	// INC

	CPU.fullreset; CPU.CS = 0;
	// 40h  INC AX
	exec16(0x40); assert(CPU.AX == 1);
	// 41h  INC CX
	exec16(0x41); assert(CPU.CX == 1);
	// 42h  INC DX
	exec16(0x42); assert(CPU.DX == 1);
	// 43h  INC BX
	exec16(0x43); assert(CPU.BX == 1);
	// 44h  INC SP
	exec16(0x44); assert(CPU.SP == 1);
	// 45h  INC BP
	exec16(0x45); assert(CPU.BP == 1);
	// 46h  INC SI
	exec16(0x46); assert(CPU.SI == 1);
	// 47h  INC SI
	exec16(0x47); assert(CPU.DI == 1);
	
	// DEC

	// 48h  DEC AX
	exec16(0x48);
	assert(CPU.AX == 0);
	// 49h  DEC CX
	exec16(0x49);
	assert(CPU.CX == 0);
	// 4Ah  DEC DX
	exec16(0x4A);
	assert(CPU.DX == 0);
	// 4Bh  DEC BX
	exec16(0x4B);
	assert(CPU.BX == 0);
	// 4Ch  DEC SP
	exec16(0x4C);
	assert(CPU.SP == 0);
	// 4Dh  DEC BP
	exec16(0x4D);
	assert(CPU.BP == 0);
	// 4Eh  DEC SI
	exec16(0x4E);
	assert(CPU.SI == 0);
	// 4Fh  DEC DI
	exec16(0x4F);
	assert(CPU.DI == 0);

	// PUSH

	CPU.SS = 0x100; CPU.SP = 0x80;

	// 50h  PUSH AX
	CPU.AX = 0xDAD;
	exec16(0x50);
	assert(CPU.AX == mmfu16(address(CPU.SS, CPU.SP)));

	// 51h  PUSH CX
	CPU.CX = 0x4488;
	exec16(0x51);
	assert(CPU.CX == mmfu16(address(CPU.SS, CPU.SP)));

	// 52h  PUSH DX
	CPU.DX = 0x4321;
	exec16(0x52);
	assert(CPU.DX == mmfu16(address(CPU.SS, CPU.SP)));

	// 53h  PUSH BX
	CPU.BX = 0x1234;
	exec16(0x53);
	assert(CPU.BX == mmfu16(address(CPU.SS, CPU.SP)));

	// 54h  PUSH SP
	exec16(0x54);
	assert(CPU.SP == mmfu16(address(CPU.SS, CPU.SP)) - 2);

	// 55h  PUSH BP
	CPU.BP = 0xFBAC;
	exec16(0x55);
	assert(CPU.BP == mmfu16(address(CPU.SS, CPU.SP)));

	// 56h  PUSH SI
	CPU.SI = 0xF00F;
	exec16(0x56);
	assert(CPU.SI == mmfu16(address(CPU.SS, CPU.SP)));

	// 57h  PUSH DI
	CPU.DI = 0xB0B;
	exec16(0x57);
	assert(CPU.DI == mmfu16(address(CPU.SS, CPU.SP)));

	// POP

	CPU.SS = 0x100; CPU.SP = 0x20;

	// 58h  POP AX
	CPU.push16(0xFFAA);
	exec16(0x58);
	assert(CPU.AX == 0xFFAA);

	// 59h  POP CX
	CPU.push16(0xFFAC);
	exec16(0x59);
	assert(CPU.CX == 0xFFAC);

	// 5Ah  POP DX
	CPU.push16(0xFFAD);
	exec16(0x5A);
	assert(CPU.DX == 0xFFAD);

	// 5Bh  POP BX
	CPU.push16(0xFFAB);
	exec16(0x5B);
	assert(CPU.BX == 0xFFAB);

	// 5Ch  POP SP
	CPU.push16(0x1FAA);
	exec16(0x5C);
	assert(CPU.SP == 0x1FAA);

	// 5Dh  POP BX
	CPU.push16(0x2FAA);
	exec16(0x5D);
	assert(CPU.BP == 0x2FAA);

	// 5Eh  POP SI
	CPU.push16(0x3FAA);
	exec16(0x5E);
	assert(CPU.SI == 0x3FAA);

	// 5Fh  POP DI
	CPU.push16(0x4FAA);
	exec16(0x5F);
	assert(CPU.DI == 0x4FAA);

	// Conditional Jumps

	// 70h  JO
	CPU.IP = 0x100;
	CPU.OF = 0;
	exec16(0x70);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.OF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x70);
	assert(CPU.IP == 0xEE);

	// 71h  JNO
	CPU.IP = 0x100;
	CPU.OF = 0;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x71);
	assert(CPU.IP == 0xEE);
	CPU.IP = 0x100;
	CPU.OF = 1;
	exec16(0x71);
	assert(CPU.IP == 0x102);

	// 72h  JB/JNAE/JC
	CPU.IP = 0x100;
	CPU.CF = 0;
	exec16(0x72);
	assert(CPU.IP == 0x102);
	mmiu8(-20, CPU.EIP + 1);
	CPU.IP = 0x100;
	CPU.CF = 1;
	exec16(0x72);
	assert(CPU.IP == 0xEE);

	// 73h  JNB/JAE/JNC
	CPU.IP = 0x100;
	CPU.CF = 1;
	exec16(0x73);
	assert(CPU.IP == 0x102);
	mmiu8(-20, CPU.EIP + 1);
	CPU.IP = 0x100;
	CPU.CF = 0;
	exec16(0x73);
	assert(CPU.IP == 0xEE);

	// 74h  JE/JZ
	CPU.IP = 0x100;
	CPU.ZF = 0;
	exec16(0x74);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.ZF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x74);
	assert(CPU.IP == 0xEE);

	// 75h  JNE/JNZ
	CPU.IP = 0x100;
	CPU.ZF = 1;
	exec16(0x75);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.ZF = 0;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x75);
	assert(CPU.IP == 0xEE);

	// 76h  JBE/JNA
	CPU.IP = 0x100;
	CPU.CF = 0;
	CPU.ZF = 0;
	exec16(0x76);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.ZF = 0;
	CPU.CF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x76);
	assert(CPU.IP == 0xEE);

	// 77h  JNBE/JA
	CPU.IP = 0x100;
	CPU.CF = 0;
	CPU.ZF = 1;
	exec16(0x77);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.ZF = 0;
	CPU.CF = 0;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x77);
	assert(CPU.IP == 0xEE);

	// 78h  JS
	CPU.IP = 0x100;
	CPU.SF = 0;
	exec16(0x78);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.SF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x78);
	assert(CPU.IP == 0xEE);

	// 79h  JNS
	CPU.IP = 0x100;
	CPU.SF = 1;
	exec16(0x79);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.SF = 0;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x79);
	assert(CPU.IP == 0xEE);

	// 7Ah  JP/JPE
	CPU.IP = 0x100;
	CPU.PF = 0;
	exec16(0x7A);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.PF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x7A);
	assert(CPU.IP == 0xEE);

	// 7Bh  JNP/JPO
	CPU.IP = 0x100;
	CPU.PF = 1;
	exec16(0x7B);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.PF = 0;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x7B);
	assert(CPU.IP == 0xEE);

	// 7Ch  JL/JNGE
	CPU.IP = 0x100;
	CPU.SF = 1;
	CPU.OF = 1;
	exec16(0x7C);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.SF = 0;
	CPU.OF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x7C);
	assert(CPU.IP == 0xEE);

	// 7Dh  JNL/JGE
	CPU.IP = 0x100;
	CPU.SF = 0;
	CPU.OF = 1;
	exec16(0x7D);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.SF = 1;
	CPU.OF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x7D);
	assert(CPU.IP == 0xEE);

	// 7Eh  JLE/JNG
	CPU.IP = 0x100;
	CPU.SF = 1;
	CPU.OF = 1;
	CPU.ZF = 0;
	exec16(0x7E);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.SF = 0;
	CPU.OF = 0;
	CPU.ZF = 1;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x7E);
	assert(CPU.IP == 0xEE);

	// 7Fh  JNLE/JG
	CPU.IP = 0x100;
	CPU.SF = 0;
	CPU.OF = 1;
	CPU.ZF = 0;
	exec16(0x7F);
	assert(CPU.IP == 0x102);
	CPU.IP = 0x100;
	CPU.SF = 0;
	CPU.OF = 0;
	CPU.ZF = 0;
	mmiu8(-20, CPU.EIP + 1);
	exec16(0x7F);
	assert(CPU.IP == 0xEE);

	// Group 1

	// 80h  GRP1 ADD
	CPU.AL = 0x40;
	mmiu8(10, CPU.AL);
	mmiu8(0b11_000_000, CPU.EIP+1);
	mmiu8(20, CPU.EIP+2);
	exec16(0x80);
	assert(mmfu8(CPU.AL) == 30);
	// 80h  GRP1 OR
	CPU.AL = 0x40;
	mmiu8(0b1100_0011, CPU.AL);
	mmiu8(0b11_001_000, CPU.EIP+1);
	mmiu8(0b0011_0000, CPU.EIP+2);
	exec16(0x80);
	assert(mmfu8(CPU.AL) == 0b1111_0011);
	test("80h  GRP1 ADC");
	TODO;
	test("80h  GRP1 SBB");
	TODO;
	// 80h  GRP1 AND
	CPU.AL = 0x40;
	mmiu8(0b0011_0011, CPU.AL);
	mmiu8(0b11_100_000, CPU.EIP+1);
	mmiu8(0b0011_0000, CPU.EIP+2);
	exec16(0x80);
	assert(mmfu8(CPU.AL) == 0b0011_0000);
	// 80h  GRP1 SUB/CMP
	CPU.AL = 0x40;
	mmiu8(45, CPU.AL);
	mmiu8(0b11_101_000, CPU.EIP+1);
	mmiu8(20, CPU.EIP+2);
	exec16(0x80);
	assert(mmfu8(CPU.AL) == 25);
	// 80h  GRP1 XOR
	CPU.AL = 0x40;
	mmiu8(40, CPU.AL);
	mmiu8(0b11_110_000, CPU.EIP+1);
	mmiu8(20, CPU.EIP+2);
	exec16(0x80);
	assert(mmfu8(CPU.AL) == 60);

	// 81h  GRP1 ADD
	CPU.AX = 0x400;
	mmiu16(40, CPU.AX);
	mmiu8(0b11_000_000, CPU.EIP+1);
	mmiu16(222, CPU.EIP+2);
	exec16(0x81);
	assert(mmfu16(CPU.AX) == 262);
	// 81h  GRP1 OR
	CPU.AX = 0x400;
	mmiu16(40, CPU.AX);
	mmiu8(0b11_001_000, CPU.EIP+1);
	mmiu16(222, CPU.EIP+2);
	exec16(0x81);
	assert(mmfu16(CPU.AX) == 254);
	test("81h  GRP1 ADC");
	TODO;
	test("81h  GRP1 SBB");
	TODO;
	// 81h  GRP1 AND
	CPU.AX = 0x400;
	mmiu16(40, CPU.AX);
	mmiu8(0b11_100_000, CPU.EIP+1);
	mmiu16(222, CPU.EIP+2);
	exec16(0x81);
	assert(mmfu16(CPU.AX) == 8);
	// 81h  GRP1 SUB/CMP
	CPU.AX = 0x400;
	mmiu16(222, CPU.AX);
	mmiu8(0b11_101_000, CPU.EIP+1);
	mmiu16(40, CPU.EIP+2);
	exec16(0x81);
	assert(mmfu16(CPU.AX) == 182);
	// 81h  GRP1 XOR
	CPU.AX = 0x400;
	mmiu16(222, CPU.AX);
	mmiu8(0b11_110_000, CPU.EIP+1);
	mmiu16(40, CPU.EIP+2);
	exec16(0x81);
	assert(mmfu16(CPU.AX) == 246);

	// Group 2

	// 82h  GRP2 ADD
	CPU.AL = 0x40;
	mmiu8(40, CPU.AL);
	mmiu8(0b11_000_000, CPU.EIP+1);
	mmiu8(20, CPU.EIP+2);
	exec16(0x82);
	assert(mmfu8(CPU.AL) == 60);
	test("82h  GRP2 ADC");
	TODO;
	test("82h  GRP2 SBB");
	TODO;
	// 82h  GRP2 SUB/CMP
	CPU.AL = 0x40;
	mmiu8(40, CPU.AL);
	mmiu8(0b11_101_000, CPU.EIP+1);
	mmiu8(20, CPU.EIP+2);
	exec16(0x82);
	assert(mmfu8(CPU.AL) == 20);

	// 83h  GRP2 ADD
	CPU.AX = 0x400;
	mmiu16(40, CPU.AX);
	mmiu8(0b11_000_000, CPU.EIP+1);
	mmiu16(20, CPU.EIP+2);
	exec16(0x83);
	assert(mmfu16(CPU.AX) == 60);
	test("83h  GRP2 ADC");
	TODO;
	test("83h  GRP2 SBB");
	TODO;
	// 83h  GRP2 SUB/CMP
	CPU.AX = 0x400;
	mmiu16(40, CPU.AX);
	mmiu8(0b11_101_000, CPU.EIP + 1);
	mmiu16(25, CPU.EIP + 2);
	exec16(0x83);
	assert(mmfu16(CPU.AX) == 15);

	// TEST

	// 84h  TEST R/M8, REG8
	CPU.CL = 240;
	mmiu8(0xF, CPU.CL);
	CPU.AL = 0xFF;
	assert(CPU.ZF == 0);
	assert(CPU.SF == 0);
	assert(CPU.PF);

	// 85h  TEST R/M16, REG16
	CPU.CX = 24000;
	mmiu16(0xFF, CPU.CL);
	CPU.AX = 0xFFFF;
	assert(CPU.ZF == 0);
	assert(CPU.SF == 0);
	assert(CPU.PF);

	// XCHG

	// 86h  XCHG REG8, R/M8
	CPU.CL = 230;
	CPU.AL = 25;
	mmiu8(50, CPU.CL);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x86);
	assert(mmfu8(CPU.CL) == 25);
	assert(CPU.AL == 50);

	// 87h  XCHG REG16, R/M16
	CPU.CX = 2300;
	CPU.AX = 1337;
	mmiu16(666, CPU.CX);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x87);
	assert(mmfu16(CPU.CX) == 1337);
	assert(CPU.AX == 666);

	// MOV REG8, R/M8

	// 88h  MOV R/M8, REG8
	CPU.AL = 34;
	mmiu8(0b11_000_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 34);
	CPU.CL = 77;
	mmiu8(0b11_001_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 77);
	CPU.DL = 123;
	mmiu8(0b11_010_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 123);
	CPU.BL = 231;
	mmiu8(0b11_011_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 231);
	CPU.AH = 88;
	mmiu8(0b11_100_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 88);
	CPU.CH = 32;
	mmiu8(0b11_101_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 32);
	CPU.DH = 32;
	mmiu8(0b11_110_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 32);
	CPU.BH = 42;
	mmiu8(0b11_111_000, CPU.EIP + 1);
	exec16(0x88);
	assert(mmfu8(CPU.AL) == 42);

	// MOV R/M16, REG16

	// 89h  MOV R/M16, REG16
	CPU.AX = 344;
	mmiu8(0b11_000_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 344);
	CPU.CX = 777;
	mmiu8(0b11_001_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 777);
	CPU.DX = 1234;
	mmiu8(0b11_010_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 1234);
	CPU.BX = 2311;
	mmiu8(0b11_011_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 2311);
	CPU.SP = 8888;
	mmiu8(0b11_100_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 8888);
	CPU.BP = 3200;
	mmiu8(0b11_101_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 3200);
	CPU.SI = 3244;
	mmiu8(0b11_110_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 3244);
	CPU.DI = 4212;
	mmiu8(0b11_111_000, CPU.EIP + 1);
	exec16(0x89);
	assert(mmfu16(CPU.AX) == 4212);

	// MOV R/M16, REG16

	// 8Ah  MOV REG8, R/M8
	CPU.AL = 56;
	mmiu8(CPU.AL, CPU.AL);
	mmiu8(0b11_000_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.AL == 56);
	CPU.CL = 152;
	mmiu8(CPU.CL, CPU.AL);
	mmiu8(0b11_001_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.CL == 152);
	CPU.DL = 159;
	mmiu8(CPU.DL, CPU.AL);
	mmiu8(0b11_010_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.DL == 159);
	CPU.BL = 129;
	mmiu8(CPU.BL, CPU.AL);
	mmiu8(0b11_011_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.BL == 129);
	CPU.AH = 176;
	mmiu8(CPU.AH, CPU.AL);
	mmiu8(0b11_100_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.AH == 176);
	CPU.CH = 166;
	mmiu8(CPU.CH, CPU.AL);
	mmiu8(0b11_101_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.CH == 166);
	CPU.DH = 198;
	mmiu8(CPU.DH, CPU.AL);
	mmiu8(0b11_110_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.DH == 198);
	CPU.BH = 111;
	mmiu8(CPU.BH, CPU.AL);
	mmiu8(0b11_111_000, CPU.EIP + 1);
	exec16(0x8A);
	assert(CPU.BH == 111);

	// MOV REG16, R/M16

	// 8Bh  MOV REG16, R/M16
	CPU.AX = 5600;
	mmiu16(CPU.AX, CPU.AX);
	mmiu8(0b11_000_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.AX == 5600);
	CPU.CX = 1520;
	mmiu16(CPU.CX, CPU.AX);
	mmiu8(0b11_001_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.CX == 1520);
	CPU.DX = 1590;
	mmiu16(CPU.DX, CPU.AX);
	mmiu8(0b11_010_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.DX == 1590);
	CPU.BX = 1290;
	mmiu16(CPU.BX, CPU.AX);
	mmiu8(0b11_011_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.BX == 1290);
	CPU.SP = 1760;
	mmiu16(CPU.SP, CPU.AX);
	mmiu8(0b11_100_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.SP == 1760);
	CPU.BP = 1660;
	mmiu16(CPU.BP, CPU.AX);
	mmiu8(0b11_101_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.BP == 1660);
	CPU.SI = 1984;
	mmiu16(CPU.SI, CPU.AX);
	mmiu8(0b11_110_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.SI == 1984);
	CPU.DI = 1110;
	mmiu16(CPU.DI, CPU.AX);
	mmiu8(0b11_111_000, CPU.EIP + 1);
	exec16(0x8B);
	assert(CPU.DI == 1110);

	// MOV R/M16, SEGREG

	// 8Ch  MOV R/M16, SEGREG
	CPU.CS = 123; CPU.DS = 124; CPU.ES = 125; CPU.SS = 126;
	CPU.AX = 0x4440; // address
	mmiu8(0b11_101_000, CPU.EIP + 1);
	exec16(0x8C);
	assert(mmfu16(CPU.AX) == CPU.CS);
	mmiu8(0b11_111_000, CPU.EIP + 1);
	exec16(0x8C);
	assert(mmfu16(CPU.AX) == CPU.DS);
	mmiu8(0b11_100_000, CPU.EIP + 1);
	exec16(0x8C);
	assert(mmfu16(CPU.AX) == CPU.ES);
	mmiu8(0b11_110_000, CPU.EIP + 1);
	exec16(0x8C);
	assert(mmfu16(CPU.AX) == CPU.SS);

	// LEA REG16, MEM16

	// 8Dh  LEA REG16, MEM16
	CPU.SI = 0xAAAA;
	mmiu8(0b11_000_110, CPU.EIP + 1);
	exec16(0x8D);
	assert(CPU.AX == CPU.SI);

	// MOV SEGREG, R/M16

	// 8Eh  MOV SEGREG, R/M16
	mmiu8(0b11_101_000, CPU.EIP + 1);
	mmiu16(8922, CPU.AX);
	exec16(0x8E);
	assert(CPU.CS == 8922);
	mmiu8(0b11_111_000, CPU.EIP + 1);
	mmiu16(4932, CPU.AX);
	exec16(0x8E);
	assert(CPU.DS == 4932);
	mmiu8(0b11_100_000, CPU.EIP + 1);
	mmiu16(7632, CPU.AX);
	exec16(0x8E);
	assert(CPU.ES == 7632);
	mmiu8(0b11_110_000, CPU.EIP + 1);
	mmiu16(9999, CPU.AX);
	exec16(0x8E);
	assert(CPU.SS == 9999);

	// POP R/M16

	// 8Fh  POP R/M16
	CPU.CX = 0x4000;
	CPU.push16(1234);
	mmiu8(0b11_000_001, CPU.EIP + 1);
	exec16(0x8F);
	assert(mmfu16(CPU.CX) == 1234);

	// XCHG

	// 90h  NOP
	{ // Nevertheless, let's test the Program Counter
		CPU.AX = cast(ushort)(CPU.IP + 1); // expected IP
		exec16(0x90);
		assert(CPU.AX == CPU.IP);
	}

	// 91h  XCHG AX, CX
	CPU.AX = 0xFAB;
	CPU.CX = 0xAABB;
	exec16(0x91);
	assert(CPU.AX == 0xAABB);
	assert(CPU.CX == 0xFAB);

	// 92h  XCHG AX, DX
	CPU.AX = 0xFAB;
	CPU.DX = 0xAABB;
	exec16(0x92);
	assert(CPU.AX == 0xAABB);
	assert(CPU.DX == 0xFAB);

	// 93h  XCHG AX, BX
	CPU.AX = 0xFAB;
	CPU.BX = 0xAABB;
	exec16(0x93);
	assert(CPU.AX == 0xAABB);
	assert(CPU.BX == 0xFAB);

	// 94h  XCHG AX, SP
	CPU.AX = 0xFAB;
	CPU.SP = 0xAABB;
	exec16(0x94);
	assert(CPU.AX == 0xAABB);
	assert(CPU.SP == 0xFAB);

	// 95h  XCHG AX, BP
	CPU.AX = 0xFAB;
	CPU.BP = 0xAABB;
	exec16(0x95);
	assert(CPU.AX == 0xAABB);
	assert(CPU.BP == 0xFAB);

	// 96h  XCHG AX, SI
	CPU.AX = 0xFAB;
	CPU.SI = 0xAABB;
	exec16(0x96);
	assert(CPU.AX == 0xAABB);
	assert(CPU.SI == 0xFAB);

	// 97h  XCHG AX, DI
	CPU.AX = 0xFAB;
	CPU.DI = 0xAABB;
	exec16(0x97);
	assert(CPU.AX == 0xAABB);
	assert(CPU.DI == 0xFAB);

	// CBW

	// 98h  CBW
	CPU.AL = 0;
	exec16(0x98);
	assert(CPU.AH == 0);
	CPU.AL = 0xFF;
	exec16(0x98);
	assert(CPU.AH == 0xFF);

	// CWD

	// 99h  CWD
	CPU.AX = 0;
	exec16(0x99);
	assert(CPU.DX == 0);
	CPU.AX = 0xFFFF;
	exec16(0x99);
	assert(CPU.DX == 0xFFFF);

	// WAIT

	test("9Bh  WAIT");
	TODO;

	// PUSHF

	// 9Ch  PUSHF
	exec16(0x9C);
	assert(mmfu16(address(CPU.SS, CPU.SP)) == CPU.FLAGS);

	// POPF

	// 9Dh  POPF
	CPU.BX = CPU.FLAG;
	exec16(0x9D); // Popped!
	assert(CPU.BX == CPU.FLAGS);

	// SAHF

	// 9Eh  SAHF
	CPU.AH = 1;
	exec16(0x9E);
	assert(CPU.FLAG == 3);

	// LAHF

	// 9Fh  LAHF
	CPU.FLAG = 7; // 111
	exec16(0x9F);
	assert(CPU.FLAG == 7); // 101

	// MOV AL, MEM8

	// A0h  MOV AL, MEM8
	mmiu8(167, 0x8000);
	mmiu16(0x8000, CPU.EIP + 1);
	exec16(0xA0);
	assert(CPU.AL == 167);

	// MOV AX, MEM16

	// A1h  MOV AX, MEM16
	mmiu16(1670, 0x8000);
	mmiu16(0x8000, CPU.EIP + 1);
	exec16(0xA1);
	assert(CPU.AX == 1670);

	// MOV MEM8, AL

	// A2h  MOV MEM8, AL
	CPU.AL = 143;
	mmiu16(0x4000, CPU.EIP + 1);
	exec16(0xA2);
	assert(mmfu8(0x4000) == 143);

	// MOV MEM16, AX

	// A3h  MOV MEM16, AX
	CPU.AX = 1430;
	mmiu16(0x4000, CPU.EIP + 1);
	exec16(0xA3);
	assert(mmfu16(0x4000) == 1430);

	// CMPS

	CPU.DF = 0;

	// A6h  CMPS
	CPU.CS = CPU.ES = 0xF00; CPU.DI = CPU.EIP = 0x100;
	mmistr("HELL", get_ip);
	CPU.CS = CPU.DS = 0xF00; CPU.SI = CPU.EIP = 0x110;
	mmistr("HeLL", get_ip);
	exec16(0xA6);
	assert(CPU.ZF);
	exec16(0xA6);
	assert(!CPU.ZF);
	exec16(0xA6);
	assert(CPU.ZF);
	exec16(0xA6);
	assert(CPU.ZF);

	// A7h  CMPSW
	CPU.CS = CPU.ES = 0xF00; CPU.DI = CPU.EIP = 0x100;
	mmiwstr("HELL"w, get_ip);
	CPU.CS = CPU.DS = 0xF00; CPU.SI = CPU.EIP = 0x110;
	mmiwstr("HeLL"w, get_ip);
	exec16(0xA7);
	assert(CPU.ZF);
	exec16(0xA7);
	assert(!CPU.ZF);
	exec16(0xA7);
	assert(CPU.ZF);
	exec16(0xA7);
	assert(CPU.ZF);

	// TEST AL, IMM8

	// A8h  TEST AL, IMM8
	CPU.AL = 0b1100;
	mmiu8(0b1100, CPU.EIP + 1);
	exec16(0xA8);
	assert(CPU.PF);
	assert(CPU.ZF == 0);
	assert(CPU.SF == 0);
	assert(CPU.CF == 0);
	assert(CPU.OF == 0);
	CPU.AL = 0xF0;
	mmiu8(0x0F, CPU.EIP + 1);
	exec16(0xA8);
	assert(CPU.PF);
	assert(CPU.ZF);
	assert(CPU.SF == 0);
	assert(CPU.CF == 0);
	assert(CPU.OF == 0);

	// TEST AX, IMM16

	// A9h  TEST AX, IMM16
	CPU.AX = 0xAA00;
	mmiu16(0xAA00, CPU.EIP + 1);
	exec16(0xA9);
	assert(CPU.PF);
	assert(CPU.ZF == 0);
	assert(CPU.SF);
	assert(CPU.CF == 0);
	assert(CPU.OF == 0);

	// STOS

	// AAh  STOS
	CPU.ES = 0x20; CPU.DI = 0x20;        
	CPU.AL = 'Q';
	exec16(0xAA);
	assert(MEM[address(CPU.ES, CPU.DI - 1)] == 'Q');

	// ABh  STOSW
	CPU.ES = 0x200; CPU.DI = 0x200;        
	CPU.AX = 0xACDC;
	exec16(0xAB);
	assert(mmfu16(address(CPU.ES, CPU.DI - 2)) == 0xACDC);

	// LODS

	// ACh  LODS
	CPU.AL = 0;
	CPU.DS = 0xA0; CPU.SI = 0x200;
	MEM[address(CPU.DS, CPU.SI)] = 'H';
	exec16(0xAC);
	assert(CPU.AL == 'H');
	MEM[address(CPU.DS, CPU.SI)] = 'e';
	exec16(0xAC);
	assert(CPU.AL == 'e');

	// ADh  LODSW
	CPU.AX = 0;
	CPU.DS = 0x40; CPU.SI = 0x80;
	mmiu16(0x48AA, address(CPU.DS, CPU.SI));
	exec16(0xAD);
	assert(CPU.AX == 0x48AA);
	mmiu16(0x65BB, address(CPU.DS, CPU.SI));
	exec16(0xAD);
	assert(CPU.AX == 0x65BB);

	// SCAS

	// AEh  SCAS
	CPU.ES = CPU.CS = 0x400; CPU.DI = 0x20; CPU.IP = 0x20;
	CPU.EIP = get_ip;
	mmistr("Hello!");
	CPU.AL = 'H';
	exec16(0xAE);
	assert(CPU.ZF);
	CPU.AL = '1';
	exec16(0xAE);
	assert(!CPU.ZF);

	// AFh  SCASW
	CPU.CS = 0x800; CPU.ES = 0x800; CPU.EIP = 0x30; CPU.DI = 0x30;
	mmiu16(0xFE22, address(CPU.ES, CPU.DI));
	CPU.AX = 0xFE22;
	exec16(0xAF);
	assert(CPU.ZF);
	exec16(0xAF);
	assert(!CPU.ZF);

	// MOV REG8, IMM8

	// B0h  MOV AL, IMM8
	mmiu8(0x1, CPU.EIP + 1);
	exec16(0xB0); // MOV AL, 1
	assert(CPU.AL == 1);

	// B1h  MOV CL, IMM8
	mmiu8(0x2, CPU.EIP + 1);
	exec16(0xB1); // MOV CL, 2
	assert(CPU.CL == 2);

	// B2h  MOV DL, IMM8
	mmiu8(0x3, CPU.EIP + 1);
	exec16(0xB2); // MOV DL, 3
	assert(CPU.DL == 3);

	// B3h  MOV BL, IMM8
	mmiu8(0x4, CPU.EIP + 1);
	exec16(0xB3); // MOV BL, 4
	assert(CPU.BL == 4);

	// B4h  MOV AH, IMM8
	mmiu8(0x5, CPU.EIP + 1);
	exec16(0xB4); // MOV AH, 5
	assert(CPU.AH == 5);

	// B5h  MOV CH, IMM8
	mmiu8(0x6, CPU.EIP + 1);
	exec16(0xB5); // MOV CH, 6
	assert(CPU.CH == 6);

	// B6h  MOV DH, IMM8
	mmiu8(0x7, CPU.EIP + 1);
	exec16(0xB6); // MOV DH, 7
	assert(CPU.DH == 7);

	// B7h  MOV BH, IMM8
	mmiu8(0x8, CPU.EIP + 1);
	exec16(0xB7); // MOV BH, 8
	assert(CPU.BH == 8);

	// MOV REG16, IMM16

	// B8h  MOV AX, IMM16
	mmiu16(0x1112, CPU.EIP + 1);
	exec16(0xB8); // MOV AX, 1112h
	assert(CPU.AX == 0x1112);

	// B9h  MOV CX, IMM16
	mmiu16(0x1113, CPU.EIP + 1);
	exec16(0xB9); // MOV CX, 1113h
	assert(CPU.CX == 0x1113);

	// BAh  MOV DX, IMM16
	mmiu16(0x1114, CPU.EIP + 1);
	exec16(0xBA); // MOV DX, 1114h
	assert(CPU.DX == 0x1114);

	// BBh  MOV BX, IMM16
	mmiu16(0x1115, CPU.EIP + 1);
	exec16(0xBB); // MOV BX, 1115h
	assert(CPU.BX == 0x1115);

	// BCh  MOV SP, IMM16
	mmiu16(0x1116, CPU.EIP + 1);
	exec16(0xBC); // MOV SP, 1116h
	assert(CPU.SP == 0x1116);

	// BDh  MOV BP, IMM16
	mmiu16(0x1117, CPU.EIP + 1);
	exec16(0xBD); // MOV BP, 1117h
	assert(CPU.BP == 0x1117);

	// BEh  MOV SI, IMM16
	mmiu16(0x1118, CPU.EIP + 1);
	exec16(0xBE); // MOV SI, 1118h
	assert(CPU.SI == 0x1118);

	// BFh  MOV DI, IMM16
	mmiu16(0x1119, CPU.EIP + 1);
	exec16(0xBF); // MOV DI, 1119h
	assert(CPU.DI == 0x1119);

	// RET

	// C2h  RET IMM16 (NEAR)
	CPU.IP = 0x200;
	CPU.push16(CPU.IP);
	CPU.IP = 0x340;
	exec16(0xC2);
	assert(CPU.IP == 0x200);
	//TODO: Check SP

	// C3h  RET (NEAR)
	CPU.IP = 0x200;
	CPU.push16(CPU.IP);
	CPU.IP = 0x340;
	exec16(0xC3);
	assert(CPU.IP == 0x200);

	// LES

	// C4h  LES REG16, MEM16
	CPU.CX = 0x3000;
	mmiu16(0x5000, CPU.CX);
	mmiu8(0b11_111_001, CPU.EIP + 1);
	exec16(0xC4);
	assert(CPU.DI == 0x5000);
	assert(CPU.Segment == SEG_ES);

	// LDS

	// C5h  LDS REG16, MEM16
	CPU.CX = 0x4000;
	mmiu16(0x6000, CPU.CX);
	mmiu8(0b11_111_001, CPU.EIP + 1);
	exec16(0xC5);
	assert(CPU.DI == 0x6000);
	assert(CPU.Segment == SEG_DS);

	// MOV

	// C6h  MOV MEM8, IMM8
	CPU.CL = 240;
	mmiu8(0b11_000_001, CPU.EIP + 1);
	mmiu8(24, CPU.EIP + 2);
	exec16(0xC6);
	assert(mmfu8(CPU.CL) == 24);

	// C7h  MOV MEM16, IMM16
	CPU.CX = 24000;
	mmiu8(0b11_000_001, CPU.EIP + 1);
	mmiu16(2400, CPU.EIP + 2);
	exec16(0xC7);
	assert(mmfu16(CPU.CX) == 2400);

	// RET

	// CAh  RET IMM16 (FAR)
	CPU.SP = 0x1000;
	CPU.IP = 0x100;
	CPU.CS = 0x800;
	CPU.push16(CPU.CS);
	CPU.push16(CPU.IP);
	CPU.IP = 0x200;
	CPU.CS = 0x400;
	CPU.EIP = get_ip;
	CPU.BX = CPU.SP; // old SP
	mmiu16(0x100, CPU.EIP + 1);
	exec16(0xCA);
	assert(CPU.IP == 0x100);
	assert(CPU.CS == 0x800);
	assert(CPU.SP == 0x1100);

	// CBh  RET (FAR)
	CPU.IP = 0x200;
	CPU.CS = 0x900;
	CPU.push16(CPU.CS);
	CPU.push16(CPU.IP);
	CPU.IP = 0x300;
	CPU.CS = 0x500;
	exec16(0xCB);
	assert(CPU.IP == 0x200);
	assert(CPU.CS == 0x900);

	// INT

	test("CCh  INT 3");
	TODO;

	test("CDh  INT IMM8");
	TODO;

	test("CEh  INTO");
	TODO;

	// IRET

	test("CFh  IRET");
	TODO;

	// Group 2, R/M8, 1

	test("D0h  GRP2 ROL R/M8, 1");
	TODO;
	test("D0h  GRP2 ROR R/M8, 1");
	TODO;
	test("D0h  GRP2 RCL R/M8, 1");
	TODO;
	test("D0h  GRP2 RCR R/M8, 1");
	TODO;
	test("D0h  GRP2 SAL/SHL R/M8, 1");
	TODO;
	test("D0h  GRP2 SHR R/M8, 1");
	TODO;
	test("D0h  GRP2 SAR R/M8, 1");
	TODO;

	// Group 2, R/M16, 1

	test("D1h  GRP2 ROL R/M16, 1");
	TODO;
	test("D1h  GRP2 ROR R/M16, 1");
	TODO;
	test("D1h  GRP2 RCL R/M16, 1");
	TODO;
	test("D1h  GRP2 RCR R/M16, 1");
	TODO;
	test("D1h  GRP2 SAL/SHL R/M16, 1");
	TODO;
	test("D1h  GRP2 SHR R/M16, 1");
	TODO;
	test("D1h  GRP2 SAR R/M16, 1");
	TODO;

	// Group 2, R/M8, CL

	test("D2h  GRP2 ROL R/M8, CL");
	TODO;
	test("D2h  GRP2 ROR R/M8, CL");
	TODO;
	test("D2h  GRP2 RCL R/M8, CL");
	TODO;
	test("D2h  GRP2 RCR R/M8, CL");
	TODO;
	test("D2h  GRP2 SAL/SHL R/M8, CL");
	TODO;
	test("D2h  GRP2 SHR R/M8, CL");
	TODO;
	test("D2h  GRP2 SAR R/M8, CL");
	TODO;

	// Group 2, R/M16, CL

	test("D3h  GRP2 ROL R/M16, CL");
	TODO;
	test("D3h  GRP2 ROR R/M16, CL");
	TODO;
	test("D3h  GRP2 RCL R/M16, CL");
	TODO;
	test("D3h  GRP2 RCR R/M16, CL");
	TODO;
	test("D3h  GRP2 SAL/SHL R/M16, CL");
	TODO;
	test("D3h  GRP2 SHR R/M16, CL");
	TODO;
	test("D3h  GRP2 SAR R/M16, CL");
	TODO;

	// AAM

	test("D4h  AAM");
	TODO;

	// AAD

	test("D5h  AAD");
	TODO;

	// XLAT SOURCE-TABLE

	// D7h  XLAT SOURCE-TABLE
	CPU.AL = 10;
	CPU.DS = 0x400;
	CPU.BX = 0x20;
	mmiu8(36, address(CPU.DS, CPU.BX) + CPU.AL);
	exec16(0xD7);
	assert(CPU.AL == 36);

	// LOOP

	test("E0h  LOOPNE/LOOPNZ");
	TODO;

	test("E1h  LOOPE/LOOPZ");
	TODO;

	test("E2h  LOOP");
	TODO;

	// JCXZ

	test("E3h  JCXZ");
	TODO;

	// CALL

	test("E8h  CALL IMM16 (NEAR)");
	TODO;

	// JMP

	test("E9h  JMP (NEAR)");
	TODO;

	test("EAh  JMP (FAR)");
	TODO;

	test("EBh  JMP (SHORT)");
	TODO;

	// LOCK

	test("F0h  LOCK");
	TODO;

	// REPNE/REPNZ

	test("F2h  REPNE/REPNZ");
	TODO;

	// REP/REPE/REPNZ

	test("F3h  REP/REPE/REPNZ");
	TODO;

	// HLT

	test("F4h  HLT");
	TODO;

	// CMC

	CPU.CF = 0;
	exec16(0xF5); assert(CPU.CF); 

	// Group 3, 8-bit

	// F6h  GRP3 TEST
	CPU.AL = 130;
	mmiu8(0xAF, CPU.AL);
	mmiu8(0b11_000_000, CPU.EIP + 1);
	mmiu8(0xF, CPU.EIP + 2);
	exec16(0xF6);
	assert(CPU.ZF == 0 && CPU.OF == 0);
	// F6h  GRP3 NOT
	mmiu8(0b11_010_000, CPU.EIP + 1);
	mmiu8(0xF, CPU.AL);
	exec16(0xF6);
	assert(mmfu8(CPU.AL) == 0xF0);
	// F6h  GRP3 NEG
	mmiu8(0b11_011_000, CPU.EIP + 1);
	mmiu8(0xF, CPU.AL);
	exec16(0xF6);
	assert(mmfu8(CPU.AL) == 0xF1);
	assert(CPU.ZF == 0);
	assert(CPU.OF == 0);
	// F6h  GRP3 MUL
	mmiu8(0b11_100_000, CPU.EIP + 1);
	mmiu8(2, CPU.EIP + 2);
	mmiu8(4, CPU.AL);
	exec16(0xF6);
	assert(mmfu8(CPU.AL) == 8);
	assert(CPU.ZF == 0);
	// F6h  GRP3 IMUL
	mmiu8(0b11_101_000, CPU.EIP + 1);
	mmiu8(-2, CPU.EIP + 2);
	mmiu8(4, CPU.AL);
	exec16(0xF6);
	assert(mmfu8(CPU.AL) == 0xF8); // -8 as BYTE
	assert(CPU.ZF == 0);
	// F6h  GRP3 DIV
	CPU.AX = 12;
	mmiu8(0b11_110_000, CPU.EIP + 1);
	mmiu8(8, CPU.AL);
	exec16(0xF6);
	assert(CPU.AL == 1);
	assert(CPU.AH == 4);
	// F6h  GRP3 IDIV
	CPU.AX = 0xFFF4; // -12
	mmiu8(0b11_111_000, CPU.EIP + 1);
	mmiu8(8, CPU.AL);
	exec16(0xF6);
	assert(CPU.AL == 0xFF);
	assert(CPU.AH == 0xFC);

	// Group 3, 16-bit

	test("F7h  GRP3 TEST");
	TODO;
	test("F7h  GRP3 NOT");
	TODO;
	test("F7h  GRP3 NEG");
	TODO;
	test("F7h  GRP3 MUL");
	TODO;
	test("F7h  GRP3 IMUL");
	TODO;
	test("F7h  GRP3 DIV");
	TODO;
	test("F7h  GRP3 IDIV");
	TODO;

	// Flags

	/* F8h  CLC */ exec16(0xF8); assert(CPU.CF == 0); 
	/* F9h  STC */ exec16(0xF9); assert(CPU.CF); 
	/* FAh  CLI */ exec16(0xFA); assert(CPU.IF == 0); 
	/* FBh  STI */ exec16(0xFB); assert(CPU.IF); 
	/* FCh  CLD */ exec16(0xFC); assert(CPU.DF == 0); 
	/* FDh  STD */ exec16(0xFD); assert(CPU.DF); 

	// Group 4, 8-bit

	test("FEh  GRP4 INC");
	TODO;
	test("FEh  GRP4 DEC");
	TODO;

	// Group 5, 16-bit

	test("FFh  GRP4 INC");
	TODO;
	test("FFh  GRP4 DEC");
	TODO;
	test("FFh  GRP4 CALL R/M16 (NEAR)");
	TODO;
	test("FFh  GRP4 CALL MEM16 (FAR)");
	TODO;
	test("FFh  GRP4 JMP R/M16 (NEAR)");
	TODO;
	test("FFh  GRP4 JMP MEM16 (FAR)");
	TODO;
	test("FFh  GRP4 PUSH MEM16");
	TODO;
}