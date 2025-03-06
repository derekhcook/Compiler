#include <iostream>
#include <fstream>
#include <cstdlib>
#include <iomanip>
#include <string>
#include <ctime>
#include <stage1.h>
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
    //cout << "Compiler" << endl;
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
    //cout << "~Compiler" << endl;
    if (sourceFile.is_open()) sourceFile.close();
    if (listingFile.is_open()) listingFile.close();
    if (objectFile.is_open()) objectFile.close();
}

void Compiler::createListingHeader(){
    // Get the current date and time
    //cout << "createListingHeader" << endl;
    time_t now = time(nullptr);
    tm *localTime = localtime(&now);

    // Format the date and time as a string
    char dateTime[100];
    strftime(dateTime, sizeof(dateTime), "%c", localTime);

    if(lineNo == 0)
        lineNo++;

    // Print the header to the listing file
    listingFile << "STAGE1: " << " Trey Fleming, Derek Cook" << "    " << dateTime << endl << endl;
    listingFile << left << setw(10) << "LINE NO." << "            " << "SOURCE STATEMENT" << endl;
    listingFile << endl << setw(5) << right; //<< lineNo << "|";  // A line separator for clarity

}

void Compiler::parser(){
    //cout << "       We're in parser" << endl;

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
    //cout << "       We're in createListingTrailer" << endl;

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
    //cout << "prog" << endl;
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
    //cout << "       We're in progStmt" << endl;

    string x;

     // Check if the token is "program"
    if (token != "program") {
        processError("keyword \"program\" expected");
    }

     // Move to the next token, which should be the program name
    x = nextToken();

    if (x.length() > 15) {
        x = x.substr(0, 15);
    }

     // Ensure the program name is a valid non_key_id
    if (!isNonKeyId(x)) {
        processError("program name expected");
    }

     // Ensure the next token is a semicolon
    if (nextToken() != ";") {
        processError("';' expected");
    }

     // Move to the next token after the semicolon
    nextToken();

     // Emit code for the "program" declaration
    code("program", x);

     // Insert the program name into the symbol table as a constant with no allocation
    insert(x, PROG_NAME, CONSTANT, x, NO, 0);
}

void Compiler::consts(){         // stage 0, production 3
    //cout << "       We're in consts" << endl;
    
    // The token should be "const"
    if (token != "const") {
        processError("keyword \"const\" expected");
    }
    // Move to the next token, which should be a non_key_id
    if (!isNonKeyId(nextToken())) {
        processError("non-keyword identifier must follow \"const\"");
    }
    // Call constStmts() to handle the constant declarations
    constStmts();
}

void Compiler::vars(){           // stage 0, production 4
    //cout << "       We're in vars" << endl;

    // The token should be "var"
    if (token != "var") {
        processError("keyword 'var' expected");
    }

    // Move to the next token, which should be a non_key_id
    if (!isNonKeyId(nextToken())) {
        processError("non-keyword identifier must follow 'var'");
    }

    // Call varStmts() to handle the variable declarations
    varStmts();
}

void Compiler::beginEndStmt(){   // stage 0, production 5
    //cout << "       We're in beginEndStmt" << endl;

    // The token should be "begin"
    if (token != "begin") {
        processError("keyword \"begin\" expected");
    }

    nextToken();
    execStmts();

    // Move to the next token, which should be checked for "end"
    if (token != "end") {
        processError("keyword \"end\" expected");
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
    //cout << "constStmts" << endl;
    string x, y;

    // Check if the current token is a non_key_id
    if (!isNonKeyId(token)) {
        processError("non-keyword identifier expected");
    }

    // Assign the current token to x (the identifier)
    x = token;
    
    // Check if the next token is '='
    if (nextToken() != "=") {
        processError("\"=\" expected");
    }

    // Get the next token, which should be the value assigned
    y = nextToken();

    // Validate that y is one of the allowed types: "+", "-", "not", a non_key_id, "true", "false", or an integer
    if (!(y == "+" || y == "-" || y == "not" || isNonKeyId(y) || y == "true" || y == "false" || isInteger(y))) {
        processError("token to the right of \"=\" illegal");
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
        processError("';' expected");
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
    //cout << "       We're in varStmts" << endl;

     string x, y;

    // Check if the current token is a non_key_id
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
        processError("';' expected");
    }

    insert(x, whichType(y), VARIABLE, "", YES, 1);

    nextToken();

    // Move to the next token and check if it is either "begin" or another non_key_id
    if (!(token == "begin" || isNonKeyId(token))) {
        processError("non-keyword identifier or \"begin\" expected");
    }

    // Recursively call varStmts() if the next token is a non_key_id
    if (isNonKeyId(token)) {
        varStmts();
    }
}

string Compiler::ids(){          // stage 0, production 8
    //cout << "       We're in ids" << endl;

     string temp, tempString;

     // Check if the current token is a non_key_id
    if (!isNonKeyId(token)) {
        processError("non-keyword identifier expected");
    }

     // Assign the current token to tempString and temp
    tempString = token;
    temp = token;

     // Move to the next token and check if it is a comma (indicating more identifiers)
    if (nextToken() == ",") {
        // Move to the next token and ensure it's a non_key_id
        if (!isNonKeyId(nextToken())) {
            processError("non-keyword identifier expected");
        }

         // Recursively call ids() to append more identifiers and format with commas
        tempString = temp + "," + ids();
    }

     // Return the full list of identifiers as a comma-separated string
    return tempString;
}

void Compiler::execStmts() {      // stage 1, production 2
    //cout << "execStmts" << endl;
    execStmt();
    if (token != "end") {
        nextToken();
    }
    if (token == "write" || token == "read" || isNonKeyId(token)) {
        execStmts();
    }
	if (token != "end") {
		processError("non_key_id, \"read\", or \"write\" expected");
	}
    //cout << "leaving execStmts" << endl;
}
void Compiler::execStmt(){       // stage 1, production 3
    //cout << "execStmt" << endl;
    assignStmt();
    readStmt();
    writeStmt();
    //cout << "leaving execStmt" << endl;
}
void Compiler::assignStmt(){     // stage 1, production 4
    //cout << "assignStmt" << endl;
	string popped1, popped2, popped3;
    if (isNonKeyId(token)) {
        pushOperand(token);
        nextToken();
        if (token == ":=") {
            pushOperator(token);
			//cout << ":= pushed" << endl;
            nextToken();
            express();
            if (token != ";") {
                processError("one of \"*\", \"and\", \"div\", \"mod\", \")\", \"+\", \"-\", \";\", \"<\", \"<=\", \"<>\", \"=\", \">\", \">=\", or \"or\" expected");
            }
			popped1 = popOperator();
			popped2 = popOperand();
			popped3 = popOperand();
			//cout << popped1 << " " << popped2 << " " << popped3 << endl;
			code(popped1, popped2, popped3);
        }
        else {
            processError("\":=\" expected in assignment statement");
        }
    }
    //cout << "leaving assignStmt" << endl;
}
void Compiler::readStmt(){       // stage 1, production 5
    //cout << "readStmt" << endl;
    string x;
    if (token == "read") {
        nextToken();
        if (token == "("){
            nextToken();
            x = ids();
            if (token != ")") {
                processError("')' expected are non_key_id in \"read\"");
            }
            if (nextToken() != ";") {
                processError("';' expected");
                exit(EXIT_FAILURE);
            }
            else{
                code("read", x);
            }
        }
        else {
            processError("'(' expected after \"read\"");
        }
    }
    //cout << "leaving readStmt" << endl;
}
void Compiler::writeStmt(){      // stage 1, production 7
    //cout << "writeStmt" << endl;
    string x;
    if (token == "write") {
        nextToken();
        if (token == "("){
            nextToken();
            x = ids();
            if (token != ")") {
                processError("',' or ')' expected after non-keyword identifier");
            }
            else {
                code("write", x);
            }
            if (nextToken() != ";") {
                processError("';' expected");
            }
        }
        else {
            processError("'(' expected after \"write\"");
        }
    }
    //cout << "leaving writeStmt" << endl;
}
void Compiler::express(){        // stage 1, production 9
    //cout << "express" << endl;
    term();
    expresses();
    //cout << "leaving express" << endl;
}
void Compiler::expresses(){      // stage 1, production 10
    //cout << "expresses" << endl;
    string popped1, popped2, popped3;
    if (token == "<" || token == ">" || token == "=" || token == "<>" || token == "<=" || token == ">=") {
        pushOperator(token);
        nextToken();
        term();
        popped1 = popOperator();
        popped2 = popOperand();
        popped3 = popOperand();
        //cout << popped1 << " " << popped2 << " " << popped3 << endl;
        code(popped1, popped2, popped3);
        expresses();
    }
    //cout << "leaving expresses" << endl;
}
void Compiler::term(){           // stage 1, production 11
    //cout << "term" << endl;
    factor();
    terms();
    //cout << "leaving term" << endl;
}
void Compiler::terms(){          // stage 1, production 12
    //cout << "terms" << endl;
    string popped1, popped2, popped3;
    if (token == "+" || token == "-" || token == "or") {
        pushOperator(token);
        nextToken();
        factor();
        popped1 = popOperator();
        popped2 = popOperand();
        popped3 = popOperand();
        //cout << popped1 << " " << popped2 << " " << popped3 << endl;
        code(popped1, popped2, popped3);
        terms();
    }
    //cout << "leaving terms" << endl;
}
void Compiler::factor(){         // stage 1, production 13
    //cout << "factor" << endl;
    part();
    factors();
    //cout << "leaving factor" << endl;
}
void Compiler::factors(){        // stage 1, production 14
    //cout << "factors" << endl;
    string popped1, popped2, popped3;
    if (token == "*" || token == "div" || token == "mod" || token == "and") {
        pushOperator(token);
        nextToken();
        part();
        popped1 = popOperator();
        popped2 = popOperand();
        popped3 = popOperand();
        //cout << popped1 << " " << popped2 << " " << popped3 << endl;
        code(popped1, popped2, popped3);
        factors();
    }
    //cout << "leaving factors" << endl;
}
void Compiler::part(){           // stage 1, production 15
    //cout << "part" << endl;
    string x, popped;
    if (token == "not") {
        nextToken();
        if (token == "(") {
            nextToken();
            express();
            if (token != ")") {
                processError("')' expected");
            }
            else {
                popped = popOperand();
                code("not",popped);
            }
        }
        else if (isBoolean(token)) {
            if (token == "false") {
                pushOperand("true");
            }
            else {
                pushOperand("false");
            }
        }
        else if (isNonKeyId(token)) {
            code ("not", token);
        }
        else {
            processError("expected '(', boolean, or non-keyword id");
        }
		nextToken();
    }
    else if (token == "+" || token == "-") {
        x = token;
        if (nextToken() == "(") {
            nextToken();
            express();
            if (token != ")") {
                processError("')' expected");
            }
            if (x == "-") {
                popped = popOperand();
                code("neg",popped);
            }
			nextToken();
        }
        else if (isInteger(token)) {
            if (x == "-") {
                pushOperand("-" + token);
            }
            else {
                pushOperand(token);
            }
			nextToken();
        }
        else if (isNonKeyId(token)) {
            if (x == "-") {
                code("neg", token);
            }
            else {
                pushOperand(token);
            }
			nextToken();
        }
        else {
            processError("expected '(', integer, or non_key_id");
        }
    }
    else if (token == "(") {
        nextToken();
        express();
        if (token != ")") {
            processError("')' expected");
        }
		nextToken();
    }
    else if ((isInteger(token) || isNonKeyId(token) || isBoolean(token))) {
        pushOperand(token);
		nextToken();
    }
    else {
        processError("expected non_key_id, integer, \"not\", \"true\", \"false\", '(', '+', or '-'");
    }
    //cout << "leaving part" << endl;
}

// Helper functions for the Pascallite lexicon
bool Compiler::isKeyword(string s) const {
    //cout << "       We're in isKeyword" << endl;

    static const std::set<std::string> keywords = {"if", "else", "while", "return", "int", "boolean", "program", "begin", "end", "var", "const", "integer", "true", "false", "not", "mod", "div", "and", "or", "read", "write"};
    return keywords.find(s) != keywords.end();
}

bool Compiler::isSpecialSymbol(char c) const { // determines if c is a special symbol
    //cout << "       We're in isSpecialSymbol" << endl;

    static const std::set<char> specialSymbols = {'+', '-', '*', '/', '=', '<', '>', ';', ',', '.', '(', ')', '{', '}', '[', ']', '!', ':', '?', '&', '|'};
    return specialSymbols.find(c) != specialSymbols.end();
}

bool Compiler::isNonKeyId(string s) const {    // determines if s is a non_key_id
    //cout << "       We're in isNonKeyID" << endl;

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
    //cout << "isInteger" << endl;
    if (s.empty())
        return false;
    // Check if all characters are digits
    if(s[0] == '-')
        s = s.substr(1);
    return all_of(s.begin(), s.end(), ::isdigit);
}

bool Compiler::isBoolean(string s) const {     // determines if s is a boolean
    //cout << "isBoolean" << endl;
   if (s == "true" || s == "false") {
        return true;
    }

    // Check if the string is in the symbol table
    auto it = symbolTable.find(s);
    if (it != symbolTable.end()) {
        // Retrieve the value and check if it's a boolean
        string value = it->second.getValue();
        return (value == "true" || value == "false");
    }

    // Not a boolean
    return false;
}

bool Compiler::isLiteral(string s) const {     // determines if s is a literal
    //cout << "       We're in isLiteral" << endl;

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
    //cout << "       We're in insert" << endl;

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
        
        if(name.length() >= 15)
        {
            name = name.substr(0, 15);
        }

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
				processError("symbol table overflow -- max 256 entries");
			    }
                // External name is defined by the compiler
                symbolTable.insert(pair<string, SymbolTableEntry>(name, SymbolTableEntry(name,inType,inMode,inValue,inAlloc,inUnits)));
            } else {
                if(symbolTable.size() == 256) {
				processError("symbol table overflow -- max 256 entries");
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
    //cout << "       We're in whichType" << endl;

    storeTypes datatype;
    name = name.substr(0, 15);

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
            //listingFile << "UnVar 1";
            processError("reference to undefined symbol " + name);
        }
    }

    // This return is just a safeguard; the function will exit in case of an error
    return datatype; // Default return to satisfy all control paths
    }

    string Compiler::whichValue(string name) {
    //cout << "       We're in whichValue" << endl;

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
                //listingFile << "UnVar 2";
                processError("reference to undefined variable " + name);
            }
        }
        return value;
    }

    void Compiler::code(string op, string operand1, string operand2) {
    //cout << "       We're in code" << endl;
    //listingFile << "code" << endl;

    // Handle the "program" operation
    if (op == "program") {
        emitPrologue(operand1);
    }
    // Handle the "end" operation
    else if (op == "end") {
        emitEpilogue();
    }
    else if (op == "read") {
        emitReadCode(operand1);
    }
    else if (op == "write") {
       emitWriteCode(operand1);
    }
    else if (op == "+") {
        emitAdditionCode(operand1, operand2);
    }
    else if (op == "-") {
        emitSubtractionCode(operand1, operand2);
    }
    else if (op == "neg") {
        emitNegationCode(operand1);
    }
    else if (op == "not") {
        emitNotCode(operand1);
    }
    else if (op == "*") {
        emitMultiplicationCode(operand1, operand2);
    }
    else if (op == "div") {
        emitDivisionCode(operand1, operand2);
    }
    else if (op == "mod") {
        emitModuloCode(operand1, operand2);
    }
    else if (op == "and") {
        emitAndCode(operand1, operand2);
    }
    else if (op == "or") {
        emitOrCode(operand1, operand2);
    }
    else if (op == "=") {
        emitEqualityCode(operand1, operand2);
    }
    else if (op == "<>") {
        emitInequalityCode(operand1, operand2);
    }
    else if (op == ":=") {
        emitAssignCode(operand1, operand2);
    }
    else if (op == "<") {
        emitLessThanCode(operand1, operand2);
    }
    else if (op == "<=") {
        emitLessThanOrEqualToCode(operand1, operand2);
    }
    else if (op == ">") {
        emitGreaterThanCode(operand1, operand2);
    }
    else if (op == ">=") {
        emitGreaterThanOrEqualToCode(operand1, operand2);
    }
    // Handle unexpected operations by reporting an error
    else {
        processError("compiler error: function \"code\" called with illegal arguments: " + op);
    }
    }

void Compiler::pushOperator(string op) {
    //cout << "pushOperator" << endl;
    operatorStk.push(op);
}

string Compiler::popOperator() {
    //cout << "popOperator" << endl;
    //listingFile << "popOperator" << endl;
    string x;
    if (operatorStk.empty() == false) {
        x = operatorStk.top();
        operatorStk.pop();
        return x;
    }
    else {
        processError("compiler error; operator stack underflow");
    }
    return "";
}

void Compiler::pushOperand(string operand){
    //cout << "pushOperator" << endl;
    if(operand.length() >= 15)
        operand = operand.substr(0,15);
    if (isLiteral(operand) && symbolTable.count(operand) == 0) {
        if(operand == "true") {
			symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1) });
        }
		else if(operand == "false") {
			symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1) });
        }
        else {
            insert(operand, whichType(operand), CONSTANT, operand, YES, 1);
        }
    }
    operandStk.push(operand);
}

string Compiler::popOperand() {
    //cout << "popOperand" << endl;
    //listingFile << "popOperand" << endl;
    string x;
    if (operandStk.empty() == false) {
        x = operandStk.top();
        operandStk.pop();
        return x;
    }
    else {
        processError("compiler error; operand stack underflow");
    }
    return "";
}

    void Compiler::emit(string label, string instruction, string operands, string comment) {
    //    cout << "emit" << endl;
    //cout << "       We're in emit";

    // Ensure left justification for all output fields
    objectFile << left;

    // Output the label in a field of width 8
    objectFile << setw(8) << label;

    // Output the instruction in a field of width 8
    objectFile << setw(8) << instruction;

    // Output the operands in a field of width 24
    objectFile << setw(24) << operands;

    objectFile << comment << endl;
    }

    void Compiler::emitPrologue(string progName, string operand2) {
    //cout << "       We're in emitPrologue" << endl;
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
   // cout << "       We're in emitEpilogue" << endl;

        // Emit the exit instruction and storage section
        emit("", "Exit", "{0}");
        objectFile << endl;
        emitStorage(); // Call to emit storage sections
    }

    void Compiler::emitStorage() {
    //cout << "       We're in emitStorage" << endl;

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

    void Compiler::emitReadCode(string operand, string) {
    //    cout << "emitReadCode" << endl;
    string name = "";
    uint i = 0;
    
    while(i < operand.length()) {
        name = "";
        while (name == "") {
            while (i < operand.length() && operand[i] != ',') {
                name = name + operand[i];
                i++;   
            }

            i++;
            name = name.substr(0, 15);
            
            if (symbolTable.count(name) == 0) {
                //cout << "UnVar 3"; Causing issue with 141
                processError("reference to undefined variable " + name);
            } 
            if (whichType(name) == BOOLEAN) {
                processError("can't read variables of this type");
            }
            if (symbolTable.at(name).getMode() != VARIABLE) {
                processError("reading in of read-only location '" + name + "'");
            }
			emit("", "call", "ReadInt", "; read int; value placed in eax");
			emit("", "mov", "[" + symbolTable.at(name).getInternalName() + "],eax", "; store eax at " + name);
			contentsOfAReg = name;
        }
    }
}

void Compiler::emitWriteCode(string operand, string) {
    /*  mov     eax,[I2]                ; load a in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out*/
        //cout << "emitWriteCode" << endl;
    string name = "";
	uint i = 0;
    
    while(i < operand.length()) {
        name = "";
        while (name == "") {
            while (i < operand.length() && operand[i] != ',') {
                name = name + operand[i];
                i++;   
            }

            i++;
            name = name.substr(0, 15);
            
            if (symbolTable.count(name) == 0) {
                //cout << "UnVar 4";
                processError("reference to undefined variable " + name);
            }
            if (contentsOfAReg != name) {
                emit("", "mov", "eax,[" + symbolTable.at(name).getInternalName() + "]", "; load " + name + " in eax");
				contentsOfAReg = name;
            }
            if (whichType(name) == INTEGER || whichType(name) == BOOLEAN) {
                emit("", "call", "WriteInt", "; write int in eax to standard out");
            }
                
            emit("", "call", "Crlf", "; write \\r\\n to standard out");                
        }
    }
}

void Compiler::emitAssignCode(string operand1, string operand2) { // op2 = op1
    //cout << "emitAssignCode" << endl;
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("incompatible types for operator ':='");
    }
    if (symbolTable.at(operand2).getMode() != VARIABLE) {
        processError("symbol on left-hand side of assignment must have a storage mode of VARIABLE");
    }
    if (operand1 == operand2) {
        return;
    }
    if (operand1 != contentsOfAReg) {
        emit("", "mov", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand1 + "");
    }
    emit("", "mov", "[" + symbolTable.at(operand2).getInternalName() + "],eax", "; " + operand2 + " = AReg");
    contentsOfAReg = operand2;
    if (isTemporary(operand1)) {
        freeTemp();
    }
}

void Compiler::emitAdditionCode(string operand1, string operand2) { // op2 + op1
    //cout << endl << "emitAdditionCode" << endl;
    if (whichType(operand1) != INTEGER || whichType(operand2) != INTEGER) {
        processError("binary '+' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
        contentsOfAReg = operand2;
    }
	
	if(contentsOfAReg == operand1)
		emit("", "add", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand1 + " + " + operand2); 
    else if(contentsOfAReg == operand2)
		emit("", "add", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " + " + operand1);
	
	if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
	
	contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(INTEGER);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitSubtractionCode(string operand1, string operand2) { // op2 - op1
    //cout << "emitSubtractionCode" << endl;
    if (whichType(operand1) != INTEGER || whichType(operand2) != INTEGER) {
        processError("binary '-' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
	//cout << "Error in not isTemporary?" << endl;
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
	//cout << "Error in checking against Operand2?" << endl;
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
        contentsOfAReg = operand2;
    }
    
    emit("", "sub", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " - " + operand1);
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(INTEGER);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitMultiplicationCode(string operand1, string operand2) { // op2 * op1
    //cout << "emitMultiplicationCode" << endl;
    //listingFile << "mulOut" << endl;
    if (whichType(operand1) != INTEGER || whichType(operand2) != INTEGER) {
        processError("binary '*' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
        //listingFile << "03" << endl;
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
        //listingFile << "01" << endl;
    }
    if (contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
        contentsOfAReg = operand2;
        //listingFile << "02" << endl;
    }
	
	if(contentsOfAReg == operand1){
		emit("", "imul", "dword [" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand1 + " * " + operand2);
        //listingFile << "03" << endl;
    }
    else if(contentsOfAReg == operand2){
		emit("", "imul", "dword [" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " * " + operand1);
        //listingFile << "04" << endl;
    }
	if(isTemporary(operand1)){
		freeTemp();
        //listingFile << "05" << endl;
    }
	if(isTemporary(operand2)){
		freeTemp();
        //listingFile << "06" << endl;
    }
	
	contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(INTEGER);
    //listingFile << "07" << endl;
   
    pushOperand(contentsOfAReg);
    //listingFile << "08" << endl;
}

void Compiler::emitDivisionCode(string operand1, string operand2) { // op2 / op1
    //cout << "emitDivisionCode" << endl;
    if (whichType(operand1) != INTEGER || whichType(operand2) != INTEGER) {
        processError("binary 'div' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
        contentsOfAReg = operand2;
    }
    
    emit("","cdq","","; sign extend dividend from eax to edx:eax");
    emit("", "idiv", "dword [" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " div " + operand1);
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(INTEGER);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitModuloCode(string operand1, string operand2) { // op2 % op1
    //cout << "emitModuloCode" << endl;
    if (whichType(operand1) != INTEGER || whichType(operand2) != INTEGER) {
        processError("binary 'mod' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
        contentsOfAReg = operand2;
    }
    
    emit("","cdq","","; sign extend dividend from eax to edx:eax");
    emit("", "idiv", "dword [" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " div " + operand1);
    emit("", "xchg", "eax,edx", "; exchange quotient and remainder");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(INTEGER);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitNegationCode(string operand1, string operand2) { // -op1
    //cout << "emitNegationCode" << endl;
    if (whichType(operand1) != INTEGER) {
        processError("unary '-' requires integer operand");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand1) {
        emit("", "mov", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand1);
        contentsOfAReg = operand1;
    }
    
    emit("", "neg ", "eax", "; AReg = -AReg");
    
    if(isTemporary(operand1))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(INTEGER);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitNotCode(string operand1, string operand2) { // !op1
    //cout << "emitNotCode" << endl;
    if (whichType(operand1) != BOOLEAN) {
        processError("unary 'not' requires boolean operand");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand1) {
        emit("", "mov", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand1);
        contentsOfAReg = operand1;
    }
    
    emit("", "not", "eax", "; AReg = !AReg");
    
    if(isTemporary(operand1))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitAndCode(string operand1, string operand2) { // op2 && op1
    //cout << "emitAndCode" << endl;
    if (whichType(operand1) != BOOLEAN || whichType(operand2) != BOOLEAN) {
        processError("binary 'and' requires boolean operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
    
    if (contentsOfAReg == operand1)
        emit("", "and", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand1 + " and " + operand2);
    else
        emit("", "and", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " and " + operand1);
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitOrCode(string operand1, string operand2) { // op2 || op1
    //cout << "emitOrCode" << endl;
    if (whichType(operand1) != BOOLEAN || whichType(operand2) != BOOLEAN) {
        processError("binary 'or' requires boolean operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
    
    if (contentsOfAReg == operand1)
        emit("", "or", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand1 + " or " + operand2);
    else
        emit("", "or", "eax,[" + symbolTable.at(operand1).getInternalName() + "]", "; AReg = " + operand2 + " or " + operand1);
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitEqualityCode(string operand1, string operand2) { // op2 == op1
    //cout << "emitEqualityCode" << endl;
    string label1 = getLabel();
    string label2 = getLabel();
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("binary '=' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
    if (contentsOfAReg != operand1)
        emit("", "cmp", "eax,[" + symbolTable.at(operand1).getInternalName() + "]","; compare " + operand2 + " and " + operand1);
    else
        emit("", "cmp", "eax,[" + symbolTable.at(operand2).getInternalName() + "]","; compare " + operand1 + " and " + operand2);
    
    emit("", "je", label1, "; if " + operand2 + " = " + operand1 + " then jump to set eax to TRUE" );
    emit("", "mov", "eax,[FALSE]", "; else set eax to FALSE");
    if (symbolTable.count("false") == 0) {
        symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1)});
    }
    emit("", "jmp", label2, "; unconditionally jump");
    emit(label1 + ":", "", "", ""); 
	emit("", "mov", "eax,[TRUE]", "; set eax to TRUE");
    if (symbolTable.count("true") == 0) {
        symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1)});
    }
	emit(label2 + ":", "", "", "");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitInequalityCode(string operand1, string operand2) { // op2 != op1
    //cout << "emitInequalityCode" << endl;
    string label1 = getLabel();
    string label2 = getLabel();
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("binary '<>' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2 && contentsOfAReg != operand1) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
    if (contentsOfAReg != operand1)
        emit("", "cmp", "eax,[" + symbolTable.at(operand1).getInternalName() + "]","; compare " + operand2 + " and " + operand1);
    else
        emit("", "cmp", "eax,[" + symbolTable.at(operand2).getInternalName() + "]","; compare " + operand1 + " and " + operand2);
    
    emit("", "jne", label1, "; if " + operand2 + " <> " + operand1 + " then jump to set eax to TRUE" );
    emit("", "mov", "eax,[FALSE]", "; else set eax to FALSE");
    if (symbolTable.count("false") == 0) {
        symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1)});
    }
    emit("", "jmp", label2, "; unconditionally jump");
    emit(label1 + ":", "", "", ""); 
	emit("", "mov", "eax,[TRUE]", "; set eax to TRUE");
    if (symbolTable.count("true") == 0) {
        symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1)});
    }
	emit(label2 + ":", "", "", "");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitLessThanCode(string operand1, string operand2) { // op2 < op1
    //cout << "emitLessThanCode" << endl;
    string label1 = getLabel();
    string label2 = getLabel();
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("binary '<' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
   
    emit("", "cmp", "eax,[" + symbolTable.at(operand1).getInternalName() + "]","; compare " + operand2 + " and " + operand1);
   
    
    emit("", "jl", label1, "; if " + operand2 + " < " + operand1 + " then jump to set eax to TRUE" );
    emit("", "mov", "eax,[FALSE]", "; else set eax to FALSE");
    if (symbolTable.count("false") == 0) {
        symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1)});
    }
    emit("", "jmp", label2, "; unconditionally jump");
    emit(label1 + ":", "", "", ""); 
	emit("", "mov", "eax,[TRUE]", "; set eax to TRUE");
    if (symbolTable.count("true") == 0) {
        symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1)});
    }
	emit(label2 + ":", "", "", "");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitLessThanOrEqualToCode(string operand1, string operand2) { // op2 <= op1
    //cout << "emitLessThanOrEqualToCode" << endl;
    string label1 = getLabel();
    string label2 = getLabel();
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("binary '<=' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
   
    emit("", "cmp", "eax,[" + symbolTable.at(operand1).getInternalName() + "]","; compare " + operand2 + " and " + operand1);
   
    
    emit("", "jle", label1, "; if " + operand2 + " <= " + operand1 + " then jump to set eax to TRUE" );
    emit("", "mov", "eax,[FALSE]", "; else set eax to FALSE");
    if (symbolTable.count("false") == 0) {
        symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1)});
    }
    emit("", "jmp", label2, "; unconditionally jump");
    emit(label1 + ":", "", "", ""); 
	emit("", "mov", "eax,[TRUE]", "; set eax to TRUE");
    if (symbolTable.count("true") == 0) {
        symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1)});
    }
	emit(label2 + ":", "", "", "");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitGreaterThanCode(string operand1, string operand2) { // op2 > op1
    //cout << "emitGreaterThanCode" << endl;
    string label1 = getLabel();
    string label2 = getLabel();
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("binary '>' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
   
    emit("", "cmp", "eax,[" + symbolTable.at(operand1).getInternalName() + "]","; compare " + operand2 + " and " + operand1);
   
    
    emit("", "jg", label1, "; if " + operand2 + " > " + operand1 + " then jump to set eax to TRUE" );
    emit("", "mov", "eax,[FALSE]", "; else set eax to FALSE");
    if (symbolTable.count("false") == 0) {
        symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1)});
    }
    emit("", "jmp", label2, "; unconditionally jump");
    emit(label1 + ":", "", "", ""); 
	emit("", "mov", "eax,[TRUE]", "; set eax to TRUE");
    if (symbolTable.count("true") == 0) {
        symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1)});
    }
    emit(label2 + ":", "", "", "");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

void Compiler::emitGreaterThanOrEqualToCode(string operand1, string operand2) { // op2 >= op1
    //cout << "emitGreaterThanOrEqualToCode" << endl;
    string label1 = getLabel();
    string label2 = getLabel();
    if (symbolTable.at(operand1).getDataType() != symbolTable.at(operand2).getDataType()) {
        processError("binary '>=' requires integer operands");
    }
    if (isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        emit("", "mov", "[" + symbolTable.at(contentsOfAReg).getInternalName() + "],eax", "; deassign AReg");
        symbolTable.at(contentsOfAReg).setAlloc(YES);
        contentsOfAReg = "";
    }
    if (!isTemporary(contentsOfAReg) && contentsOfAReg != operand1 && contentsOfAReg != operand2) {
        contentsOfAReg = "";
    }
    if (contentsOfAReg != operand2) {
        emit("", "mov", "eax,[" + symbolTable.at(operand2).getInternalName() + "]", "; AReg = " + operand2);
    }
   
    emit("", "cmp", "eax,[" + symbolTable.at(operand1).getInternalName() + "]","; compare " + operand2 + " and " + operand1);
   
    
    emit("", "jge", label1, "; if " + operand2 + " >= " + operand1 + " then jump to set eax to TRUE" );
    emit("", "mov", "eax,[FALSE]", "; else set eax to FALSE");
    if (symbolTable.count("false") == 0) {
        symbolTable.insert({ "false", SymbolTableEntry("FALSE", BOOLEAN, CONSTANT, "0", YES, 1)});
    }
    emit("", "jmp", label2, "; unconditionally jump");
    emit(label1 + ":", "", "", ""); 
    emit("", "mov", "eax,[TRUE]", "; set eax to TRUE");
    if (symbolTable.count("true") == 0) {
        symbolTable.insert({ "true", SymbolTableEntry("TRUE", BOOLEAN, CONSTANT, "-1", YES, 1)});
    }
	emit(label2 + ":", "", "", "");
    
    if(isTemporary(operand1))
		freeTemp();
	if(isTemporary(operand2))
		freeTemp();
    
    contentsOfAReg = getTemp();
    symbolTable.at(contentsOfAReg).setDataType(BOOLEAN);
   
    pushOperand(contentsOfAReg);
}

    string Compiler::nextToken() {
    //cout << "       We're in nextToken" << endl;

    token = "";
    while (token == "") {
        if (ch == '{') {
            nextChar();
            while (ch != END_OF_FILE && ch != '}') {
                nextChar();
            }
            if (ch == END_OF_FILE) {
                processError("unexpected end of file");
            }
            else {
                nextChar();
            }
        }
        else if (ch == '}') {
            processError("'}' cannot begin token");
        }
        else if (ch == ' ' || ch == '\n' || ch == 9) {
            nextChar();
        }
        else if (isSpecialSymbol(ch)) {
            if (ch == ':') {
                token = ch;
                if (sourceFile.peek() == '=') {
                    nextChar();
                    token += ch;
                }
            }
            else if (ch == '<') {
                token = ch;
                if (sourceFile.peek() == '>' || sourceFile.peek() == '=') {
                    nextChar();
                    token += ch;
                }
            }
            else if (ch == '>') {
                token = ch;
                if (sourceFile.peek() == '=') {
                    nextChar();
                    token += ch;
                }
            }
            else {
                token = ch;
            }
            nextChar();
        }
        else if (islower(ch)) {
            token = ch;
            nextChar();
            bool test = (islower(ch) || isupper(ch) || isdigit(ch) || ch == '_');
            while (test && (ch != END_OF_FILE)) {
                token += ch;
                if (ch == '_') {
                    nextChar();
                    if (ch == '_') {
                        processError("non-keyword identifier, \"begin\", or \"var\" expected");
                    }
                }
                else {
                    nextChar();
                }
                test = (islower(ch) || isupper(ch) || isdigit(ch) || ch == '_');
            }
            if (ch == END_OF_FILE) {
                processError("unexpected end of file");
            }
        }
        else if (isdigit(ch)) {
            token = ch;
            nextChar();
            while (isdigit(ch) && ch != END_OF_FILE) {
                token += ch;
                nextChar();
            }
            if (ch == END_OF_FILE) {
                processError("unexpected end of file");
            }
        }
        else if (ch == END_OF_FILE) {
            token = ch;
        }
        else { // default
            processError("illegal symbol");
        }
    }
    return token;
    }

    char Compiler::nextChar() {
        sourceFile.get(ch);

        static char prev_ch = '\n';  // Initialize to '\n' to handle the first line correctly

        // Handle end-of-file case
        if (sourceFile.eof()) {
            ch = END_OF_FILE;
            return ch;
        }

        // Handle new line
        if (prev_ch == '\n') {
            listingFile << setw(5) << lineNo << "|";
            lineNo++;
            //start_of_line = true;
        }

        // Write character to the listing file
        listingFile.put(ch);
        prev_ch = ch;

    return ch;
    }

    string Compiler::genInternalName(storeTypes stype) const
    {
        // cout << "       We're in genInternalName" << endl;
        
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
        //cout << "       We're in processError" << endl;

        // Output the error message to the listing file and terminate the program
        errorCount++;
        //listingFile << "10" << endl;
        listingFile << endl << "Error: " << "Line " << (lineNo - 1) << ": " << err << endl;
        cerr << "Error: " << err << endl; // Also print to standard error for immediate feedback
        createListingTrailer();
        listingFile.flush();
        exit(EXIT_FAILURE); // Exit the program with a failure status
    }

    void Compiler::freeTemp() {
    currentTempNo--;
    if (currentTempNo < -1)
        processError("compiler error, currentTempNo should be >= -1");
}

string Compiler::getTemp() {
    //cout << "getTemp" << endl;
    string temp;
    currentTempNo++;
    temp = "T" + to_string(currentTempNo);
    if (currentTempNo > maxTempNo) {
        insert(temp, UNKNOWN, VARIABLE, "", NO, 1);
        maxTempNo++;
    }
    return temp;
}

string Compiler::getLabel() {
    //cout << "getLabe" << endl;
    static int labelCount = -1;
	string label;
	labelCount++;
	label = ".L" + to_string(labelCount);
	return label; // Return the current label
}

bool Compiler::isTemporary(string s) const {
    //cout << "isTemp" << endl;
	if (symbolTable.count(s) != 0) {
		if (symbolTable.at(s).getInternalName()[0] == 'T' && symbolTable.at(s).getInternalName() != "TRUE") {
			return true;
		}
	}
    return false;
}