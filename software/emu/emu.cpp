#include "emu.h"
#include "lcd19264.h"
#include <stdio.h>
#include <stdlib.h>
#include <string>

unsigned char mem[65536];
CPU cpu;
LCD lcd;
unsigned long int counter;
unsigned char data;

int main(int argc, char *argv[]) {
	char *romname = argv[1];
	int baseaddr = strtol(argv[2], NULL, 16);
	fprintf(stdout,"Base address: %04x\n", baseaddr);
	
	if (loadRom(romname, baseaddr) > 0) {
		fprintf(stderr, "Unable to open file %s", romname);
		return 1;
	}
	
	counter = 0;
	
	cpu.init();
	lcd.init(0x9020);
	
	cpu.reset();
	
	for (int i = 0; i < 1000000; i++) {
		//fprintf(stdout, "%04x \n", cpu.PC);
		cpu.execute();
	}
	
	return 0;
}

int loadRom(char *name, int baseaddr) {
	FILE *file = fopen(name, "rb");
	
	if (!file)
	{
		return 1;
	}
	
	//Get file length
	fseek(file, 0, SEEK_END);
	unsigned long fileLen=ftell(file);
	fseek(file, 0, SEEK_SET);
	
	unsigned char buff[fileLen];
	
	fread(buff, fileLen, 1, file);
	
	memcpy(&mem[baseaddr],buff,fileLen);
	
	fprintf(stdout, "\n");
	
	return 0;
}

bool checkPeriphs(unsigned short address, unsigned char value) {
	bool result = false;
	for (int i = 0; i < sizeof(lcd.addresses); i++) {
		if (lcd.addresses[i] == address) {
			lcd.execute(address, value);
			result = true;
			data = lcd.data;
		}
	}
	return result;
}

void CPU::init() {
	PC = 0x00ff;
}

void CPU::reset() {
	PC = CPU::readShort(0xfffc);
	SP = 0x00;
}
	
void CPU::execute() {
	counter++;
	unsigned char instruction = cpu.readByte(cpu.PC);
	unsigned char byteVal;
	unsigned short shortVal;
	char buff[20];
	char pcval[20];
	snprintf(pcval, 20, "PC: %04x Instr: %02x", cpu.PC, instruction);
	switch (instruction) {
		case 0x08:
			snprintf(buff, 9, "PHP     ");
			cpu.pushStack(cpu.getP() & 0xff);
			break;
		case 0x09:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "ORA #%02x  ", byteVal);
			cpu.A = cpu.A | byteVal;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A < 0) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x10:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "BPL %02x  ", byteVal);
			if (!cpu.N) {
				if (byteVal >= 0x80) {
					byteVal = 0xff - byteVal + 1;
					cpu.PC = cpu.PC - byteVal;
				} else {
					cpu.PC = cpu.PC + byteVal;
				}
			}
			break;
		case 0x1a:
			snprintf(buff, 9, "INC A   ");
			cpu.A++;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x18:
			snprintf(buff, 9, "CLC     ");
			cpu.C = false;
			break;
		case 0x20:
			shortVal = cpu.readShort(cpu.PC + 1);
			snprintf(buff, 9, "JSR %04x", shortVal);
			cpu.pushStack(cpu.PC & 0xff);
			cpu.pushStack((cpu.PC >> 8) & 0xff);
			cpu.PC = shortVal;
			cpu.PC--;
			break;
		case 0x28:
			snprintf(buff, 9, "PLP     ");
			byteVal = cpu.pullStack();
			setP(byteVal);
		case 0x29:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "AND #%02x  ", byteVal);
			cpu.A = cpu.A & byteVal;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x30:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "BMI %02x  ", byteVal);
			if (cpu.N) {
				if (byteVal >= 0x80) {
					byteVal = 0xff - byteVal + 1;
					cpu.PC = cpu.PC - byteVal;
				} else {
					cpu.PC = cpu.PC + byteVal;
				}
			}
			break;
		case 0x38:
			snprintf(buff, 9, "SEC     ");
			cpu.C = true;
			break;
		case 0x48:
			snprintf(buff, 9, "PHA     ");
			cpu.pushStack(cpu.A & 0xff);
			break;
		case 0x4c:
			shortVal = cpu.readShort(cpu.PC + 1);
			snprintf(buff, 9, "JMP %04x", shortVal);
			cpu.PC = shortVal;
			cpu.PC--;
			break;
		case 0x58:
			snprintf(buff, 9, "CLI     ");
			cpu.I = false;
			break;
		case 0x5a:
			snprintf(buff, 9, "PHY     ");
			cpu.pushStack(cpu.Y & 0xff);
			break;
		case 0x60:
			snprintf(buff, 9, "RTS     ");
			shortVal = cpu.pullStack() << 8;
			byteVal = cpu.pullStack();
			shortVal = shortVal + byteVal;
			cpu.PC = shortVal;
			cpu.PC++;
			cpu.PC++;
			break;
		case 0x65:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "ADC %02x  ", byteVal);
			byteVal = mem[byteVal];
			shortVal = cpu.A + byteVal;
			if (cpu.C) {
				shortVal++;
			}
			cpu.V = false;
			if (shortVal > 0xff) {
				cpu.C = true;
				if (shortVal > 0x17f) {
					cpu.V = true;
				}
			} else {
				cpu.C = false;
				if (shortVal < 0x80) {
					cpu.V = true;
				}
			}
			cpu.A = shortVal & 0xff;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x68:
			snprintf(buff, 9, "PLA     ");
			byteVal = cpu.pullStack();
			cpu.A = byteVal;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x78:
			snprintf(buff, 9, "SEI     ");
			cpu.I = true;
			break;
		case 0x7A:
			snprintf(buff, 9, "PLY     ");
			byteVal = cpu.pullStack();
			cpu.Y = byteVal;
			if (cpu.Y == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x84:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "STY %02x  ", byteVal);
			mem[byteVal] = cpu.Y;
			break;
		case 0x85:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "STA %02x  ", byteVal);
			mem[byteVal] = cpu.A;
			break;
		case 0x86:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "STX %02x  ", byteVal);
			mem[byteVal] = cpu.X;
			break;
		case 0x88:
			snprintf(buff, 9, "DEY     ");
			cpu.Y--;
			if (cpu.Y == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0x8d:
			cpu.PC++;
			shortVal = cpu.readShort(cpu.PC);
			snprintf(buff, 9, "STA %04x", shortVal);
			cpu.PC++;
			cpu.memWrite(shortVal, cpu.A);
			break;
		case 0x90:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "BCC %02x  ", byteVal);
			if (!cpu.C) {
				if (byteVal >= 0x80) {
					byteVal = 0xff - byteVal + 1;
					cpu.PC = cpu.PC - byteVal;
				} else {
					cpu.PC = cpu.PC + byteVal;
				}
			}
			break;
		case 0xa0:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDY #%02x  ", byteVal);
			cpu.Y = byteVal;
			if (cpu.Y == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xa2:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDX #%02x  ", byteVal);
			cpu.X = byteVal;
			if (cpu.X == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.X >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xa4:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDY %02x  ", byteVal);
			cpu.Y = mem[byteVal];
			if (cpu.Y == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xa5:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDA %02x  ", byteVal);
			cpu.A = mem[byteVal];
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xa6:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDX %02x  ", byteVal);
			cpu.X = mem[byteVal];
			if (cpu.X == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.X >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xa9:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDA #%02x  ", byteVal);
			cpu.A = byteVal;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xad:
			cpu.PC++;
			shortVal = cpu.readShort(cpu.PC);
			snprintf(buff, 9, "LDA %04x  ", shortVal);
			cpu.PC++;
			byteVal = cpu.memRead(shortVal);
			cpu.A = byteVal;
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xb0:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "BCS %02x  ", byteVal);
			if (cpu.C) {
				if (byteVal > 0x80) {
					byteVal = 0xff - byteVal + 1;
					cpu.PC = cpu.PC - byteVal;
				} else {
					cpu.PC = cpu.PC + byteVal;
				}
			}
			break;
		case 0xb1:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "LDA %02x  ", byteVal);
			shortVal = mem[byteVal + 1] << 8;
			shortVal = shortVal + mem[byteVal];
			shortVal = shortVal + cpu.Y;
			cpu.A = mem[shortVal];
			if (cpu.A == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xb8:
			snprintf(buff, 9, "CLV     ");
			cpu.V = false;
			break;
		case 0xc0:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "CPY #%02x  ", byteVal);
			if (cpu.Y < byteVal) {
				cpu.C = false;
			} else {
				cpu.C = true;
				if (cpu.Y == byteVal) {
					cpu.Z = true;
				} else {
					cpu.Z = false;
				}
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xc4:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "CPY %02x  ", byteVal);
			byteVal = mem[byteVal];
			if (cpu.Y < byteVal) {
				cpu.C = false;
			} else {
				cpu.C = true;
			}
			if (cpu.Y == byteVal) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xc5:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "CMP %02x  ", byteVal);
			byteVal = mem[byteVal];
			if (cpu.A < byteVal) {
				cpu.C = false;
			} else {
				cpu.C = true;
			}
			if (cpu.A == byteVal) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xc8:
			snprintf(buff, 9, "INY     ");
			cpu.Y++;
			if (cpu.Y == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.Y >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xc9:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "CMP #%02x  ", byteVal);
			if (cpu.A < byteVal) {
				cpu.C = false;
			} else {
				cpu.C = true;
			}
			if (cpu.A == byteVal) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.A >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xca:
			snprintf(buff, 9, "DEX     ");
			cpu.X--;
			if (cpu.X == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.X >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xd0:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "BNE %02x  ", byteVal);
			if (!cpu.Z) {
				if (byteVal > 0x80) {
					byteVal = 0xff - byteVal + 1;
					cpu.PC = cpu.PC - byteVal;
				} else {
					cpu.PC = cpu.PC + byteVal;
				}
			}
			break;
		case 0xd8:
			snprintf(buff, 9, "CLD     ");
			cpu.D = false;
			break;
		case 0xda:
			snprintf(buff, 9, "PHX     ");
			cpu.pushStack(cpu.X & 0xff);
			break;
		case 0xe0:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "CPX #%02x  ", byteVal);
			if (cpu.X < byteVal) {
				cpu.C = false;
			} else {
				cpu.C = true;
				if (cpu.X == byteVal) {
					cpu.Z = true;
				} else {
					cpu.Z = false;
				}
			}
			if (cpu.X >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xe4:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "CPX %02x  ", byteVal);
			byteVal = mem[byteVal];
			if (cpu.X < byteVal) {
				cpu.C = false;
			} else {
				cpu.C = true;
			}
			if (cpu.X == byteVal) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.X >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xe6:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "INC %02x  ", byteVal);
			mem[byteVal] = mem[byteVal] + 1;
			byteVal = mem[byteVal];
			if (byteVal == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (byteVal >= 0x80) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xe8:
			snprintf(buff, 9, "INX     ");
			cpu.X++;
			if (cpu.X == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.X < 0) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		case 0xf0:
			cpu.PC++;
			byteVal = cpu.readByte(cpu.PC);
			snprintf(buff, 9, "BEQ %02x  ", byteVal);
			if (cpu.Z) {
				if (byteVal >= 0x80) {
					byteVal = 0xff - byteVal + 1;
					cpu.PC = cpu.PC - byteVal;
				} else {
					cpu.PC = cpu.PC + byteVal;
				}
			}
			break;
		case 0xf8:
			snprintf(buff, 9, "SED     ");
			cpu.D = true;
			break;
		case 0xfa:
			snprintf(buff, 9, "PLX     ");
			byteVal = cpu.pullStack();
			cpu.X = byteVal;
			if (cpu.X == 0) {
				cpu.Z = true;
			} else {
				cpu.Z = false;
			}
			if (cpu.X < 0) {
				cpu.N = true;
			} else {
				cpu.N = false;
			}
			break;
		default:
			snprintf(buff, 9, "?       ");
	}
	char cpustate[100];
	snprintf(cpustate, 100, "A: %02x, X: %02x, Y: %02x, P: %d%d-%d%d%d%d%d, SP: %02x", cpu.A, cpu.X, cpu.Y, cpu.N ? 1:0, cpu.V ? 1:0, cpu.B ? 1:0, cpu.D ? 1:0, cpu.I ? 1:0, cpu.Z ? 1:0, cpu.C ? 1:0, cpu.SP);
	fprintf(stdout, "%10lu %s   %s     %s\n", counter, pcval, buff, cpustate);
	cpu.PC++;
}



unsigned char CPU::readByte(unsigned short address) {
	unsigned char memval = mem[address];
	return memval;
}

unsigned short CPU::readShort(unsigned short address) {
	unsigned short memval = mem[address + 1] << 8;
	memval = memval + mem[address];
	return memval;
}

void CPU::memWrite(unsigned short address, unsigned char value) {
	bool pDone = checkPeriphs(address, value);
	
	if (!pDone) {
		mem[address] = value;
	}
}

unsigned char CPU::memRead(unsigned short address) {
	if (checkPeriphs(address, 0)) {
		return data;
	}
	
	return mem[address]; 
}

void CPU::pushStack(unsigned char pushedByte){
	cpu.SP--;
	mem[0x0100 + cpu.SP] = pushedByte;
	/*
	for (int i = 15; i >= 0; i--) {
		fprintf(stdout, "%04x: %02x\n", 0x1ff-i, mem[0x01ff - i]);
	}
	*/
}

unsigned char CPU::pullStack(){
	unsigned char pulledByte = mem[0x0100 + cpu.SP];
	cpu.SP++;
	/*
	for (int i = 15; i >= 0; i--) {
		fprintf(stdout, "%04x: %02x\n", 0x01ff-i, mem[0x01ff - i]);
	}
	*/
	return pulledByte;
}

unsigned char CPU::getP(){
	unsigned char p = cpu.N ? 0x80:0;
	p = p + (cpu.V ? 0x40:0);
	p = p + (cpu.B ? 0x10:0);
	p = p + (cpu.D ? 0x08:0);
	p = p + (cpu.I ? 0x04:0);
	p = p + (cpu.Z ? 0x02:0);
	p = p + (cpu.C ? 0x01:0);
	return p;
}

void CPU::setP(unsigned char newP){
	if ((newP & 0x80) == 0x80) {
		cpu.N = true;
	} else {
		cpu.N = false;
	}
	if ((newP & 0x40) == 0x40) {
		cpu.V = true;
	} else {
		cpu.V = false;
	}
	if ((newP & 0x10) == 0x10) {
		cpu.B = true;
	} else {
		cpu.B = false;
	}
	if ((newP & 0x08) == 0x08) {
		cpu.D = true;
	} else {
		cpu.D = false;
	}
	if ((newP & 0x04) == 0x04) {
		cpu.I = true;
	} else {
		cpu.I = false;
	}
	if ((newP & 0x02) == 0x02) {
		cpu.Z = true;
	} else {
		cpu.Z = false;
	}
	if ((newP & 0x01) == 0x01) {
		cpu.C = true;
	} else {
		cpu.C = false;
	}
}

void LCD::init(unsigned short address) {
	addresses[0] = address;
	addresses[1] = address + 1;
	inReset = true;
}

void LCD::reset() {
	for (int i = 0; i < 2; i++) {
		segments[i].on = false;
		segments[i].Y = 0;
		segments[i].X = 0;
		segments[i].Z = 0;
	}
	
}

void LCD::execute(unsigned short address, unsigned char value) {
	if (address == addresses[1]) {
		// control
		if ((value & 0x10) == 0x10) {
			if (inReset) {
				reset();
			}
			inReset = false;
		} else {
			inReset = true;
		}
		
		if (inReset) {
			return;
		}
		
		if ((value & 0x40) == 0x40) {
			segments[2].selected = false;
		} else {
			segments[2].selected = true;
		}
		
		if ((value & 0x20) == 0x20) {
			segments[1].selected = false;
		} else {
			segments[1].selected = true;
		}
		
		if ((value & 0x08) == 0x08) {
			segments[0].selected = false;
		} else {
			segments[0].selected = true;
		}
		
		if ((value & 0x04) == 0x04) {
			if (!E) {
				ePulse = false;
			}
			E = true;
		} else {
			if (E) {
				ePulse = true;
			}
			E = false;
		}
		
		if ((value & 0x02) == 0x02) {
			RW = true;
		} else {
			RW = false;
		}
		
		if ((value & 0x01) == 0x01) {
			RS = true;
		} else {
			RS = false;
		}
		
		if (ePulse) {
			if (!RS && !RW) {
				if ((data >= 0x3E) && (data < 0x40)) {
					fprintf(stdout, "Screen on\n");
					bool state = false;
					if ((data & 0x01) == 0x01) {
						state = true;
					}
					if (segments[0].selected) {
						segments[0].on = state;
					}
					if (segments[1].selected) {
						segments[1].on = state;
					}
					if (segments[2].selected) {
						segments[2].on = state;
					}
				}
				if ((data >= 0x40) && (data < 0x80)) {
					fprintf(stdout, "Set Y\n");
					if (segments[0].selected) {
						segments[0].Y = data & 0x3F;
					}
					if (segments[1].selected) {
						segments[1].Y = data & 0x3F;
					}
					if (segments[2].selected) {
						segments[2].Y = data & 0x3F;
					}
				}
				if ((data >= 0xB8) && (data < 0xC0)) {
					fprintf(stdout, "Set X\n");
					if (segments[0].selected) {
						segments[0].X = data & 0x07;
					}
					if (segments[1].selected) {
						segments[1].X = data & 0x07;
					}
					if (segments[2].selected) {
						segments[2].X = data & 0x07;
					}
				}
				if (data >= 0xC0) {
					fprintf(stdout, "Set Z\n");
					if (segments[0].selected) {
						segments[0].Z = data & 0x3F;
					}
					if (segments[1].selected) {
						segments[1].Z = data & 0x3F;
					}
					if (segments[2].selected) {
						segments[2].Z = data & 0x3F;
					}
				}
			}
		
			if (!RS && RW) {
				fprintf(stdout, "Reading status\n");
				unsigned char result = inReset ? 0x10 : 0;
				result = result + (segments[0].on & segments[1].on & segments[2].on) ? 0x20 : 0;
				status = result;
				if (ePulse) {
					data = status;
				}
			}
		
			if (RS && !RW) {
				fprintf(stdout, "Setting gmem to %02x\n", data);
				if (segments[0].selected) {
					segments[0].gmem[segments[0].Y][segments[0].X] = data;
					segments[0].Y = segments[0].Y + 1;
				}
				if (segments[1].selected) {
					segments[1].gmem[segments[1].Y][segments[1].X] = data;
					segments[1].Y = segments[1].Y + 1;
				}
				if (segments[2].selected) {
					segments[2].gmem[segments[2].Y][segments[2].X] = data;
					segments[2].Y = segments[2].Y + 1;
				}
				
			}
		
			if (RS && RW) {
				unsigned char memVal;
				if (segments[0].selected) {
					memVal = segments[0].gmem[segments[0].Y][segments[0].X];
				}
				if (segments[1].selected) {
					memVal = segments[1].gmem[segments[1].Y][segments[1].X];
				}
				if (segments[2].selected) {
					memVal = segments[2].gmem[segments[2].Y][segments[2].X];
				}
				if (ePulse) {
					data = memVal;
				}
				fprintf(stdout, "Reading gmem value of %02x\n", memVal);
			}
			ePulse = false;
		}
		
	}
	
	if (inReset) {
		return;
	}
	
	if (address == addresses[0]) {
		// data
		
		data = value;
	}
	
	
	fprintf(stdout, "LCD addr: %04x, %02x    %02x    %02x    %d %d %d %d    %d%d%d    %d%d%d %02x %02x %02x\n", address, value, status, data, E ? 1:0, RW ? 1:0, RS ? 1:0, ePulse ? 1:0, segments[0].on ? 1:0, segments[1].on ? 1:0, segments[2].on ? 1:0, segments[0].selected ? 1:0, segments[1].selected ? 1:0, segments[2].selected ? 1:0, segments[0].Y, segments[0].X, segments[0].Z );
}