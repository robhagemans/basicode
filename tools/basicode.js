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
function newStatementToken(keyword, operation) {
    return (function() {
        return (new function tokenStatement() {
            this.token_type = 'statement';
            this.payload = keyword;
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
    'DATA': newStatementToken('DATA', function(){}),
    'DIM': newStatementToken('DIM', stDim),
    'EXP': newFunctionToken('EXP', Math.exp),
    'FOR': newStatementToken('FOR', stFor),
    'GOSUB': newStatementToken('GOSUB', stGosub),
    'GOTO': newStatementToken('GOTO', stGoto),
    // IF is handled by a special node, not a statement operation
    'IF': newStatementToken('IF', null),
    'INPUT': newStatementToken('INPUT', stInput),
    'INT': newFunctionToken('INT', Math.trunc),
    'LEFT$': newFunctionToken('LEFT$', function fnLeft(x, n) { return x.slice(0, n); }),
    'LEN': newFunctionToken('LEN', function fnLen(x, n) { return x.length; }),
    'LET': newStatementToken('LET', stLet),
    'LOG': newFunctionToken('LOG', Math.log),
    'MID$': newFunctionToken('MID$', function fnMid(x, start, n) { return x.slice(start, n); }),
    'NEXT': newStatementToken('NEXT', stNext),
    'NOT': newOperatorToken('NOT', 1, 6, function opNot(x) { return (!x); }),
    'ON': newStatementToken('ON', stOn),
    'OR': newOperatorToken('OR', 2, 4, function opOr(x, y) { return (x || y); }),
    'PRINT': newStatementToken('PRINT', stPrint),
    'READ': newStatementToken('READ', stRead),
    'REM': newStatementToken('REM', function(){}),
    'RESTORE': newStatementToken('RESTORE', stRestore),
    'RETURN': newStatementToken('RETURN', stReturn),
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
    'THEN': newStatementToken('THEN', null),
    'STEP': newStatementToken('STEP', null),
    'TO': newStatementToken('TO', null),
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

    // traverse AST to evaluate this node and all its subnodes
    this.evaluate = function()
    {
        var args = this.args.slice()
        for (var pos = 0; pos < args.length; ++pos) {
            if (this.args[pos] instanceof Node) {
                args[pos] = this.args[pos].evaluate();
            }
        }
        // call the function with the array supplied as arguments
        return this.func.apply(this, args);
    };

    // false: no further evaluation to do
    this.step = function()
    {
        this.evaluate();
        return false;
    }

    this.init = function() {}

    // end calls do not affect expression nodes
    this.end = function() {}
}

function Sequence(node_args)
{
    this.args = node_args;

    this.init = function()
    {
        this.pos = 0;
        if (this.args.length) this.args[0].init()
    };

    this.step = function()
    {
        if (this.args && this.pos < this.args.length) {
            if (!this.args[this.pos].step()) {
                ++this.pos;
                if (this.pos < this.args.length) this.args[this.pos].init()
            }
            return true;
        }
        return false;
    }

    this.end = function()
    // skip to end
    {
        this.pos = this.args.length;
    }

    this.jump = function(target)
    // jump instruction
    // only expected to be called at root node
    {
        this.pos = target;
        this.args[this.pos].init();
    }
}


function WaitNode(wait_condition, node)
// execute node after waiting for condition to become true
// unlike Conditional, the condition is evaluated every step
// e.g. wait for a keypress
{
    this.wait_func = wait_condition;
    this.node = node;

    this.init = function() {}

    this.step = function()
    {
        if (this.wait_func()) {
            return this.node.step();
        }
        return true;
    }

    this.end = function()
    {
        this.sequence.end();
    }

}


function Conditional(condition, node)
{
    this.condition = condition;
    this.sequence = node;

    var evaluated_condition = null;

    this.init = function()
    {
        evaluated_condition = this.condition.evaluate();
        if (evaluated_condition) {
            this.sequence.init();
        }
    }

    this.step = function()
    {
        if (evaluated_condition === null) {
            throw 'Uninitialised condition';
        }
        if (evaluated_condition) {
            return this.sequence.step();
        }
    }

    this.end = function()
    {
        this.sequence.end();
    }
}

// inherit Sequence prototype
Conditional.prototype = Object.create(Sequence.prototype);
Conditional.prototype.name = "Conditional";
Conditional.prototype.constructor = Conditional;


//////////////////////////////////////////////////////////////////////
// parser

function Parser()
{
    // program object
    var state = {
        'title': '',
        'description': '',
        'data': new Data(),
        'variables': new Variables(),
        'sub_stack': [],
        'for_stack': [],
        'line_numbers': {},
        'tree': null,
        'output': null,
        'input': null,
    }

    var current_line = 999;

    function opRetrieve(name)
    //  retrieve a variable from the Variables object in state
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
            var node = PARSERS[token.payload](this, basicode, token)
            if (node) statements.push(node);
            // parse separator
            if (!basicode.length) break;
            var sep = basicode.shift();
            if (sep.token_type === '\n') break;
            if (sep.token_type !== ':') {
                throw 'Syntax error: expected `:`, got `' + sep.payload + '`';
            }
        }
        // create a sequence node
        return new Sequence(statements);
    }

    this.parseProgram = function(basicode)
    // parse a BASICODE program
    {
        if (!basicode.length) return null;
        var lines = [];
        // BASICODE only allows line numbers 1000 and up
        current_line = 999;
        while (basicode.length > 0) {
            var line_number = basicode.shift();
            if (line_number.token_type != 'literal') {
                throw 'Illegal direct: line must start with a line number';
            }
            if (line_number.payload <= current_line) {
                throw 'Line numbers must be 1000 or greater and increase monotonically';
            }
            current_line = line_number.payload;
            // keep track of line numbers
            state.line_numbers[current_line] = lines.length-1;
            // keep tree flat: no branches for lines
            var statements = this.parseLine(basicode).args;
            lines = lines.concat(statements);
        }
        state.tree = new Sequence(lines);
        return state;
    }

    ///////////////////////////////////////////////////////////////////////////
    // statement syntax

    const PARSERS = {
        'DATA': parseData,
        'DIM': parseRead,
        'FOR': parseFor,
        'GOSUB': parseGosub,
        'GOTO': parseGoto,
        'IF': parseIf,
        'INPUT': parseInput,
        'LET': parseLet,
        'NEXT': parseNext,
        'ON': parseOn,
        'PRINT': parsePrint,
        'READ': parseRead,
        'REM': parseRem,
        'RESTORE': parseNone,
        'RETURN': parseNone,
    }

    function parseLet(parser, expr_list, token)
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
        // statement must have access to interpreter state, so state is first argument
        return new Node(token.operation, [state, value, name.payload].concat(indices));
    }

    function parsePrint(parser, expr_list, token)
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
        return new Node(token.operation, [state].concat(exprs));
    }

    function parseData(parser, expr_list, token)
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
        state.data.store(values);
        return null;
    }

    function parseRead(parser, expr_list, token)
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
        return new Node(token.operation, [state].concat(names));
    }

    function parseRem(parser, expr_list, token)
    // parse REM
    {
        var rem = expr_list.shift();
        if (rem.token_type !== 'literal') {
            throw 'Syntax error: expected literal';
        }
        // BASICODE standard: title in REM on line 1000
        // description and copyrights in REMS on lines 30000 onwards
        if (current_line === 1000) {
            state.title = rem.payload;
        }
        else if (current_line >= 30000) {
            state.description += rem.payload + '\n';
        }
        return null;
    }

    function parseGoto(parser, expr_list, token)
    // parse GOTO
    {
        var line_number = expr_list.shift();
        if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
            throw 'Syntax error: expected line number, got `'+line_number.payload+'`';
        }
        // GOTO 20 is a BASICODE fixture, no-op
        if (line_number.payload === 20) return null;
        // GOTO 950 means END
        else if (line_number.payload  === 950) return new Node(jumpEnd, [state]);
        else if (line_number.payload < 1000) {
            throw 'Unknown BASICODE jump `GOTO '+line_number.payload+'`';
        }
        // other line numbers are resolved at run time
        return new Node(token.operation, [state, line_number.payload]);
    }

    function parseGosub(parser, expr_list, token)
    // parse GOSUB
    {
        var line_number = expr_list.shift();
        if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
            throw 'Syntax error: expected line number, got `'+line_number.payload+'`';
        }
        else if (line_number.payload in SUBS) {
            // attach BASICODE subroutine node
            return SUBS[line_number.payload]();
        }
        else if (line_number.payload < 1000) {
            throw 'Unknown BASICODE subroutine `GOSUB '+line_number.payload+'`';
        }
        return new Node(token.operation, [state, line_number.payload]);
    }

    const SUBS = {
        100: function() {return new Node(subClearScreen, [state])},
        110: function() {return new Node(subSetPos, [state])},
        120: function() {return new Node(subGetPos, [state])},
        150: function() {return new Node(subWriteBold, [state])},
        200: function() {return new Node(subReadKey, [state])},
        210: function() {return new WaitNode(function waitForKey() { return state.input.keyPressed(); }, new Node(subReadKey, [state])); },
        220: function() {return new Node(subReadChar, [state])},
        //250: subBeep,
        260: function() {return new Node(subRandom, [state])},
        270: function() {return new Node(subFree, [state])},
    }

    function parseIf(parser, expr_list, token)
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
        //expr_list.unshift(new tokenSeparator(':'));
        // parse rest of line and place into conditional node
        var sequence = parser.parseLine(expr_list);
        // give back the separator so the next line parses correctly
        expr_list.unshift(new tokenSeparator('\n'));
        return new Conditional(condition, sequence);
    }

    function parseOn(parser, expr_list, token)
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
        return new Node(token.operation, [state].concat(args));
    }

    function parseFor(parser, expr_list, token)
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
        // return payload: do not retrieve the variable, just get its name
        return new Node(token.operation, [state, loop_variable.payload, start, stop, step]);
    }

    function parseNext(parser, expr_list, token)
    // parse NEXT
    {
        // variable is mandatory; only one variable allowed
        var loop_variable = expr_list.shift();
        if (loop_variable.token_type !== 'name' || loop_variable.payload.slice(-1) === '$') {
            throw 'Syntax error: expected numerical variable name, got `' + loop_variable.payload + '`';
        }
        // return payload: do not retrieve the variable, just get its name
        return new Node(token.operation, [state, loop_variable.payload]);
    }

    function parseInput(parser, expr_list, token)
    // parse INPUT
    {
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw 'Syntax error: expected variable name, got `' + name.payload + '`';
        }
        var indices = parser.parseArguments(expr_list);
        // wait for ENTER kepress before engaging
        var wait_func = function() { return state.input.keyPressed('\r'); }
        // return payload: do not retrieve the variable, just get its name
        var node = new Node(token.operation, [state, name.payload].concat(indices))
        return new WaitNode(wait_func, node);
    }

    function parseNone(parser, expr_list, token)
    // parse RETURN, RESTORE
    {
        return new Node(token.operation, [state]);
    }

};


///////////////////////////////////////////////////////////////////////////////
// statements

function stLet(state, value, name)
// LET
{
    var indices = [].slice.call(arguments, 3);
    state.variables.assign(value, name, indices);
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
        throw 'Undefined line number ' + line_number;
    }
    var target = state.line_numbers[line_number];
    state.sub_stack.push(state.tree.pos);
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
    state.for_stack.push({'loop_var': loop_var, 'stop': stop, 'step': step, 'pos': state.tree.pos});
}

function stNext(state, loop_var)
// NEXT
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
        state.tree.jump(loop_record.pos);
    }
}

function stInput(state, name)
// INPUT
{
    var indices = [].slice.call(arguments, 2);
    var value = state.input.readLine();
    if (name.slice(-1) !== '$') {
        // convert string to number
        // note that this will currently simply return 0 if it can't convert
        // no 'Redo from start'
        value = new Lexer(value).readValue();
    }
    state.variables.assign(value, name, indices);
}

///////////////////////////////////////////////////////////////////////////////
// BASICODE subroutines and jumps

function jumpEnd(state)
// GOTO 950
{
    state.tree.end();
}

function subClearScreen(state)
// GOSUB 100
{
    state.output.clear();
}

function subSetPos(state)
// GOSUB 110
{
    state.output.setColumn(state.variables.retrieve('HO', []));
    state.output.setRow(state.variables.retrieve('VE', []));
}

function subGetPos(state)
// GOSUB 120
{
    state.variables.assign(state.output.col, 'HO', []);
    state.variables.assign(state.output.row, 'VE', []);
}

function subWriteBold(state)
// GOSUB 150
{
    var text = '   ' + state.variables.retrieve('SR$', []) + '   ';
    state.output.write(' ');
    state.output.setColour('white', 'black');
    state.output.write(text);
    state.output.setColour('black', 'white');
    state.output.write(' ');
}

function subReadKey(state)
// GOSUB 200, GOSUB 210 (after wait)
// TODO: arrow keys, function keys etc.
{
    var key = state.input.read(1);
    var keyval = 0;
    if (key) {
        keyval = key.toUpperCase().charCodeAt(0);
    }
    // only printable ASCII
    if (keyval<32 || keyval>126) {
        key = '';
        keyval = 0;
    }
    state.variables.assign(keyval, 'IN', []);
    state.variables.assign(key, 'IN$', []);
}

function subReadChar(state)
// GSOUB 220
{
    var col = state.variables.retrieve('HO', []);
    var row = state.variables.retrieve('VE', []);
    var ch = state.output.getScreenChar(row, col);
    state.variables.assign(ch.charCodeAt(0), 'IN', []);
}

function subRandom(state)
// GOSUB 260
{
    state.variables.assign(Math.random(), 'RV', []);
}

function subFree(state)
// GOSUB 270
{
    // theoretically, we should garbage-collect and return free memory
    // but let's just return some largeish (for BASICODE) number of bytes
    state.variables.assign(65536, 'FR', []);
}




///////////////////////////////////////////////////////////////////////////////
// interface

const INACTIVE_DELAY = 100;
const ACTIVE_DELAY = 5;


function Interface(iface_element)
{
    if (!iface_element) {
        var canvas = document.createElement('canvas');
        canvas.className = 'basicode';
        document.body.appendChild(canvas);
        iface_element = canvas;
    }
    var output_element = iface_element;
    var input_element = iface_element;

    // only allow one program to connect at a time
    this.busy = false;

    this.acquire = function(do_run)
    // acquire this interface, after the previous user released it
    {
        var iface = this;
        var wait_interval = window.setInterval(function() {
            if (!iface.busy) {
                window.clearInterval(wait_interval);
                console.log('start');
                do_run();
            };
        }, INACTIVE_DELAY);
    }

    this.release = function()
    // release this interface
    {
        this.busy = false;
    }

    ///////////////////////////////////////////////////////////////////////////
    // screen

    this.width = 40;
    this.height = 24;
    this.foreground = 'black';
    this.background = 'white';

    // resize the canvas to fit the font size
    var context = output_element.getContext('2d');
    var font_height = 24;
    context.font = font_height+'px monospace';
    var measures = context.measureText('M');
    var font_width = measures.width;
    output_element.width = measures.width*this.width;
    output_element.height = font_height*this.height;

    // set the context on the resized canvas
    context = output_element.getContext('2d');
    context.font = 'normal lighter '+font_height+'px monospace';

    this.clear = function() {
        context.fillStyle = this.background;
        context.fillRect(0, 0, output_element.width, output_element.height);
        this.row = 0;
        this.col = 0;
        this.content = (' '.repeat(this.width)+'\n').repeat(this.height).split('\n');
    }

    this.writeRaw = function(output)
    {
        if (this.row >= this.height) return;
        while (this.col + output.length > this.width) {
            var cut = this.width-this.col
            this.writeRaw(output.slice(0, cut));
            output = output.slice(cut);
            this.row += 1;
            this.col = 0;
        }
        context.fillStyle = this.background;
        context.fillRect(this.col*font_width, this.row*font_height,
            output.length*font_width, font_height);
        context.fillStyle = this.foreground;
        // 0.75 seems about the right baseline offset for Chrome & Firefox...
        context.fillText(output, this.col*font_width, (this.row+0.75)*font_height);
        // update content buffer
        this.content[this.row] = this.content[this.row].slice(0, this.col) + output + this.content[this.row].slice(this.col+output.length);
        this.col += output.length;
    }

    this.write = function(output)
    {
        var lines = output.toString().replace('\r\n', '\n').replace('\r', '\n').split('\n');
        var i=1;
        this.writeRaw(lines[0]);
        for (; i < lines.length; ++i) {
            ++this.row;
            this.col = 0;
            this.writeRaw(lines[i]);
        }
    }

    this.getScreenChar = function(row, col)
    {
        return this.content[row].slice(col, col+1);
    }

    this.setColour = function(foreground, background)
    {
        this.foreground = foreground;
        this.background = background;
    }

    this.setColumn = function(col)
    {
        this.col = col;
    }

    this.setRow = function(row)
    {
        this.row = row;
    }

    ///////////////////////////////////////////////////////////////////////////
    // keyboard

    // keyboard setup
    var keyboard_buffer = '';

    // make canvas element focussable to catch keypresses
    input_element.tabIndex = 1;
    input_element.focus();

    input_element.addEventListener('keypress', function(event) {
        keyboard_buffer += String.fromCharCode(event.keyCode);
        event.preventDefault();
        console.log('keypress ' + event.keyCode);
    });

    input_element.addEventListener('keydown', function(event) {
        // use this for backspace, function keys
        console.log('keydown ' + event.keyCode);
        // preventDefault will stop all keys from being caught by keypress, so use only for backspace and function keys to avoid browser actions
        //event.preventDefault();
    });

    this.keyPressed = function(key) {
        if (key !== undefined && key !== null) {
            return (keyboard_buffer.search(key) !== -1);
        }
        return keyboard_buffer.length > 0;
    }

    this.read = function(n)
    {
        var out = '';
        if (n === undefined) {
            out = keyboard_buffer;
            keyboard_buffer = '';
        }
        else {
            out = keyboard_buffer.slice(0, n);
            keyboard_buffer = keyboard_buffer.slice(n);
        }
        return out;
    }

    this.readLine = function()
    {
        var loc = -1;
        while (loc == -1) {
            loc = keyboard_buffer.search('\r')
        }
        var out = keyboard_buffer.slice(0, loc);
        keyboard_buffer = keyboard_buffer.slice(loc);
        return out;
    }

    this.clear();
}



function BasicodeApp()
{

    this.load = function(code)
    // load program, parse to AST, connect to output
    {
        this.program = new Parser().parseProgram(code);
    }

    this.run = function(iface)
    // execute the program
    {
        var prog = this.program;
        if (!prog) return;

        if (!(iface instanceof Interface)) {
            iface = new Interface();
        }

        prog.output = iface;
        prog.input = iface;

        // exit if nothing loaded
        if (prog === undefined || prog.tree === null) {
            return;
        }

        // wait until input/output becomes available, then run the program
        iface.acquire(function() {
            prog.tree.init();
            iface.busy = true;

            var run_interval = window.setInterval(function() {
                if (!prog.tree.step()) {
                    window.clearInterval(run_interval);
                    console.log('done');
                    iface.release();
                }
            }, ACTIVE_DELAY);
        });

    }
}


function launch() {
    console.log('launch');
    var scripts = document.getElementsByTagName("script");
    console.log(scripts);
    for(var i=0; i < scripts.length; ++i) {
        if (scripts[i].type == 'text/basicode') {
            var app = new BasicodeApp();
            // trim seems to be necessary to avoid an Illegal Direct, not sure why
            app.load(tokenise(scripts[i].innerHTML.trim()));
            app.run();
        }
    }
}

// a bit of magic to run launcher() after the document is complete
// so that it can access all the <script> tags
// http://stackoverflow.com/questions/807878/javascript-that-executes-after-page-load
function downloadJSAtOnload() {
    var element = document.createElement("script");
    element.innerHTML = 'launch();';
    document.body.appendChild(element);
}
if (window.addEventListener) {
    window.addEventListener("load", downloadJSAtOnload, false);
}
else if (window.attachEvent) {
    window.attachEvent("onload", downloadJSAtOnload);
}
else {
    window.onload = downloadJSAtOnload;
}


// TODO:
// - BASICODE subroutines
// - type checks
// - error handling
// - meta info: 32000+ is author info
// - sound, graphics, printer

// deployment: show meta-info after load
// drag&drop loading of local files (using the File API)
// <script src= or <object data= reading from URL (using XmlHttpRequest?)

// some potential optimisations, if needed:
// - simplify leaf nodes to { return payload } to avoid type test on each Node
// - pre-calculate jump targets (second pass of parser?)
