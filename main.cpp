#include <iostream>

using namespace std;

extern "C" int SomeFunction();
extern "C" bool GetCPUIDSupport();
extern "C" char* GetVendorString();
extern "C" int GetLogicalProcessorCount();

string getBoolStr(bool boolean) {
	if (boolean == 1)
		return "true";
	else
		return "false";
}


int main() {
	cout << "The result is: " << SomeFunction() << endl;
	cout << "Support CPUID Instruction?: " << getBoolStr(GetCPUIDSupport()) << endl;
	cout << "Vendor String: " << GetVendorString() << endl;
	// 16 Core??
	// Have to check with datasheet...
	cout << "Logical Processor Count: " << GetLogicalProcessorCount() << endl;
	return 0;
}