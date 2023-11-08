#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <regex>
using namespace std;
 
bool hasValidCharacters(string& input) {
	if(input.size() <= 4 || input.substr(input.size() - 4) != ".txt")
		return false;

	// valid characters: alphanumeric, underscores and hyphens
	if(regex_match(input.substr(0, input.size() - 4),
	regex("([a-zA-Z0-9]|_|-)*")))
		return true;
	else
		return false;
}

int main() {
	vector<string> output;
	string input;
	string fileName = "input.txt";
	cout << "Input file name with alphanumeric, hyphen and underscore characters.\nDefault name: input.txt\n";
	cin >> input;

	if(hasValidCharacters(input)) {
		fileName = input;
	}
	else {
		std::cerr << "Unable to open the file." << std::endl;
		return 1;
	}

	std::ifstream inputFile(fileName); 
	std::ofstream outputFile("output.txt"); 
 
	if(inputFile.is_open()) {
		input.clear();
		while(getline(inputFile, input)) {
				string s = regex_replace(input,
										regex("\\[.*\\]"),
										"");
				s = regex_replace(s,
				regex("\\([^feat].*\\)", regex::ECMAScript | regex::icase),
				"");
				s = regex_replace(s,
				regex("\\[^official video]\\)", regex::ECMAScript | regex::icase),
				"");
				s = regex_replace(s,
				regex("\")", regex::ECMAScript | regex::icase),
				"");
				output.push_back(s);
		}
	
		cout << "printing songs to file...\n";

		if(outputFile.is_open()) {
			for(auto& line : output) {
				outputFile << line << "\n"; // Write the string to the file
			}
			outputFile.close(); // Close the file
			std::cout << "String written to file successfully." << std::endl;
		}
		else {
			std::cerr << "Unable to open the file." << std::endl;
			return 1;
		}
	}
	else {
		std::cerr << "Unable to open the file." << std::endl;
		return 1;
	}
	
	return 0;
}
