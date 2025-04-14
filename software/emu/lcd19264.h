
struct segment {
	bool on;
	
	bool selected;
	
	unsigned char Y;
	unsigned char X;
	unsigned char Z;
	
	unsigned short gmem[64][8];
	
};

struct LCD {
	
	unsigned short addresses[2];
	
	unsigned char data;
	
	unsigned char status;
	
	unsigned char control;
	
	bool E;
	bool RS;
	bool RW;
	
	bool ePulse;
	
	bool inReset;
	
	segment segments[3];
	
	void init(unsigned short address);
	
	void reset();
	
	void execute(unsigned short address, unsigned char value);
	
};