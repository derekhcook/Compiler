#include <iostream>
#include <fstream>
#include <cstdlib>
#include <iomanip>
#include <string>
#include <ctime>
#include <stage0.h>
#include <sstream>
#include <vector>
#include <set>
#include <algorithm>
#include <cctype>
#include <map>
#include <ctime>

using namespace std;

Compiler::Compiler(char **argv) {  // constructor
    // Open source file for reading
    sourceFile.open(argv[1]);
    if (!sourceFile) {
        cerr << "Error: Cannot open source file " << argv[1] << endl;
        exit(EXIT_FAILURE);
    }

    // Open listing file for writing
    listingFile.open(argv[2]);
    if (!listingFile) {
        cerr << "Error: Cannot open listing file " << argv[2] << endl;
        exit(EXIT_FAILURE);
    }

    // Open object file for writing
    objectFile.open(argv[3]);
    if (!objectFile) {
        cerr << "Error: Cannot open object file " << argv[3] << endl;
        exit(EXIT_FAILURE);
    }
}

Compiler::~Compiler() { // destructor
    if (sourceFile.is_open()) sourceFile.close();
    if (listingFile.is_open()) listingFile.close();
    if (objectFile.is_open()) objectFile.close();
}

void Compiler::createListingHeader(){
    // Get the current date and time
    time_t now = time(nullptr);
    tm *localTime = localtime(&now);

    // Format the date and time as a string
    char dateTime[100];
    strftime(dateTime, sizeof(dateTime), "%c", localTime);

    // Print the header to the listing file
    listingFile << "STAGE0: " << " Trey Fleming, Derek Cook" << "    " << dateTime << endl << endl;
    listingFile << left << setw(10) << "LINE NO." << "            " << "SOURCE STATEMENT" << endl;
    listingFile << endl << setw(6) << right << "1|";  // A line separator for clarity

}

void Compiler::parser(){
    //cout << "       We're in parser";

    // Initialize `ch` by reading the first character of the source file
    nextChar();

    // Check if the first token is "program"
    if (nextToken() != "program") {
        processError("keyword 'program' expected");
    }

    // Start parsing the program according to the grammar rules
    prog(); // Call the main parsing function that implements the grammar rules
}

void Compiler::createListingTrailer(){
    //cout << "       We're in createListingTrailer";

    // Print compilation termination message and number of errors to the listing file
    listingFile << endl <<  "COMPILATION TERMINATED" << "      ";
    if(errorCount > 1 || errorCount == 0)
    listingFile << errorCount << " ERRORS ENCOUNTERED" << endl;
    else
    listingFile << errorCount << " ERROR ENCOUNTERED" << endl;
}


// Methods implementing the grammar productions
void Compiler::prog(){           // stage 0, production 1
    // token should be "program"
    if (token != "program") {
        processError("keyword 'program' expected");
    }

    // Call progStmt() to process the program statement
    progStmt();

    // Check for the presence of "const" and handle it if found
    if (token == "const") {
        consts();
    }

    // Check for the presence of "var" and handle it if found
    if (token == "var") {
        vars();
    }

    // Check if the next token is "begin"; if not, report an error
    if (token != "begin") {
        processError("keyword 'begin' expected");
    }

    // Call beginEndStmt() to handle the main program block
    beginEndStmt();

    // Ensure no text follows "end."
    if (token[0] != END_OF_FILE) {
        processError("no text may follow 'end'");
    }
}

void Compiler::progStmt(){       // stage 0, production 2
    //cout << "       We're in progStmt";

    string x;

     // Check if the token is "program"
    if (token != "program") {
        processError("keyword 'program' expected");
    }

     // Move to the next token, which should be the program name
    x = nextToken();

    if (x.length() > 15) {
        x = x.substr(0, 15);
    }

     // Ensure the program name is a valid non-keyword identifier
    if (!isNonKeyId(x)) {
        processError("program name expected");
    }

     // Ensure the next token is a semicolon
    if (nextToken() != ";") {
        processError("semicolon expected");
    }

     // Move to the next token after the semicolon
    nextToken();

     // Emit code for the "program" declaration
    code("program", x);

     // Insert the program name into the symbol table as a constant with no allocation
    insert(x, PROG_NAME, CONSTANT, x, NO, 0);
}

void Compiler::consts(){         // stage 0, production 3
    //cout << "       We're in consts";
    
    // The token should be "const"
    if (token != "const") {
        processError("keyword 'const' expected");
    }
    // Move to the next token, which should be a non-keyword identifier
    if (!isNonKeyId(nextToken())) {
        processError("non-keyword identifier must follow 'const'");
    }
    // Call constStmts() to handle the constant declarations
    constStmts();
}

void Compiler::vars(){           // stage 0, production 4
    //cout << "       We're in vars";

    // The token should be "var"
    if (token != "var") {
        processError("keyword 'var' expected");
    }

    // Move to the next token, which should be a non-keyword identifier
    if (!isNonKeyId(nextToken())) {
        processError("non-keyword identifier must follow 'var'");
    }

    // Call varStmts() to handle the variable declarations
    varStmts();
}

void Compiler::beginEndStmt(){   // stage 0, production 5
    //cout << "       We're in beginEndStmt";

    // The token should be "begin"
    if (token != "begin") {
        processError("keyword 'begin' expected");
    }

    // Move to the next token, which should be checked for "end"
    if (nextToken() != "end") {
        processError("keyword 'end' expected");
    }

    // Move to the next token, which should be checked for "."
    if (nextToken() != ".") {
        processError("period expected");
    }

    // Move to the next token to continue parsing after "end."
    nextToken();

    // Emit the code for the end of the program
    code("end", ".");
}

void Compiler::constStmts(){     // stage 0, production 6
    string x, y;

    // Check if the current token is a non-keyword identifier
    if (!isNonKeyId(token)) {
        processError("non-keyword identifier expected");
    }

    // Assign the current token to x (the identifier)
    x = token;
    
    // Check if the next token is '='
    if (nextToken() != "=") {
        processError("'=' expected");
    }

    // Get the next token, which should be the value assigned
    y = nextToken();

    // Validate that y is one of the allowed types: "+", "-", "not", a non-keyword identifier, "true", "false", or an integer
    if (!(y == "+" || y == "-" || y == "not" || isNonKeyId(y) || y == "true" || y == "false" || isInteger(y))) {
        processError("token to the right of '=' is illegal");
    }

    // Handle cases for "+" or "-"
    if (y == "+" || y == "-") {
        if (!isInteger(nextToken())) {
            processError("integer expected after sign");
        }
        y = y + token; // Concatenate the sign with the integer value
    }

    // Handle case for "not"
    if (y == "not") {
        if (!isBoolean(nextToken())) {
            processError("boolean expected after 'not'");
        }
        // Negate the boolean value
        y = (token == "true") ? "false" : "true";
    }

    // Check if the next token is a semicolon
    if (nextToken() != ";") {
        processError("semicolon expected");
    }

    // Verify the data type of y (must be INTEGER or BOOLEAN)
    if (whichType(y) != INTEGER && whichType(y) != BOOLEAN) {
        processError("data type of token on the right-hand side must be INTEGER or BOOLEAN");
    }

    // Insert the constant into the symbol table
    insert(x, whichType(y), CONSTANT, whichValue(y), YES, 1);

    // Move to the next token and check if more constants are to be declared
    x = nextToken();
    if (!(x == "begin" || x == "var" || isNonKeyId(x))) {
        processError("non-keyword identifier, 'begin', or 'var' expected");
    }

    // Recursively call constStmts() if another constant declaration is detected
    if (isNonKeyId(x)) {
        constStmts();
    }
}

void Compiler::varStmts(){       // stage 0, production 7
    //cout << "       We're in varStmts";

     string x, y;

    // Check if the current token is a non-keyword identifier
    if (!isNonKeyId(token)) {
        processError("non-keyword identifier expected");
    }

    // Get the identifiers list
    x = ids();

    // Check if the next token is ':'
    if (token != ":") {
        processError("\":\" expected");
    }

    nextToken();

    // Move to the next token and check if it is a valid type (either "integer" or "boolean")
    if (!(token == "boolean" || token == "integer")) {
        processError("illegal type follows \":\"");
    }

    // Assign the type to y
    y = token;

    // Ensure the next token is a semicolon
    if (nextToken() != ";") {
        processError("semicolon expected");
    }

    insert(x, whichType(y), VARIABLE, "", YES, 1);

    nextToken();

    // Move to the next token and check if it is either "begin" or another non-keyword identifier
    if (!(token == "begin" || isNonKeyId(token))) {
        processError("non-keyword identifier or \"begin\" expected");
    }

    // Recursively call varStmts() if the next token is a non-keyword identifier
    if (isNonKeyId(token)) {
        varStmts();
    }
}

string Compiler::ids(){          // stage 0, production 8
    //cout << "       We're in ids";

     string temp, tempString;

     // Check if the current token is a non-keyword identifier
    if (!isNonKeyId(token)) {
        processError("non-keyword identifier expected");
    }

     // Assign the current token to tempString and temp
    tempString = token;
    temp = token;

     // Move to the next token and check if it is a comma (indicating more identifiers)
    if (nextToken() == ",") {
        // Move to the next token and ensure it's a non-keyword identifier
        if (!isNonKeyId(nextToken())) {
            processError("non-keyword identifier expected");
        }

         // Recursively call ids() to append more identifiers and format with commas
        tempString = temp + "," + ids();
    }

     // Return the full list of identifiers as a comma-separated string
    return tempString;
}

// Helper functions for the Pascallite lexicon
bool Compiler::isKeyword(string s) const {
    //cout << "       We're in isKeyword";

    static const std::set<std::string> keywords = {"if", "else", "while", "return", "int", "boolean", "program", "begin", "end", "var", "const", "integer", "true", "false", "not", "mod", "div", "and", "or", "read", "write"};
    return keywords.find(s) != keywords.end();
}

bool Compiler::isSpecialSymbol(char c) const { // determines if c is a special symbol
    //cout << "       We're in isSpecialSymbol";

    static const std::set<char> specialSymbols = {'+', '-', '*', '/', '=', '<', '>', ';', ',', '.', '(', ')', '{', '}', '[', ']', '!', ':', '?', '&', '|'};
    return specialSymbols.find(c) != specialSymbols.end();
}

bool Compiler::isNonKeyId(string s) const {    // determines if s is a non_key_id
    //cout << "       We're in isNonKeyID";

    if (isKeyword(s)) {
    return false;
    }
    for (uint i = 0; i < s.length(); i++) {
        if (s[i] == '_' && s[i+1] == '_'){
            return false;
        }
        if (i == 0 && !islower(s[i])) {
            return false;
        }
        else if (!(isdigit(s[i]) || islower(s[i]) || s[i] == '_')) {
            return false;
        }
        if (i == (s.length() - 1) && (s[i] == '_')) {
            return false;
        }
    }
    return true;
}
bool Compiler::isInteger(string s) const {     // determines if s is an integer
    if (s.empty())
        return false;
    // Check if all characters are digits
    if(s[0] == '-')
        s = s.substr(1);
    return all_of(s.begin(), s.end(), ::isdigit);
}
bool Compiler::isBoolean(string s) const {     // determines if s is a boolean
    if (s == "false" || s == "true") {
        return true;
    }
    else {
        return false;
    }
}
bool Compiler::isLiteral(string s) const {     // determines if s is a literal
    //cout << "       We're in isLiteral";

    string literal = s;
    if (isInteger(literal)) {
        return true;
    }
    if (isBoolean(literal)) {
        return true;
    }
    if (literal[0] == '+' || literal[0] == '-') {
        literal = literal.substr(1, s.length() - 1);
        if (isInteger(literal)) {
            return true;
        }
        else {
            return false;
        }
    }
    if (literal.substr(0, 3) == "not") {
        literal = literal.substr(4, literal.length() - 4);
        if (isBoolean(literal)) {
            return true;
        }
        else {
            return false;
        }
    }
    return false;
}


// Action routines
void Compiler::insert(string externalName, storeTypes inType, modes inMode,
            string inValue, allocation inAlloc, int inUnits) {
    //cout << "       We're in insert";

    string name;
    int index;
    istringstream nameStream(externalName);
    //cout << endl << endl << "OUTLOOP: " << externalName << endl << endl;
    while(getline(nameStream, name, ','))
    {
        index = externalName.find(',');
        name = externalName.substr(0, index);
        externalName = externalName.substr(index+1);
        //cout << endl << endl << "INLOOP: " << name << endl << endl;
    
        // Check for multiple definition in symbol table
        if (symbolTable.find(name) != symbolTable.end()) {
            processError("Multiple name definition: " + name);
            continue;  // Skip this name and move to the next one
        }
        
         // Check if the name is a reserved keyword
        else if (isKeyword(name)) {
            processError("Illegal use of keyword: " + name);
            continue;  // Skip this name and move to the next one
        }
        // Determine the internal name or use external name based on rules
        else
        { 
            if (isupper(name[0])) {
                if(symbolTable.size() == 256) {
				processError("symbol table overflow");
			    }
                // External name is defined by the compiler
                symbolTable.insert(pair<string, SymbolTableEntry>(name, SymbolTableEntry(name,inType,inMode,inValue,inAlloc,inUnits)));
            } else {
                if(symbolTable.size() == 256) {
				processError("symbol table overflow");
			    }
                // Generate a unique internal name based on the type
                string internalName = genInternalName(inType);
                //symbolTable.emplace(internalName, SymbolTableEntry(name, inType, inMode, inValue, inAlloc, inUnits));
                symbolTable.insert(pair<string, SymbolTableEntry>(name, SymbolTableEntry(internalName,inType,inMode,inValue,inAlloc,inUnits)));
            }
        }
    }
}

    storeTypes Compiler::whichType(string name) {
    //cout << "       We're in whichType";

    storeTypes datatype;
    name = name.substr(0,15);

    // Check if the name is a literal
    if(isLiteral(name))
    {
        if (isBoolean(name)) {
            // If the name is a boolean literal, return BOOLEAN type
            datatype =  BOOLEAN;
        } else { //if (isInteger(name)) {
            // If the name is an integer literal, return INTEGER type
            datatype =  INTEGER;
        }
    }
    else if (name == "integer") {
        datatype = INTEGER;
    }
    else if (name == "boolean") {
        datatype = BOOLEAN;
    }
    else
    {
        if (symbolTable.find(name) != symbolTable.end()) {
            datatype = symbolTable.at(name).getDataType();
        }
        else {
            processError("reference to undefined symbol " + name);
        }
    }

    // This return is just a safeguard; the function will exit in case of an error
    return datatype; // Default return to satisfy all control paths

    }

    string Compiler::whichValue(string name) {
    //cout << "       We're in whichValue";

        string value;
	    name = name.substr(0, 15);
        if (isLiteral(name)) {
            value = name;
        }
        else {
            if (symbolTable.find(name) != symbolTable.end()) {
                value = symbolTable.at(name).getValue();
            }
            else {
                processError("reference to undefined symbol " + name);
            }
        }
        return value;
    }

    void Compiler::code(string op, string operand1, string operand2) {
    //cout << "       We're in code";

    // Handle the "program" operation
    if (op == "program") {
        emitPrologue(operand1);
    }
    // Handle the "end" operation
    else if (op == "end") {
        emitEpilogue();
    }
    // Handle unexpected operations by reporting an error
    else {
        processError("compiler error: function \"code\" called with illegal arguments: " + op);
    }
    }

    void Compiler::emit(string label, string instruction, string operands, string comment) {
    //cout << "       We're in emit";

    // Ensure left justification for all output fields
    objectFile << left;

    // Output the label in a field of width 8
    objectFile << setw(8) << label;

    // Output the instruction in a field of width 8
    objectFile << setw(8) << instruction;

    // Output the operands in a field of width 24
    objectFile << setw(24) << operands;

    // Output the comment (no width constraint, align to the right)
    if(comment.find("program") != string::npos)
    {
        comment = comment.substr(comment.find("program")+8);
        if(comment.length() > 15)
            comment = comment.substr(0,17);
        comment = "; program " + comment;
    }
    else
    if(comment.length() > 15)
        comment = comment.substr(0,17);
    objectFile << comment << endl;
    }

    void Compiler::emitPrologue(string progName, string operand2) {
    //cout << "       We're in emitPrologue";
        time_t when = time(0);
        char* currTime = ctime(&when);
        // Output identifying comments at the beginning of the object file
        objectFile << "; Trey Fleming, Derek Cook" << "       " << currTime;
        //objectFile << endl;

        // Output the %INCLUDE directives
        objectFile << "%INCLUDE \"Along32.inc\"" << endl;
        objectFile << "%INCLUDE \"Macros_Along.inc\"" << endl;
        objectFile << endl;

        // Emit the initial code section directives
        emit("SECTION", ".text");
        emit("global", "_start", "", "; program " + progName);
        objectFile << endl;
        emit("_start:");
    }

    void Compiler::emitEpilogue(string operand1, string operand2) {
    //cout << "       We're in emitEpilogue";

        // Emit the exit instruction and storage section
        emit("", "Exit", "{0}");
        objectFile << endl;
        emitStorage(); // Call to emit storage sections
    }

    void Compiler::emitStorage() {
    //cout << "       We're in emitStorage";

        // Emit the data section for constant allocations
        emit("SECTION", ".data");
        for (auto it = symbolTable.begin(); it != symbolTable.end(); it++) {//for every entry in the symbol table
            string symbolName = it->first;
            if (symbolTable.at(symbolName).getAlloc() == YES && symbolTable.at(symbolName).getMode() == CONSTANT) {
                string value = symbolTable.at(symbolName).getValue();
                if (value == "true") {
                    value = "-1";
                }
                if (value == "false") {
                    value = "0";
                }
                emit(symbolTable.at(symbolName).getInternalName(), "dd", value, "; " + symbolName);
            }
        }

        objectFile << endl;

        // Emit the bss section for variable allocations
        emit("SECTION", ".bss");
        for (auto it = symbolTable.begin(); it != symbolTable.end(); it++) {
            string symbolName = it->first;
            if (symbolTable.at(symbolName).getAlloc() == YES && symbolTable.at(symbolName).getMode() == VARIABLE) {
                emit(symbolTable.at(symbolName).getInternalName(), "resd", "1", "; " + symbolName);
            }
        }
    }

    string Compiler::nextToken() {
    //cout << "       We're in nextToken";

        token = "";

        // Keep looping until a valid token is found or end of file is reached
        while (token == "") {
            switch (ch) {
                case '{': // Process comment
                    while (nextChar() != END_OF_FILE && ch != '}') {
                        // Empty loop body to skip over comment characters
                    }
                    if (ch == END_OF_FILE) {
                        processError("unexpected end of file within a comment");
                    } else {
                        nextChar(); // Move past the closing '}'
                    }
                    break;

                case '}':
                    processError("\"}\" cannot begin a token");
                    break;

                case ' ':
                case '\t':
                case '\n':
                case '\r':
                    nextChar(); // Skip whitespace
                    break;

                default:
                    if (isSpecialSymbol(ch)) {
                        token = ch;
                        nextChar(); // Move to the next character
                    } else if (islower(ch)) {
                        token = ch;
                        while (isalnum(nextChar()) || ch == '_') {
                            token += ch;
                        }
                        if (ch == END_OF_FILE) {
                            processError("unexpected end of file");
                        }
                    } else if (isdigit(ch)) {
                        token = ch;
                        while (isdigit(nextChar())) {
                            token += ch;
                        }
                        if (ch == END_OF_FILE) {
                            processError("unexpected end of file");
                        }
                    } else if (ch == END_OF_FILE) {
                        token = ch;
                    } else {
                        processError("illegal symbol: " + string(1, ch));
                    }
                    break;
            }
        }
        return token;
    }

    char Compiler::nextChar() {
    //cout << "       We're in nextChar";

        // Read the next character from the source file
        if(lineNo == 0 || lineNo == 1)
            lineNo++;

        sourceFile.get(ch);

        if (sourceFile.eof()) {
            ch = END_OF_FILE;
            return ch;
        } 
    
        listingFile.put(ch);
        if (ch == '\n' && sourceFile.peek() != EOF) {
            listingFile << right << setw(5) << lineNo << "|";
            lineNo++;
        }

        return ch;
    }

    string Compiler::genInternalName(storeTypes stype) const
    {
        //cout << "       We're in genInternalName";
        
        string prefix;
        static int boolCount = 0;
        static int intCount = 0;

        // Determine the prefix based on the type
        switch (stype) {
            case INTEGER:
                prefix = "I" + to_string(intCount);
                intCount++;
                break;
            case BOOLEAN:
                prefix = "B" + to_string(boolCount);
                boolCount++;
                break;
            case PROG_NAME:
                prefix = "P";
                break;
            default:
                prefix = "U";  // U for Unknown, just in case
                break;
        }

        return prefix;
    }

    void Compiler::processError(string err) {
        //cout << "       We're in processError";

        // Output the error message to the listing file and terminate the program
        errorCount++;
        listingFile << endl << "Error: " << "Line " << (lineNo - 1) << ": " << err << endl;
        cerr << "Error: " << err << endl; // Also print to standard error for immediate feedback
        createListingTrailer();
        listingFile.flush();
        exit(EXIT_FAILURE); // Exit the program with a failure status
    }