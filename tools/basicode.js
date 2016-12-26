"use strict";

///////////////////////////////////////////////////////////////////////////////
// BASICODE interpreter
// Copyright (c) 2016 Rob Hagemans
// Licensed under the GNU General Public Licence, version 3
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// For a similar interpreter see https://github.com/MarquisdeGeek/basicode
// which is (c) 2012 by Steven Goodwin and licensed under the GPL
//
// I'd like to acknowledge Steven's interpreter as a source of inspiration.
// However, this interpreter does not take code from his.


///////////////////////////////////////////////////////////////////////////////
// data store

function Data()
{
    this.vault = [];
    this.pointer = 0;

    this.read = function()
    {
        if (this.pointer < this.vault.length) {
            this.pointer += 1;
            return this.vault[this.pointer-1];
        }
        else {
            throw 'Out of Data';
        }
    };

    this.restore = function()
    {
        this.pointer = 0;
    };

    this.store = function(new_data)
    {
        this.vault = this.vault.concat(new_data);
    }

    this.clear = function()
    {
        this.vault = [];
        this.pointer = 0;
    }

}

///////////////////////////////////////////////////////////////////////
// types, variables, arrays

function defaultValue(name)
// default value for type given by name
{
    var default_value = 0;
    if (name.slice(-1) === '$') default_value = '';
    return default_value;
}

function matchType(name, value)
{
    var string_name = (name.slice(-1) === '$');
    var string_value = typeof value === 'string';
    if (!string_value && typeof value !== 'number') {
        throw 'Type mismatch: unknown type';
    }
    if (string_name !== string_value) {
        throw 'Type mismatch';
    }
}

function Variables()
{
    this.vars = {};
    this.dims = {};

    this.allocate = function(name, indices)
    // allocate an array
    {
        // no redefinitions allowed
        if (name in this.dims || name in this.vars) throw 'Duplicate definition';
        // BASICODE arrays may have at most two indices
        if (indices.length > 2) throw 'Subscript out of range: too many array dimensions';

        // set default to empty string if string name, 0 otherwise
        var default_value = defaultValue(name);

        function allocateLevel(indices) {
            if (indices.length === 0) return default_value;
            else {
                // allocate subarray; BASICODE arrays span 0..x inclusive
                var arr = new Array(indices[0]+1);
                // feed remaining arguments to recursive call
                var argarray = indices.slice(1);
                // allocate deeper level
                for (var i=0; i < arr.length; ++i) {
                    arr[i] = allocateLevel(argarray);
                }
                return arr;
            }
        };

        // I'm assuming a name is *either* a scalar *or* an array
        // this is not true in e.g. GW-BASIC, but I think it's true in BASICODE
        this.dims[name] = indices;
        this.vars[name] = allocateLevel(indices);
    }

    this.checkSubscript = function(name, indices)
    {
        if (!(name in this.dims)) {
            if (indices.length === 0) {
                this.vars[name] = defaultValue(name);
                this.dims[name] = [];
            }
            else {
                throw 'Subscript out of range: array not dimensioned';
            }
        }
        else if (indices.length !== this.dims[name].length) {
            throw 'Subscript out of range: incorrect number of dimensions';
        }
        else {
            for (var i=0; i < indices.length; ++i) {
                if (indices[i] < 0 || indices[i] > this.dims[name][i]) {
                    throw 'Subscript out of range: index '+i+' out of bounds';
                }
            }
        }
    }

    this.assign = function(value, name, indices)
    // set a variable
    {
        this.checkSubscript(name, indices);

        if (indices.length === 0) {
            this.vars[name] = value;
        }
        else if (indices.length === 1) {
            this.vars[name][indices[0]] = value;
        }
        else {
            this.vars[name][indices[0]][indices[1]] = value;
        }
    };

    this.retrieve = function(name, indices)
    // retrieve a variable
    {
        this.checkSubscript(name, indices);

        if (indices.length === 0) {
            return this.vars[name];
        }
        else if (indices.length === 1) {
            return this.vars[name][indices[0]];
        }
        else {
            return this.vars[name][indices[0]][indices[1]];
        }
    };
}

//////////////////////////////////////////////////////////////////////
// tokens

function tokenSeparator(bracket_char)
{
    this.token_type = bracket_char;
    this.payload = bracket_char;
}

function tokenLiteral(value)
{
    this.token_type = 'literal';
    this.operation = function opLiteral(x) { return x; };
    this.payload = value;
}

function tokenName(value)
{
    this.token_type = 'name';
    this.payload = value;
}

function newFunctionToken(keyword, operation) {
    return (function() {
        return (new function tokenFunction() {
            this.token_type = 'function';
            this.payload = keyword;
            this.operation = operation;
        }() );
    } );
}
function newStatementToken(keyword, parseStatement, operation) {
    return (function() {
        return (new function tokenStatement() {
            this.token_type = 'statement';
            this.payload = keyword;
            this.parseStatement = parseStatement;
            this.operation = operation;
        }() );
    } );
}
function newOperatorToken(keyword, narity, precedence, operation) {
    return (function() {
        return (new function tokenOperator() {
            this.token_type = 'operator';
            this.payload = keyword;
            this.narity = narity;
            this.precedence = precedence;
            this.operation = operation;
        }() );
    } );
}

const SYMBOLS = {
    '^': newOperatorToken('^', 2, 12, Math.pow),
    '*': newOperatorToken('*', 2, 11, function opMultiply(x, y) { return x * y; }),
    '/': newOperatorToken('/', 2, 11, function opDivide(x, y) { return x / y; }),
    // + adds numbers or concatenates strings
    // does BASICODE accept unary + ?
    '+': newOperatorToken('+', 2, 8, function opAddOrConcatenate(x, y) { return x + y; }),
    // - can be unary negation or binary subtraction
    '-': newOperatorToken('-', null, 8, function opSubtractOrNegate(x, y) { if (y === undefined) return -x; else return x - y; }),
    '=': newOperatorToken('=', 2, 7, function opEqual(x, y) { return (x === y); }),
    '>': newOperatorToken('>', 2, 7, function opGreaterThan(x, y) { return (x > y); }),
    '>=': newOperatorToken('>=', 2, 7, function opGreaterThanOrEqual(x, y) { return (x >= y); }),
    '<': newOperatorToken('<', 2, 7, function opLessThan(x, y) { return (x > y); }),
    '<=': newOperatorToken('<=', 2, 7, function opLessThanOrEqual(x, y) { return (x <= y); }),
    '<>': newOperatorToken('<>', 2, 7, function opNotEqual(x, y) { return (x !== y); }),
}

const KEYWORDS = {
    'ABS': newFunctionToken('ABS', Math.abs),
    'AND': newOperatorToken('AND', 2, 5, function opAnd(x, y) { return (x && y); }),
    'ASC': newFunctionToken('ASC', function fnAsc(x) { return x.charCodeAt(0); } ),
    'ATN': newFunctionToken('ATN', Math.atan),
    'CHR$': newFunctionToken('CHR$', String.fromCharCode),
    'COS': newFunctionToken('COS', Math.cos),
    'DATA': newStatementToken('DATA', parseData, function(){}),
    'DIM': newStatementToken('DIM'),
    'EXP': newFunctionToken('EXP', Math.exp),
    'FOR': newStatementToken('FOR'),
    'GOSUB': newStatementToken('GOSUB'),
    'GOTO': newStatementToken('GOTO'),
    'IF': newStatementToken('IF'),
    'INPUT': newStatementToken('INPUT'),
    'INT': newFunctionToken('INT', Math.trunc),
    'LEFT$': newFunctionToken('LEFT$', function fnLeft(x, n) { return x.slice(0, n); }),
    'LEN': newFunctionToken('LEN', function fnLen(x, n) { return x.length; }),
    'LET': newStatementToken('LET', parseLet, stLet),
    'LOG': newFunctionToken('LOG', Math.log),
    'MID$': newFunctionToken('MID$', function fnMid(x, start, n) { return x.slice(start, n); }),
    'NEXT': newStatementToken('NEXT'),
    'NOT': newOperatorToken('NOT', 1, 6, function opNot(x) { return (!x); }),
    'ON': newStatementToken('ON'),
    'OR': newOperatorToken('OR', 2, 4, function opOr(x, y) { return (x || y); }),
    'PRINT': newStatementToken('PRINT', parsePrint, stPrint),
    'READ': newStatementToken('READ', parseRead, stRead),
    'REM': newStatementToken('REM'),
    'RESTORE': newStatementToken('RESTORE', function(){ return []; }, stRestore),
    'RETURN': newStatementToken('RETURN'),
    'RIGHT$': newFunctionToken('RIGHT$', function fnRight(x, n) { return x.slice(-n); }),
    'SGN': newFunctionToken('SGN', Math.sign),
    'SIN': newFunctionToken('SIN', Math.sin),
    'SQR': newFunctionToken('SQR', Math.sqrt),
    'STEP': newStatementToken('STEP'),
    'TAB': newFunctionToken('TAB'), //TODO
    'TAN': newFunctionToken('TAN', Math.tan),
    'THEN': newStatementToken('THEN'),
    'TO': newStatementToken('TO'),
    'VAL': newFunctionToken('VAL'), //TODO
}

// additional reserved words: AS, AT, FN, GR, IF, LN, PI, ST, TI, TI$


//////////////////////////////////////////////////////////////////////
// lexer


function tokenise(expr_string)
// convert expression string to list of tokens
{
    var pos = 0;

    function isNumberChar(char)
    {
        return (char >= '0' && char <= '9');
    }

    function isAlphaChar(char)
    {
        return (char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z');
    }

    function readString() {
        // read a double-quoted string literal
        var start_pos = pos;
        // skip start and closing quotes
        for (++pos; (pos < expr_string.length && expr_string[pos] !== '"'); ++pos);
        if (pos === expr_string.length) {
            throw 'Syntax error: no closing `"`';
        }
        return expr_string.slice(start_pos+1, pos);
    }

    function readInteger() {
        // read an unsigned integer literal (i.e. a string of numbers)
        var start_pos = pos;
        for (; pos < expr_string.length-1; ++pos){
            if (!isNumberChar(expr_string[pos+1])) break;
        }
        return expr_string.slice(start_pos, pos+1);
    }

    function readName() {
        // read a name (variable or keyword)
        var start_pos = pos;
        for (; pos < expr_string.length-1; ++pos){
            // the name can end in at most one $
            if (expr_string[pos+1] === '$') {
                ++pos;
                break;
            }
            if (!isAlphaChar(expr_string[pos+1]) && !isNumberChar(expr_string[pos+1])) break;
        }
        return expr_string.slice(start_pos, pos+1).toUpperCase();
    }

    var expr_list = [];
    for (pos=0; pos < expr_string.length; ++pos) {
        var char = expr_string[pos];
        // deal with line breaks, CR, LF and CR LF all work
        if (char === '\r') {
            if (pos+1 < expr_string.length && expr_string[pos+1] === '\n') {
                ++pos;
            }
            char = '\n';
        }
        if (char in SYMBOLS) {
            var operator = char;
            // two-symbol operators all start with lt or gt
            if (char == '<' || char == '>') {
                if (pos+1 < expr_string.length) {
                    var char2 = expr_string[pos+1];
                    if (char2 == '<' || char2 == '>' || char2 == '=') {
                        operator += char2;
                        ++pos;
                    }
                }
            }
            expr_list.push(SYMBOLS[operator]());
        }
        else if (char === '(' || char === ')' ||
                    char === ',' || char === ';' ||
                    char === ':' || char === '\n') {
            expr_list.push(new tokenSeparator(char));
        }
        // double quotes, starts a string
        else if (char === '"') {
            expr_list.push(new tokenLiteral(readString()));
        }
        // numeric character, starts a number literal
        // for VAL(), we should also accept a - here later
        else if (isNumberChar(char) || char === '.') {
            var mantissa = 0;
            var decimal = 0;
            var exponent = 0;
            if (isNumberChar(char)) {
                mantissa = readInteger();
            }
            else {
                --pos;
            }
            if (pos+1 < expr_string.length && expr_string[pos+1] === '.') {
                ++pos;
                if (pos+1 < expr_string.length && isNumberChar(expr_string[pos+1])) {
                    ++pos;
                    decimal = readInteger();
                }
            }
            if (pos+1 < expr_string.length && (expr_string[pos+1] === 'E' || expr_string[pos+1] === 'e')) {
                ++pos;
                if (pos+1 < expr_string.length && (isNumberChar(expr_string[pos+1]) || expr_string[pos+1] === '-')) {
                    ++pos;
                    if (expr_string[pos+1] === '-') {
                        ++pos;
                        exponent = '-' + readInteger();
                    }
                    else {
                        exponent = readInteger();
                    }
                }
            }
            expr_list.push(new tokenLiteral(
                parseFloat(mantissa + '.' + decimal + 'e' + exponent)));
        }
        else if (isAlphaChar(char)) {
            var name = readName();
            if (name in KEYWORDS) {
                // call function that calls new on a constructor
                expr_list.push(KEYWORDS[name]());
            }
            else {
                expr_list.push(new tokenName(name));
            }
        }
        else if (char !== ' ') {
            throw 'Syntax error: unexpected symbol `'+ char + '`';
        }
    }
    return expr_list;
}


//////////////////////////////////////////////////////////////////////
// AST

function Node(func, node_args)
{
    this.func = func;
    this.args = node_args;

    // traverse AST to evaluate this node and all its subnodes
    this.evaluate = function()
    {
        var args = this.args.slice()
        for (var i = 0; i < args.length; ++i) {
            if (args[i] instanceof Node) {
                args[i] = args[i].evaluate();
            }
        }
        // call the function with the array supplied as arguments
        return this.func.apply(this, args);
    };
}


//////////////////////////////////////////////////////////////////////
// parser


function parseLet(parser, expr_list)
// parse LET statement
{
    var name = expr_list.shift();
    if (name.token_type != 'name') {
        throw 'Syntax error: expected variable name, got `' + name.payload + '`';
    }
    var indices = parser.parseArguments(expr_list);
    var equals = expr_list.shift().payload;
    if (equals !== '=') throw 'Syntax error: expected `=`, got `'+equals+'`';
    var value = parser.parseExpression(expr_list);
    return [value, name.payload, indices];
}

function parsePrint(parser, expr_list)
// parse PRINT statement
{
    var exprs = [];
    var last = null;
    while (expr_list.length > 0) {
        var expr = parser.parseExpression(expr_list);
        if (expr !== null) {
            exprs.push(expr);
            last = expr;
        }
        if (!expr_list.length) break;
        if (expr_list[0].payload !== ';') break;
        last = ';';
        expr_list.shift();
    }
    if (last !== ';') {
        exprs.push(new Node(function(){ return '\n'; }, []));
    }
    return exprs;
}

function parseData(parser, expr_list)
// parse DATA statement
{
    var values = []
    while (expr_list.length > 0) {
        var value = expr_list.shift();
        // only literals allowed in DATA
        // we're not allowing empty DATA statements or repeated commas
        if (value === null || value.token_type != 'literal') {
            throw 'Syntax error: expected string or number literal';
        }
        values.push(value.payload);
        // parse separator (,)
        if (!expr_list.length) break;
        if (expr_list[0].payload !== ',') break;
        expr_list.shift();
    }
    // data is stored immediately upon parsing, DATA is then a no-op statement
    parser.data.store(values);
    return [];
}

function parseRead(parser, expr_list)
// parse READ statement
{
    var names = [];
    while (expr_list.length > 0) {
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw 'Syntax error: expected variable name, got `' + name.payload + '`';
        }
        var indices = parser.parseArguments(expr_list);
        names.push([name.payload, indices])
        if (!expr_list.length) break;
        if (expr_list[0].payload !== ',') break;
        expr_list.shift();
    }
    return names;
}


function Parser(state)
{
    // data is stored upon parsing, not evaluation
    this.data = state.data;

    function opRetrieve(name)
    //  retrieve a variable from the Variables object provided to Parser at initialisation
    {
        var indices = [].slice.call(arguments, 1);
        return state.variables.retrieve(name, indices);
    }

    function drain(precedence, stack, units)
    // pop operator stack until matching precedence is encountered
    {
        while ((stack.length > 0)) {

            if (precedence > stack[stack.length-1].precedence) {
                break;
            }
            var token = stack.pop();
            var args = units.slice(units.length - token.narity);
            // we need to pop without slicing the units
            // to affect the mutable argument
            for (var i=0; i < args.length; ++i) {
                units.pop();
            }
            units.push(new Node(token.operation, args));
        }
        return units;
    };

    this.parseExpression = function(expr_list)
    // parse expression from a list of tokens to an AST
    // variation of Dijkstra's shunting-yard algorithm, following PC-BASIC
    {
        var stack = [];
        var units = [];
        var token = null;
        var exit_loop = false;
        //for (var pos = 0; pos < expr_list.length; ++pos) {
        while (expr_list.length > 0) {
            var last = token;
            token = expr_list.shift();
            if (token.token_type === 'operator') {
                // only a unary operator after another operator or at the start
                var narity = 2;
                if (last === null || last.token_type === 'operator') {
                    // narity 1: prefix, 2: binary infix
                    // narity null is for - which can be prefix or infix
                    narity = 1;
                }
                if (token.narity !== null && token.narity !== narity) {
                    throw 'Syntax error: unexpected operator type';
                }
                if (narity === 2) {
                    // drain stack until precedence is matched
                    drain(token.precedence, stack, units);
                }
                // (copy and?) override the narity of - before pushing
                token.narity = narity;
                stack.push(token)
            }
            else if (last === null || last.token_type === 'operator') {
                switch (token.token_type) {
                    case 'function':
                        var args = this.parseArguments(expr_list);
                        units.push(new Node(token.operation, args));
                        break;
                    case '(':
                        // recursive call, gets a Node object containing AST
                        units.push(this.parseExpression(expr_list));
                        var bracket = expr_list.shift(token);
                        if (bracket.token_type !== ')') {
                            throw 'Syntax error: expected `)`, got `' + bracket.payload + '`';
                        }
                        break;
                    case 'literal':
                        units.push(new Node(token.operation, [token.payload]));
                        break;
                    case 'name':
                        var indices = this.parseArguments(expr_list);
                        units.push(new Node(opRetrieve, [token.payload].concat(indices)));
                        break;
                    default:
                        expr_list.unshift(token);
                        exit_loop = true;
                        break;
                }
            }
            else {
                expr_list.unshift(token);
                break;
            }
            if (exit_loop) {
                break;
            }
        }
        drain(0, stack, units);
        if (units.length) return units[0];
        return null;
    };

    this.parseArguments = function(expr_list)
    {
        var args = [];
        if (expr_list.length > 0 && expr_list[0].token_type === '(') {
            expr_list.shift();
            while (expr_list.length > 0) {
                args.push(this.parseExpression(expr_list));
                var token = expr_list.shift();
                if (token.token_type === ')') break;
                if (token.token_type !== ',') {
                    throw 'Syntax error: expected `,`, got `'+token.payload+'`';
                }
            }
            if (token.token_type !== ')') {
                throw 'Syntax error: missing `)`';
            }
        }
        return args;
    }

    this.parseLine = function(basicode)
    // parse a line of BASICODE
    {
        var statements = []
        while (basicode.length > 0) {
            var token = basicode.shift();
            // check for empty statement
            if (token.token_type === ':') continue;
            if (token.token_type === '\n') break;
            // TODO: optional LET
            // parse arguments in statement-specific way
            var args = token.parseStatement(this, basicode);
            // statment must have access to interpreter state,   so state is first argument
            args.unshift(state);
            statements.push(new Node(token.operation, args));
            // parse separator
            if (!basicode.length) break;
            var sep = basicode.shift();
            if (sep.token_type === '\n') break;
            if (sep.token_type !== ':') {
                throw 'Syntax error: expected `:`, got `' + sep.payload + '`';
            }
        }
        // create a sequence node
        return new Node(function(){}, statements);
    }

    this.parseProgram = function(basicode)
    // parse a BASICODE program
    {
        if (!basicode.length) return null;
        var lines = [];
        var line_numbers = {};
        // BASICODE only allows line numbers 1000 and up
        var last_number = 999;
        while (basicode.length > 0) {
            var line_number = basicode.shift();
            console.log(line_number);
            if (line_number.token_type != 'literal') {
                throw 'Illegal direct: line must start with a line number';
            }
            if (line_number.payload <= last_number) {
                throw 'Line numbers must be 1000 or greater and increase monotonically';
            }
            // keep track of line numbers
            line_numbers[line_number.payload] = lines.length;
            lines.push(this.parseLine(basicode));
            last_number = line_number.payload;
        }
        // create a sequence node
        return new Node(function(){}, lines);
        // TODO: we should return a Program object that includes data, line numbers, AST
    }

};

///////////////////////////////////////////////////////////////////////////////
// statements

function stLet(state, value, name, indices)
// LET
{
    return state.variables.assign(value, name, indices);
}

function stPrint(state)
// PRINT
{
    var values = [].slice.call(arguments, 1);
    //TODO: TAB
    for (var i=0; i < values.length; ++i) {
        if (typeof values[i] === 'string') {
            state.output.write(values[i]);
        }
        else if (values[i] < 0) {
            state.output.write(values[i].toString(10) + ' ');
        }
        else {
            state.output.write(' ' + values[i].toString(10) + ' ');
        }
    }
}

function stRestore(state)
// RESTORE
{
    state.data.restore();
}

function stRead(state)
// READ
{
    var vars = [].slice.call(arguments, 1);
    for (var i=0; i < vars.length; ++i) {
        var name = vars[i][0];
        var indices = vars[i][1];
        var value = state.data.read()
        state.variables.assign(value, name, indices);
    }
}


///////////////////////////////////////////////////////////////////////////////
// interface

function Interface(output_element, input_element)
{

    this.clear = function() {
        output_element.innerHTML = '';
    };

    this.write = function(output) {
        output = output.toString();
        output_element.innerHTML += output.replace('<', '&lt;').replace('>', '&gt;');
    };

    this.read = function() {
        return input_element.value;
    }
}


function BasicodeApp()
{
    // interface setup
    this.iface = new Interface(
        document.getElementById("output"),
        document.getElementById("input"));

    // interpreter setup
    this.state = {
        'data': new Data(),
        'variables': new Variables(),
        'output': this.iface,
    }
    this.state.parser = new Parser(this.state);
}
