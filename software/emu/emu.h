


struct CPU {
	
	unsigned short PC;			// Program counter
	unsigned char SP;			// Stack pointer
	
	unsigned char A;		// Accumulator
	unsigned char X;		// X register
	unsigned char Y;		// Y register
	
	bool C;					// Carry bit
	bool Z;					// Zero bit
	bool I;					// Interrupt enable bit
	bool D;					// Decimal mode bit
	bool B;					// ?
	bool V;					// Overflow bit
	bool N;					// Negative bit
	
	void init();

	void reset();
	
	void execute();
	
	unsigned char readByte(unsigned short address);
	unsigned short readShort(unsigned short address);
	
	void memWrite(unsigned short address, unsigned char value);
	unsigned char memRead(unsigned short address);
	
	void pushStack(unsigned char pushedByte);
	unsigned char pullStack();
	
	unsigned char getP();
	void setP(unsigned char);
};


int loadRom(char *name, int baseaddr);

bool checkPeriphs(unsigned short address);

