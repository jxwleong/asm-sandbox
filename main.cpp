#include <iostream>

using namespace std;

extern "C" int SomeFunctionNasm();
extern "C" int CpuID();
extern "C" unsigned int GetHighestExtendedFunction();
extern "C" int SomeFunction();
extern "C" bool GetCPUIDSupport();
extern "C" char* GetVendorString();
//extern "C" int GetLogicalProcessorCount();

string getBoolStr(bool boolean) {
	if (boolean == 1)
		return "true";
	else
		return "false";
}

// Rip from https://stackoverflow.com/q/22746429
std::string toBinary(int n)
{
	std::string r;
	while (n != 0) { r = (n % 2 == 0 ? "0" : "1") + r; n /= 2; }
	return r;
}

int main() {
	cout << "The result from NASM: " << SomeFunctionNasm() << endl;
	cout << "CPUID: " << toBinary(CpuID()) << endl;
	cout << "Highest supported extended function: " << GetHighestExtendedFunction() << "	BIN: " << \
				toBinary(GetHighestExtendedFunction()) << endl;
	cout << "The result is: " << SomeFunction() << endl;
	cout << "Support CPUID Instruction?: " << getBoolStr(GetCPUIDSupport()) << endl;
	cout << "Vendor String: " << GetVendorString() << endl;
	// 16 Core??
	// Have to check with datasheet...
	// Looks the the cpuid instruction is obselete, still need some digging..
	//cout << "Logical Processor Count: " << GetLogicalProcessorCount() << endl;
	return 0;
}