import test_utils;
import vcpu.core, vcpu.exec, vcpu.mm, vcpu.utils, vcpu.modrm;
import std.stdio;

unittest {
	vcpu_init;
	CPU.CS = 0;
	CPU.EIP = get_ip;

	section("Interpreter Utilities (vcpu_utils.d)");

	test("mm: insert");
	mmiu8(0xFF, CPU.EIP);
	assert(MEM[CPU.EIP]     == 0xFF);
	mmiu8(0x12, CPU.EIP + 2);
	assert(MEM[CPU.EIP + 2] == 0x12);

	mmiu16(0x100, CPU.EIP);
	assert(MEM[CPU.EIP]     == 0);
	assert(MEM[CPU.EIP + 1] == 1);
	mmiu16(0xABCD, CPU.EIP);
	assert(MEM[CPU.EIP]     == 0xCD);
	assert(MEM[CPU.EIP + 1] == 0xAB);
	mmiu16(0x5678, 4);
	assert(MEM[4] == 0x78);
	assert(MEM[5] == 0x56);

	mmiu32(0xAABBCCFF, CPU.EIP);
	assert(MEM[CPU.EIP    ] == 0xFF);
	assert(MEM[CPU.EIP + 1] == 0xCC);
	assert(MEM[CPU.EIP + 2] == 0xBB);
	assert(MEM[CPU.EIP + 3] == 0xAA);

	mmistr("AB$");
	assert(MEM[CPU.EIP .. CPU.EIP + 3] == "AB$");
	mmistr("QWERTY", CPU.EIP + 10);
	assert(MEM[CPU.EIP + 10 .. CPU.EIP + 16] == "QWERTY");

	mmiwstr("Hi!!"w);
	assert(MEM[CPU.EIP     .. CPU.EIP + 1] == "H"w);
	assert(MEM[CPU.EIP + 2 .. CPU.EIP + 3] == "i"w);
	assert(MEM[CPU.EIP + 4 .. CPU.EIP + 5] == "!"w);
	assert(MEM[CPU.EIP + 6 .. CPU.EIP + 7] == "!"w);

	ubyte[2] ar = [ 0xAA, 0xBB ];
	mmiarr(cast(ubyte*)ar, 2, CPU.EIP);
	assert(MEM[CPU.EIP .. CPU.EIP + 2] == [ 0xAA, 0xBB ]);
	OK;

	test("mm: fetch");
	mmiu8(0xAC, CPU.EIP + 1);
	assert(mmfu8(CPU.EIP + 1) == 0xAC);
	assert(mmfu8_i == 0xAC);
	assert(mmfi8(CPU.EIP + 1) == cast(byte)0xAC);
	assert(mmfi8_i == cast(byte)0xAC);

	mmiu16(0xAAFF, CPU.EIP + 1);
	assert(mmfu16(CPU.EIP + 1) == 0xAAFF);
	assert(mmfi16(CPU.EIP + 1) == cast(short)0xAAFF);
	assert(mmfu16_i == 0xAAFF);
	assert(mmfi16_i == cast(short)0xAAFF);
	mmiu32(0xDCBA_FF00, CPU.EIP + 1);
	assert(mmfu32(CPU.EIP + 1) == 0xDCBA_FF00);
//	assert(__fu32_i == 0xDCBA_FF00);
	OK;

	test("Registers");

	CPU.EAX = 0x40_0807;
	assert(CPU.AL == 7);
	assert(CPU.AH == 8);
	assert(CPU.AX == 0x0807);

	CPU.EBX = 0x41_0605;
	assert(CPU.BL == 5);
	assert(CPU.BH == 6);
	assert(CPU.BX == 0x0605);

	CPU.ECX = 0x42_0403;
	assert(CPU.CL == 3);
	assert(CPU.CH == 4);
	assert(CPU.CX == 0x0403);

	CPU.EDX = 0x43_0201;
	assert(CPU.DL == 1);
	assert(CPU.DH == 2);
	assert(CPU.DX == 0x0201);

	CPU.ESI = 0x44_9001;
	assert(CPU.SI == 0x9001);

	CPU.EDI = 0x44_9002;
	assert(CPU.DI == 0x9002);

	CPU.EBP = 0x44_9003;
	assert(CPU.BP == 0x9003);

	CPU.ESP = 0x44_9004;
	assert(CPU.SP == 0x9004);

	CPU.EIP = 0x40_0F50;
	assert(CPU.IP == 0x0F50);

	OK;
	CPU.EIP = 0x100;

	test("EFLAGS/FLAGS");
	CPU.FLAGS = 0xFFFF;
	assert(CPU.SF); assert(CPU.ZF); assert(CPU.AF);
	assert(CPU.PF); assert(CPU.CF); assert(CPU.OF);
	assert(CPU.DF); assert(CPU.IF); assert(CPU.TF);
	assert(CPU.FLAG == 0xD7);
	assert(CPU.FLAGS == 0xFD7);
	CPU.FLAGS = 0;
	assert(CPU.SF == 0); assert(CPU.ZF == 0); assert(CPU.AF == 0);
	assert(CPU.PF == 0); assert(CPU.CF == 0); assert(CPU.OF == 0);
	assert(CPU.DF == 0); assert(CPU.IF == 0); assert(CPU.TF == 0);
	assert(CPU.FLAGS == 2);
	//TODO: CPU.EFLAGS
	OK;

	section("ModR/M");

	mmiu16(0x1020, CPU.EIP + 2); // low:20h
	CPU.SI = 0x50; CPU.DI = 0x50;
	CPU.BX = 0x30; CPU.BP = 0x30;
	test("16-bit ModR/M");
	// MOD=00
	assert(modrm16(0b000) == 0x80);
	assert(modrm16(0b001) == 0x80);
	assert(modrm16(0b010) == 0x80);
	assert(modrm16(0b011) == 0x80);
	assert(modrm16(0b100) == 0x50);
	assert(modrm16(0b101) == 0x50);
	assert(modrm16(0b110) == 0x1020);
	assert(modrm16(0b111) == 0x30);
	// MOD=01
	assert(modrm16(0b01_000_000) == 0xA0);
	--CPU.EIP;
	assert(modrm16(0b01_000_001) == 0xA0);
	--CPU.EIP;
	assert(modrm16(0b01_000_010) == 0xA0);
	--CPU.EIP;
	assert(modrm16(0b01_000_011) == 0xA0);
	--CPU.EIP;
	assert(modrm16(0b01_000_100) == 0x70);
	--CPU.EIP;
	assert(modrm16(0b01_000_101) == 0x70);
	--CPU.EIP;
	assert(modrm16(0b01_000_110) == 0x50);
	--CPU.EIP;
	assert(modrm16(0b01_000_111) == 0x50);
	--CPU.EIP;
	// MOD=10
	assert(modrm16(0b10_000_000) == 0x10A0);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_001) == 0x10A0);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_010) == 0x10A0);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_011) == 0x10A0);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_100) == 0x1070);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_101) == 0x1070);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_110) == 0x1050);
	CPU.EIP -= 2;
	assert(modrm16(0b10_000_111) == 0x1050);
	CPU.EIP -= 2;
	// MOD=11
	CPU.AX = 0x2040; CPU.CX = 0x2141;
	CPU.DX = 0x2242; CPU.BX = 0x2343;
	CPU.SP = 0x2030; CPU.BP = 0x2131;
	CPU.SI = 0x2232; CPU.DI = 0x2333;
	assert(modrm16(0b11_000_000) == 0x40); // AL
	assert(modrm16(0b11_001_000) == 0x41); // CL
	assert(modrm16(0b11_010_000) == 0x42); // DL
	assert(modrm16(0b11_011_000) == 0x43); // BL
	assert(modrm16(0b11_100_000) == 0x20); // AH
	assert(modrm16(0b11_101_000) == 0x21); // CH
	assert(modrm16(0b11_110_000) == 0x22); // DH
	assert(modrm16(0b11_111_000) == 0x23); // BH
	// MOD=11+W bit
	assert(modrm16(0b11_000_000, 1) == 0x2040); // AX
	assert(modrm16(0b11_001_000, 1) == 0x2141); // CX
	assert(modrm16(0b11_010_000, 1) == 0x2242); // DX
	assert(modrm16(0b11_011_000, 1) == 0x2343); // BX
	assert(modrm16(0b11_100_000, 1) == 0x2030); // SP
	assert(modrm16(0b11_101_000, 1) == 0x2131); // BP
	assert(modrm16(0b11_110_000, 1) == 0x2232); // SI
	assert(modrm16(0b11_111_000, 1) == 0x2333); // DI
	OK;

	test("16-bit ModR/M + SEG"); TODO;

	test("32-bit ModR/M"); TODO;
}