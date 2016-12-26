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

///////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////
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
    'DIM': newStatementToken('DIM', parseRead, stDim),
    'EXP': newFunctionToken('EXP', Math.exp),
    'FOR': newStatementToken('FOR', parseFor, stFor),
    'GOSUB': newStatementToken('GOSUB', parseGoto, stGosub),
    'GOTO': newStatementToken('GOTO', parseGoto, stGoto),
    'IF': newStatementToken('IF', parseIf, stIf),
    'INPUT': newStatementToken('INPUT'),
    'INT': newFunctionToken('INT', Math.trunc),
    'LEFT$': newFunctionToken('LEFT$', function fnLeft(x, n) { return x.slice(0, n); }),
    'LEN': newFunctionToken('LEN', function fnLen(x, n) { return x.length; }),
    'LET': newStatementToken('LET', parseLet, stLet),
    'LOG': newFunctionToken('LOG', Math.log),
    'MID$': newFunctionToken('MID$', function fnMid(x, start, n) { return x.slice(start, n); }),
    'NEXT': newStatementToken('NEXT', parseNext, stNext),
    'NOT': newOperatorToken('NOT', 1, 6, function opNot(x) { return (!x); }),
    'ON': newStatementToken('ON', parseOn, stOn),
    'OR': newOperatorToken('OR', 2, 4, function opOr(x, y) { return (x || y); }),
    'PRINT': newStatementToken('PRINT', parsePrint, stPrint),
    'READ': newStatementToken('READ', parseRead, stRead),
    'REM': newStatementToken('REM', parseRem, function(){}),
    'RESTORE': newStatementToken('RESTORE', function(){ return []; }, stRestore),
    'RETURN': newStatementToken('RETURN', function(){ return []; }, stReturn),
    'RIGHT$': newFunctionToken('RIGHT$', function fnRight(x, n) { return x.slice(-n); }),
    'SGN': newFunctionToken('SGN', Math.sign),
    'SIN': newFunctionToken('SIN', Math.sin),
    'SQR': newFunctionToken('SQR', Math.sqrt),
    // TAB only has an effect at the top level in a PRINT statement
    // TODO: ensure we throw an error if called elsewhere -- string/number type checks would do the trick
    // or move TAB parsing to print parser (less hacky)
    'TAB': newFunctionToken('TAB', function(x) { return { 'tab': x }; }),
    'TAN': newFunctionToken('TAN', Math.tan),
    'VAL': newFunctionToken('VAL', function(x) { return new Lexer(x).readValue(); }),
    'THEN': newStatementToken('THEN'),
    'STEP': newStatementToken('STEP'),
    'TO': newStatementToken('TO'),
}

// THEN, STEP, TO are reserved words but not independent statements
// additional reserved words: AS, AT, FN, GR, IF, LN, PI, ST, TI, TI$


///////////////////////////////////////////////////////////////////////////////
// lexer


function Lexer(expr_string)
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

    function readString()
    // read a double-quoted string literal
    {
        var start_pos = pos;
        // skip start and closing quotes
        for (++pos; (pos < expr_string.length && expr_string[pos] !== '"'  && expr_string[pos] !== '\n'); ++pos);
        if (pos === expr_string.length || expr_string[pos] !== '"') {
            throw 'Syntax error: no closing `"`';
        }
        return expr_string.slice(start_pos+1, pos);
    }

    function readComment()
    // read a comment until end of line
    {
        // skip single space after REM, if any
        var start_pos = ++pos;
        for (++pos; (pos < expr_string.length && expr_string[pos] !== '\n'); ++pos);
        --pos;
        if (expr_string[start_pos] === ' ') ++start_pos;
        return expr_string.slice(start_pos, pos+1);
    }

    function readInteger()
    // read an unsigned integer literal (i.e. a string of numbers)
    {
        var start_pos = pos;
        for (; pos < expr_string.length-1; ++pos){
            if (!isNumberChar(expr_string[pos+1])) break;
        }
        return expr_string.slice(start_pos, pos+1);
    }

    function readName()
    // read a name (variable or keyword)
    {
        var start_pos = pos;
        for (; pos < expr_string.length-1; ++pos){
            // the name can end in at most one $
            if (expr_string[pos+1] === '$') {
                ++pos;
                break;
            }
            if (expr_string.slice(start_pos, pos+1).toUpperCase() in KEYWORDS) {
                // names can not start with a keyword
                break;
            }
            if (!isAlphaChar(expr_string[pos+1]) && !isNumberChar(expr_string[pos+1])) break;
        }
        return expr_string.slice(start_pos, pos+1).toUpperCase();
    }

    this.readValue = function()
    {
        // for VAL(), we should also accept a - here
        var sign = '';
        var mantissa = 0;
        var decimal = 0;
        var exponent = 0;
        if (expr_string[pos] === '-') {
            sign = '-';
            ++pos;
        }
        var char = expr_string[pos];
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
            if (pos+1 < expr_string.length &&
                    (isNumberChar(expr_string[pos+1]) || expr_string[pos+1] === '-' || expr_string[pos+1] === '+')) {
                ++pos;
                if (expr_string[pos+1] === '-' || expr_string[pos+1] === '+') {
                    ++pos;
                    exponent = expr_string[pos+1] + readInteger();
                }
                else {
                    exponent = readInteger();
                }
            }
        }
        return parseFloat(sign + mantissa + '.' + decimal + 'e' + exponent);
    }

    this.tokenise = function()
    {
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
            else if (isNumberChar(char) || char === '.') {
                expr_list.push(new tokenLiteral(this.readValue()));
            }
            else if (isAlphaChar(char)) {
                var name = readName();
                if (name in KEYWORDS) {
                    // call function that calls new on a constructor
                    expr_list.push(KEYWORDS[name]());
                    if (name === 'REM') {
                        expr_list.push(new tokenLiteral(readComment()));
                    }
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
}


function tokenise(expr_string)
// convenience function
{
    return new Lexer(expr_string).tokenise()
}

///////////////////////////////////////////////////////////////////////////////
// AST

function Node(func, node_args)
{
    this.func = func;
    this.args = node_args;
    this.pos = 0;

    // traverse AST to evaluate this node and all its subnodes
    this.evaluate = function()
    {
        var args = this.args.slice()
        for (this.pos = 0; this.pos < args.length; ++this.pos) {
            if (this.args[this.pos] instanceof Node) {
                args[this.pos] = this.args[this.pos].evaluate();
            }
        }
        // call the function with the array supplied as arguments
        return this.func.apply(this, args);
    };

    this.end = function()
    // skip to end
    // only expected to be called at root or sequence node
    // only makes sense when this.func is a no-op
    {
        this.pos = this.args.length;
        // traverse the tree to ensure execution stops at deeper levels too
        for (var i = 0; i < this.args.length; ++i) {
            if (this.args[i] instanceof Node) this.args[i].end();
        }
    }

    this.jump = function(target)
    // jump instruction
    // only expected to be called at root node
    {
        this.end();
        this.pos = target-1;
    }

    this.skip = function(target)
    // skip to next line
    // only expected to be called at root node
    {
        var pos = this.pos;
        this.end();
        this.pos = pos;
    }
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
    return [value, name.payload].concat(indices);
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
// parse READ or DIM statement
{
    // index list evaluation operation
    function evalIndex() { return [].slice.call(arguments); }

    var names = [];
    while (expr_list.length > 0) {
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw 'Syntax error: expected variable name, got `' + name.payload + '`';
        }
        var indices = parser.parseArguments(expr_list);
        names.push([name.payload, new Node(evalIndex, indices)])
        if (!expr_list.length) break;
        if (expr_list[0].payload !== ',') break;
        expr_list.shift();
    }
    return names;
}

function parseRem(parser, expr_list)
// parse REM
{
    var rem = expr_list.shift();
    if (rem.token_type !== 'literal') {
        throw 'Syntax error: expected literal';
    }
    // BASICODE standard: title in REM on line 1000
    // description and copyrights in REMS on lines 30000 onwards
    if (parser.current_line === 1000) {
        parser.title = rem.payload;
    }
    else if (parser.current_line >= 30000) {
        parser.description += rem.payload + '\n';
    }
    return [];
}

function parseGoto(parser, expr_list)
// parse GOTO
{
    var line_number = expr_list.shift();
    if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
        throw 'Syntax error: expected line number';
    }
    return [line_number.payload];
}

function parseIf(parser, expr_list)
// parse IF
{
    var condition = parser.parseExpression(expr_list);
    var then = expr_list.shift()
    if (then.token_type !== 'statement' || then.payload !== 'THEN') {
        throw 'Syntax error: expected `THEN`';
    }
    // supply a GOTO if jump target given after THEN
    var jump = expr_list[0]
    if (jump.token_type === 'literal') {
        expr_list.unshift(KEYWORDS['GOTO']());
    }
    // supply a : so the parser can continue as normal
    expr_list.unshift(new tokenSeparator(':'));
    // rest of line is being parsed as normal, but skipped on execution if condition is false
    return [condition];
}

function parseOn(parser, expr_list)
// parse ON jumps
{
    var condition = parser.parseExpression(expr_list);
    var jump = expr_list.shift();
    if (jump.token_type !== 'statement' || (jump.payload !== 'GOTO' && jump.payload !== 'GOSUB')) {
        throw 'Syntax error: expected `GOTO` or `GOSUB`';
    }
    var args = [condition, jump.operation]
    while (expr_list.length) {
        var line_number = expr_list.shift();
        if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
            throw 'Syntax error: expected line number';
        }
        args.push(line_number.payload);
        var sep = expr_list.shift();
        if (sep.token_type !== ',') {
            expr_list.unshift(sep);
            break;
        }
    }
    return args;
}

function parseFor(parser, expr_list)
// parse FOR
{
    var loop_variable = expr_list.shift();
    if (loop_variable.token_type !== 'name' || loop_variable.payload.slice(-1) === '$') {
        throw 'Syntax error: expected numerical variable name';
    }
    var equals = expr_list.shift();
    if (equals.token_type !== 'operator' || equals.payload !== '=') {
        throw 'Syntax error: expected `=`, got `'+equals.payload+'`';
    }
    var start = parser.parseExpression(expr_list);
    var to = expr_list.shift();
    if (to.token_type !== 'statement' || to.payload !== 'TO') {
        throw 'Syntax error: expected `TO`, got `'+to+'`';
    }
    var stop = parser.parseExpression(expr_list);
    var step = expr_list.shift();
    if (step.token_type !== 'statement' || step.payload !== 'STEP') {
        expr_list.unshift(step);
        step = 1;
    }
    else {
        step = parser.parseExpression(expr_list);
    }
    // return payload: do not retrieve the variable, just check its name
    return [loop_variable.payload, start, stop, step];
}

function parseNext(parser, expr_list)
// parse NEXT
{
    // variable is mandatory; only one variable allowed
    var loop_variable = expr_list.shift();
    if (loop_variable.token_type !== 'name' || loop_variable.payload.slice(-1) === '$') {
        throw 'Syntax error: expected numerical variable name';
    }
    // return payload: do not retrieve the variable, just check its name
    return [loop_variable.payload]
}


function Parser(iface)
{
    // data fields for access by statement parsers
    // which need to be stored in KEYWORDS but also need to access this state
    // (perhaps better to move into Parser and use a separate lookup table)

    // interpreter setup
    var state = {
        'data': new Data(),
        'variables': new Variables(),
        'line_numbers': {},
        'output': iface,
    }

    // data is stored upon parsing, not evaluation
    this.data = state.data;
    // program name and description can be extracted from REMs
    this.line_numbers = state.line_numbers;
    this.current_line = 999;
    this.title = '';
    this.description = '';

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
            // optional LET
            if (token.token_type === 'name') {
                basicode.unshift(token);
                token = KEYWORDS['LET']();
            }
            // parse arguments in statement-specific way
            var args = token.parseStatement(this, basicode);
            // statement must have access to interpreter state, so state is first argument
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
        // BASICODE only allows line numbers 1000 and up
        this.current_line = 999;
        while (basicode.length > 0) {
            var line_number = basicode.shift();
            console.log('parsing '+line_number.payload);
            if (line_number.token_type != 'literal') {
                throw 'Illegal direct: line must start with a line number';
            }
            if (line_number.payload <= this.current_line) {
                throw 'Line numbers must be 1000 or greater and increase monotonically';
            }
            this.current_line = line_number.payload;
            // keep track of line numbers
            this.line_numbers[this.current_line] = lines.length;
            lines.push(this.parseLine(basicode));
        }
        state.tree = new Node(function(){}, lines);
        state.title = this.title;
        state.description = this.description;
        // GOSUB-RETURN stack for execution
        state.sub_stack = [];
        state.for_stack = [];
        return state;
    }

};

///////////////////////////////////////////////////////////////////////////////
// statements

function stLet(state, value, name)
// LET
{
    var indices = [].slice.call(arguments, 3);
    return state.variables.assign(value, name, indices);
}

function stDim(state)
// DIM
{
    var vars = [].slice.call(arguments, 1);
    for (var i=0; i < vars.length; ++i) {
        var name = vars[i][0];
        var indices = vars[i][1].evaluate();
        state.variables.allocate(name, indices);
    }
}

function stPrint(state)
// PRINT
{
    var values = [].slice.call(arguments, 1);
    for (var i=0; i < values.length; ++i) {
        if (typeof values[i] === 'object') {
            // TAB object
            state.output.setColumn(values[i].tab);
        }
        else if (typeof values[i] === 'string') {
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
        var indices = vars[i][1].evaluate();
        var value = state.data.read()
        state.variables.assign(value, name, indices);
    }
}

function stGoto(state, line_number)
// GOTO
{
    // GOTO 20 is a BASICODE fixture
    if (line_number === 20) return;
    // GOTO 950 means END
    if (line_number === 950) {
        state.tree.end();
        return;
    }
    // other line numbers must be defined
    if (!(line_number in state.line_numbers)) {
        throw 'Undefined line number ' + line_number;
    }
    var target = state.line_numbers[line_number];
    state.tree.jump(target);
}

function stGosub(state, line_number)
// GOSUB
{
    if (!(line_number in state.line_numbers)) {
        throw 'Undefined line number';
    }
    var target = state.line_numbers[line_number];
    state.sub_stack.push(state.tree.pos+1);
    state.tree.jump(target);
}

function stReturn(state)
// RETURN
{
    if (!state.sub_stack.length) {
        throw 'RETURN without GOSUB';
    }
    var target = state.sub_stack.pop();
    state.tree.jump(target);
}

function stIf(state, condition)
// IF .. THEN
{
    if (typeof condition !== 'number' && typeof condition !== 'boolean') {
        throw 'Type mismatch: expected numerical expression';
    }
    if (!condition) state.tree.skip();
}

function stOn(state, condition, jump_operation)
// ON.. GOTO
{
    var targets = [].slice.call(arguments, 3);
    if (typeof condition !== 'number' && typeof condition !== 'boolean') {
        throw 'Type mismatch: expected numerical expression';
    }
    if (condition > 0 && condition <= targets.length) {
        var line_number = targets[condition-1];
        jump_operation(state, line_number);
    }
}

function stFor(state, loop_var, start, stop, step)
// FOR .. TO .. STEP
{
    state.variables.assign(start, loop_var, []);
    // the FOR loop is executed at least once in BASICODE
    // unlike e.g. in GW-BASIC! so no jumping to NEXT here.

    // FIXME: this will not allow jumps inside one line as in FOR .. : NEXT
    // we should flatten the tree to allow that (i.e. no separate nodes per line)

    state.for_stack.push({'loop_var': loop_var, 'stop': stop, 'step': step, 'pos': state.tree.pos});
}

function stNext(state, loop_var)
{
    if (!state.for_stack.length) {
        throw '`NEXT` without `FOR`';
    }
    var loop_record = state.for_stack.slice(-1)[0];
    if (loop_record.loop_var !== loop_var) {
        throw '`FOR` without `NEXT`: expected `NEXT '+loop_record.loop_var+'`, got `NEXT '+loop_var+'`';
    }
    // increment counter
    var counter = state.variables.retrieve(loop_var, []) + loop_record.step;
    state.variables.assign(counter, loop_var, []);
    // break condition
    if (counter > loop_record.stop) {
        state.for_stack.pop();
    }
    else {
        state.tree.jump(loop_record.pos+1);
    }
}


///////////////////////////////////////////////////////////////////////////////
// interface

function Interface(output_element, input_element)
{
    this.width = 40;
    this.height = 24;

    this.clear = function() {
        output_element.innerHTML = '';
        this.row = 0;
        this.col = 0;
    }

    function writeRaw(output) {
        output_element.innerHTML += output.replace('<', '&lt;').replace('>', '&gt;');
    }

    this.write = function(output) {
        // TODO: handle line longer than row length
        var lines = output.toString().replace('\r\n', '\n').replace('\r', '\n').split('\n');
        var i=1;
        writeRaw(lines[0]);
        for (; i < lines.length; ++i) {
            ++this.row;
            this.col = 0;
            writeRaw('\n');
            writeRaw(lines[i]);
        }
        this.col = lines[i-1].length;
    }

    this.setColumn = function(col)
    // TODO: currently this does not work if col < current column
    {
        if (this.col < col) {
            writeRaw(' '.repeat(col - this.col));
            this.col = col;
        }
    }

    this.read = function() {
        return input_element.value;
    }

    this.clear();
}


function BasicodeApp()
{
    // interface setup
    this.iface = new Interface(
        document.getElementById("output"),
        document.getElementById("input"));

    this.parser = new Parser(this.iface);
}

// TODO:
// - working screen
// - working keyboard
// - BASICODE subroutines
// - type checks
// - INPUT, FOR .. NEXT

// some potential optimisations, if needed:
// - leave empty statements (REM, DATA) out of AST
// - simplify leaf nodes to { return payload } to avoid type test on each Node
// - pre-calculate jump targets (second pass of parser?)
