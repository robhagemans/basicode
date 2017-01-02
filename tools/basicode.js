"use strict";

///////////////////////////////////////////////////////////////////////////////
// BASICODE interpreter
// Copyright (c) 2016, 2017 Rob Hagemans
// Licensed under the GNU General Public Licence, version 3
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// For a similar interpreter see https://github.com/MarquisdeGeek/basicode
// which is (c) 2012 by Steven Goodwin and licensed under the GPL
//
// I'd like to acknowledge Steven's interpreter as a source of inspiration.
// However, this interpreter does not take code from his.


///////////////////////////////////////////////////////////////////////////////
// errors

function BasicError(message, detail, location)
{
    this.message = message;
    this.detail = detail;
    this.where = location;
}

BasicError.prototype = Object.create(Error.prototype);
BasicError.prototype.name = "BasicError";
BasicError.prototype.constructor = BasicError;


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
    '+': newOperatorToken('+', 2, 8, function opPlus(x, y) { return x + y; }),
    // - can be unary negation or binary subtraction
    '-': newOperatorToken('-', null, 8, function opMinus(x, y) { if (y === undefined) return -x; else return x - y; }),
    '=': newOperatorToken('=', 2, 7, function opEqual(x, y) { return (x === y); }),
    '>': newOperatorToken('>', 2, 7, function opGreaterThan(x, y) { return (x > y); }),
    '>=': newOperatorToken('>=', 2, 7, function opGreaterThanOrEqual(x, y) { return (x >= y); }),
    '<': newOperatorToken('<', 2, 7, function opLessThan(x, y) { return (x < y); }),
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
    'DEF': newStatementToken('DEF', function(){}),
    'DIM': newStatementToken('DIM', stDim),
    'EXP': newFunctionToken('EXP', Math.exp),
    'INPUT': newStatementToken('INPUT', stInput),
    'INT': newFunctionToken('INT', Math.trunc),
    'LEFT$': newFunctionToken('LEFT$', function fnLeft(x, n) { return x.slice(0, n); }),
    'LEN': newFunctionToken('LEN', function fnLen(x, n) { return x.length; }),
    'LET': newStatementToken('LET', stLet),
    'LOG': newFunctionToken('LOG', Math.log),
    'MID$': newFunctionToken('MID$', function fnMid(x, start, n) { return x.slice(start-1, start+n-1); }),
    'NOT': newOperatorToken('NOT', 1, 6, function opNot(x) { return (!x); }),
    'OR': newOperatorToken('OR', 2, 4, function opOr(x, y) { return (x || y); }),
    'PRINT': newStatementToken('PRINT', stPrint),
    'READ': newStatementToken('READ', stRead),
    'REM': newStatementToken('REM', function(){}),
    'RESTORE': newStatementToken('RESTORE', stRestore),
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
    // Flow statements are handled by a special node, not a statement operation
    'FOR': newStatementToken('FOR', null),
    'GOSUB': newStatementToken('GOSUB', null),
    'GOTO': newStatementToken('GOTO', null),
    'IF': newStatementToken('IF', null),
    'ON': newStatementToken('ON', null),
    'NEXT': newStatementToken('NEXT', null),
    'RETURN': newStatementToken('RETURN', null),
    'END': newStatementToken('END', null),
    'STOP': newStatementToken('STOP', null),
    'RUN':  newStatementToken('RUN', null),
    // non-statement keywords
    'THEN': newStatementToken('THEN', null),
    'STEP': newStatementToken('STEP', null),
    'TO': newStatementToken('TO', null),
    'FN': newStatementToken('FN', null),
}

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
        var output = expr_string.slice(start_pos+1, pos);
        if (expr_string[pos] === '\n') {
            console.log('String literal terminated by end-of-line');
            --pos;
        }
        return output;
    }

    function readComment()
    // read a comment until end of line
    {
        // skip single space after REM, if any
        var start_pos = ++pos;
        for (; (pos < expr_string.length && expr_string[pos] !== '\n'); ++pos);
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
                // we can't throw here in case there's subroutines<1000 attached
                expr_list.push(new tokenSeparator(char));
                console.log('Unexpected symbol `'+ char + '` during lexing');
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



function Literal(value)
// literal node holds a string or number value
// only for use in expressions, so no step() or next needed
{
    this.value = value;
    this.evaluate = function() { return this.value; }
}




function Node(func, node_args, state)
// used as expression or statement node
{
    this.func = func;
    this.args = node_args;
    this.next = null;
    this.state = state;

    // traverse AST to evaluate this node and all its subnodes
    this.evaluate = function()
    {
        // evaluate all arguments
        var args = this.args.map(function (x) { return x.evaluate(); });
        // call the function with the array supplied as arguments
        return this.func.apply(this.state, args);
    };

    this.step = function()
    {
        this.evaluate();
        return this.next;
    }
}


// flow nodes


function Label(label)
// label node: no-op but can be a jump target
{
    this.label = label;
    this.next = null;
    this.step = function() {
        return this.next;
    }
}


function End()
{
    this.next = null;
    this.step = function() { return null; }
}

function Run(state)
{
    this.next = null;

    this.step = function() {
        subClear(state);
        return state.tree;
    }
}

function Conditional(condition)
{
    this.condition = condition;
    this.branch = null;
    this.next = null;

    this.step = function()
    {
        if (this.condition.evaluate()) return this.branch;
        return this.next;
    }
}


//FIXME: need state ref
function Switch(condition, branches)
// ON node
{
    this.condition = condition;
    this.branches = branches;
    this.next = null;

    this.step = function()
    {
        var condition = this.condition.evaluate();
        if (typeof condition !== 'number' && typeof condition !== 'boolean') {
            throw new BasicError('Type mismatch', 'expected numerical expression, got `'+ condition+'`', state.current_line);
        }
        if (condition > 0 && condition <= this.branches.length) {
            return this.branches[condition-1];
        }
        else {
            return this.next;
        }
    }
}


function Jump(target, state, is_sub)
{
    this.target = target;
    this.next = null;

    this.step = function()
    {
        if (!(target in state.line_numbers)) {
            throw new error('Undefined line number in `GOTO ' + target + '`', state.current_line);
        }
        if (is_sub) state.sub_stack.push(this.next);
        return state.line_numbers[target];
    }
}

function Return(state)
// RETURN node
{
    this.step = function()
    {
        return state.sub_stack.pop();
    }
}

function Wait(wait_condition)
// execute node after waiting for condition to become true
// unlike Conditional, the condition is evaluated every step
// e.g. wait for a keypress

// TODO: can be replaced by a self-pointing Conditional Node?

{
    this.trigger = wait_condition;
    this.next = null;

    this.step = function()
    {
        if (this.trigger()) return this.next;
        return this;
    }
}


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
        'fns': new Functions(),
        'sub_stack': [],
        'line_numbers': {},
        'tree': null,
        'output': null,
        'input': null,
        'printer': null,
        'speaker': null,
        'timer': null,
        'current_line': 999,
    }
    state.clear = function()
    {
        this.variables.clear();
        this.data.restore();
        this.sub_stack = [];
        this.current_line = 999;
    }

    var current_line = 999;

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
            units.push(new Node(token.operation, args, state));
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
                    throw new BasicError('Syntax error', 'unexpected operator type', state.current_line);
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
                        units.push(new Node(token.operation, args, state));
                        break;
                    case '(':
                        // recursive call, gets a Node object containing AST
                        units.push(this.parseExpression(expr_list));
                        var bracket = expr_list.shift(token);
                        if (bracket.token_type !== ')') {
                            throw new BasicError('Syntax error', 'expected `)`, got `' + bracket.payload + '`', current_line);
                        }
                        break;
                    case 'literal':
                        units.push(new Literal(token.payload));
                        break;
                    case 'name':
                        var indices = this.parseArguments(expr_list);
                        units.push(new Node(opRetrieve, [new Literal(token.payload)].concat(indices), state));
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
                    throw  new BasicError('Syntax error', 'expected `,`, got `'+token.payload+'`', current_line);
                }
            }
            if (token.token_type !== ')') {
                throw new BasicError('Syntax error', 'missing `)`', current_line);
            }
        }
        return args;
    }

    this.parseLine = function(basicode, last)
    // parse a line of BASICODE
    {
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
            // statement parsers must take care of maintaining the linked list
            last = PARSERS[token.payload](this, basicode, token, last)
            // parse separator
            if (!basicode.length) break;
            var sep = basicode.shift();
            if (sep.token_type === '\n') break;
            if (sep.token_type !== ':') {
                throw new BasicError('Syntax error', 'expected `:`, got `' + sep.payload + '`', current_line);
            }
        }
        return last
    }

    this.parseLineNumber = function(basicode, last)
    {
        if (!basicode.length) return null;
        var token = basicode.shift();
        while (basicode.length) {
            // ignore empty lines
            while (token.token_type === '\n') token = basicode.shift();
            // we do need a line number at the start
            if (token.token_type != 'literal') {
                throw new BasicError('Syntax error', 'expected line number, got `'+line_number.payload+'`', current_line);
            }
            var line_number = token.payload;
            // ignore lines < 1000
            if (line_number >= 1000) break;
            while (token.token_type !== '\n') token = basicode.shift();
        }
        if (line_number <= current_line) {
            throw new BasicError('Syntax error', 'expected line number > `' + current_line+'`, got `'+ line_number + '`', current_line);
        }
        current_line = line_number;
        var label = new Label(line_number);
        state.line_numbers[line_number] = label;
        last.next = label;
        return label;
    }

    this.parseProgram = function(basicode)
    // parse a BASICODE program
    {
        state.tree = new Label('ROOT');
        var last = state.tree;
        while (basicode.length > 0) {
            var label = this.parseLineNumber(basicode, last);
            last = this.parseLine(basicode, label);
        }
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
        // NEXT is handled by FOR parser
        'NEXT': null,
        'ON': parseOn,
        'PRINT': parsePrint,
        'READ': parseRead,
        'REM': parseRem,
        'RESTORE': parseRestore,
        'RETURN': parseReturn,
        'END': parseEnd,
        'STOP': parseEnd,
        'RUN': parseRun,
        'DEF': parseDefFn,
    }

    function parseLet(parser, expr_list, token, last)
    // parse LET statement
    {
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw new BasicError('Syntax error', 'expected variable name, got `' + name.payload + '`', current_line);
        }
        var indices = parser.parseArguments(expr_list);
        var equals = expr_list.shift().payload;
        if (equals !== '=') throw new BasicError('Syntax error', 'expected `=`, got `'+equals+'`', current_line);
        var value = parser.parseExpression(expr_list);
        // statement must have access to interpreter state, so state is first argument
        last.next = new Node(token.operation, [value, new Literal(name.payload)].concat(indices), state);
        return last.next;
    }

    function parsePrint(parser, expr_list, token, last_node)
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
            exprs.push(new Node(function(){ return '\n'; }, [], state));
        }
        last_node.next = new Node(token.operation, exprs, state);
        return last_node.next;
    }

    function parseData(parser, expr_list, token, last)
    // parse DATA statement
    {
        var values = []
        while (expr_list.length > 0) {
            var value = expr_list.shift();
            // only literals allowed in DATA
            // we're not allowing empty DATA statements or repeated commas
            if (value === null || value.token_type != 'literal') {
                throw new BasicError('Syntax error', 'expected string or number literal, got `'+value.payload+'`', current_line);
            }
            values.push(value.payload);
            // parse separator (,)
            if (!expr_list.length) break;
            if (expr_list[0].payload !== ',') break;
            expr_list.shift();
        }
        // data is stored immediately upon parsing, DATA is then a no-op statement
        state.data.store(values);
        return last;
    }

    function parseRead(parser, expr_list, token, last)
    // parse READ or DIM statement
    {
        var pt = last;
        while (expr_list.length > 0) {
            var name = expr_list.shift();
            if (name.token_type != 'name') {
                throw new BasicError('Syntax error', 'expected variable name, got `' + name.payload + '`', current_line);
            }
            var indices = parser.parseArguments(expr_list);

            last.next = new Node(token.operation, [new Literal(name.payload)].concat(indices), state);
            last = last.next;

            if (!expr_list.length) break;
            if (expr_list[0].payload !== ',') break;
            expr_list.shift();
        }
        return last;
    }

    function parseRem(parser, expr_list, token, last)
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
        return last;
    }

    function parseGoto(parser, expr_list, token, last)
    // parse GOTO
    {
        var line_number = expr_list.shift();
        if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
            throw new BasicError('Syntax error', 'expected line number, got `'+line_number.payload+'`', current_line);
        }
        // GOTO 20 is a BASICODE fixture, clear and jump to 1010
        if (line_number.payload === 20) {
            last.next = new Node(subClear, [], state);
            last.next.next = new Jump(1010, state, false)
            return last.next.next;
        }
        // GOTO 950 means END
        else if (line_number.payload  === 950) return new End();
        else if (line_number.payload < 1000) {
            throw new BasicError('Unimplemented BASICODE', '`GOTO '+line_number.payload+'` not implemented', current_line);
        }
        // other line numbers are resolved at run time
        last.next = new Jump(line_number.payload, state, false);
        return last.next;
    }

    function parseGosub(parser, expr_list, token, last)
    // parse GOSUB
    {
        var line_number = expr_list.shift();
        if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
            throw new BasicError('Syntax error', 'expected line number, got `'+line_number.payload+'`', current_line);
        }
        else if (line_number.payload in SUBS) {
            // attach BASICODE subroutine node
            return SUBS[line_number.payload](last);
        }
        else if (line_number.payload < 1000) {
            throw new BasicError('Unimplemented BASICODE', '`GOSUB '+line_number.payload+'` not implemented', current_line);
        }
        last.next = new Jump(line_number.payload, state, true);
        return last.next;
    }

    const SUBS = {
        100: function(last) {last.next = new Node(subClearScreen, [], state); return last.next; },
        110: function(last) {last.next = new Node(subSetPos, [], state); return last.next; },
        120: function(last) {last.next = new Node(subGetPos, [], state); return last.next; },
        150: function(last) {last.next = new Node(subWriteBold, [], state); return last.next; },
        200: function(last) {last.next = new Node(subReadKey, [], state); return last.next; },
        210: function(last) {
            last.next = new Wait(function waitForKey() { return state.input.keyPressed(); });
            last.next.next = new Node(subReadKey, [], state);
            return last.next.next;
        },
        220: function(last) {last.next = new Node(subReadChar, [], state); return last.next; },
        250: function(last) {last.next = new Node(subBeep, [], state); return last.next; },
        260: function(last) {last.next = new Node(subRandom, [], state); return last.next; },
        270: function(last) {last.next = new Node(subFree, [], state); return last.next; },
        280: function(last) {last.next = new Node(subToggleBreak, [], state); return last.next; },
        300: function(last) {last.next = new Node(subNumberToString, [], state); return last.next; },
        310: function(last) {last.next = new Node(subNumberFormat, [], state); return last.next; },
        330: function(last) {last.next = new Node(subToUpperCase, [], state); return last.next; },
        350: function(last) {last.next = new Node(subLinePrint, [], state); return last.next; },
        360: function(last) {last.next = new Node(subLineFeed, [], state); return last.next; },
        400: function(last) {
            last.next = new Node(subTone, [], state);
            last.next.next = new Wait(function waitForTone() { return !state.speaker.isBusy(); });
            return last.next.next;
        },
        450: function(last) {
            last.next = new Node(subSetTimer, [], state);
            last.next.next = new Wait(function waitForKeyWithTimeout() { return (state.input.keyPressed() || state.timer.elapsed()); });
            last.next.next.next = new Node(subReadKeyGetTimer, [], state);
            return last.next.next.next;
        },
        500: function(last) {last.next = new Node(subOpen, [], state); return last.next; },
        540: function(last) {last.next = new Node(subReadFile, [], state); return last.next; },
        560: function(last) {last.next = new Node(subWriteFile, [], state); return last.next; },
        580: function(last) {last.next = new Node(subClose, [], state); return last.next; },
        600: function(last) {last.next = new Node(subClearScreen, [], state); return last.next; },
        620: function(last) {last.next = new Node(subPlot, [], state); return last.next; },
        630: function(last) {last.next = new Node(subDraw, [], state); return last.next; },
        650: function(last) {last.next = new Node(subText, [], state); return last.next; },
    }

    function parseIf(parser, expr_list, token, last)
    // parse IF
    {
        var condition = parser.parseExpression(expr_list);
        var node = new Conditional(condition);
        last.next = node;
        var then = expr_list.shift()
        if (then.token_type !== 'statement' || then.payload !== 'THEN') {
            throw new BasicError('Syntax error', 'expected `THEN`, got `'+then.payload+'`', current_line);
        }
        // supply a GOTO if jump target given after THEN
        var jump = expr_list[0]
        if (jump.token_type === 'literal') {
            expr_list.unshift(KEYWORDS['GOTO']());
        }
        node.branch = new Label('THEN');
        node.next = new Label('FI');
        var end_branch = parser.parseLine(expr_list, node.branch);
        end_branch.next = node.next;
        // give back the separator so the next line parses correctly
        expr_list.unshift(new tokenSeparator('\n'));
        // merge branch back into single node
        return node.next;
    }

    function parseOn(parser, expr_list, token, last)
    // parse ON jumps
    {
        var condition = parser.parseExpression(expr_list);
        var jump = expr_list.shift();
        if (jump.token_type !== 'statement' || (jump.payload !== 'GOTO' && jump.payload !== 'GOSUB')) {
            throw new BasicError('Syntax error', 'expected `GOTO` or `GOSUB`, got `'+jump.payload+'`', current_line);
        }
        var is_sub = false;
        if (jump.payload === 'GOSUB') is_sub = true;
        var label = new Label('NO');
        var nodes = [];
        while (expr_list.length) {
            var line_number = expr_list.shift();
            if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
                throw new BasicError('Syntax error', 'expected line number, got `'+line_number.payload+'`', current_line);
            }
            var node = new Jump(line_number.payload, state, is_sub);
            node.next = label;
            nodes.push(node);
            var sep = expr_list.shift();
            if (sep.token_type !== ',') {
                expr_list.unshift(sep);
                break;
            }
        }
        last.next = new Switch(condition, nodes);
        last.next.next = label;
        return label;
    }

    function parseFor(parser, expr_list, token, last)
    // parse FOR
    {
        var loop_variable = expr_list.shift();
        if (loop_variable.token_type !== 'name' || loop_variable.payload.slice(-1) === '$') {
            throw new BasicError('Syntax error', 'expected numerical variable name, got `'+loop_variable.payload+'`', current_line);
        }
        loop_variable = loop_variable.payload;
        var equals = expr_list.shift();
        if (equals.token_type !== 'operator' || equals.payload !== '=') {
            throw new BasicError('Syntax error', 'expected `=`, got `'+equals.payload+'`', current_line);
        }
        var start = parser.parseExpression(expr_list);
        var to = expr_list.shift();
        if (to.token_type !== 'statement' || to.payload !== 'TO') {
            throw new BasicError('Syntax error', 'expected `TO`, got `'+to.payload+'`', current_line);
        }
        var stop = parser.parseExpression(expr_list);
        var step = expr_list.shift();
        if (step.token_type !== 'statement' || step.payload !== 'STEP') {
            expr_list.unshift(step);
            step = new Literal(1);
        }
        else {
            step = parser.parseExpression(expr_list);
        }
        // loop init
        last.next = new Node(stLet, [
                                new Node(function (x, y) { return x-y; }, [start, step], state),
                                new Literal(loop_variable)
                            ], state);
        last = last.next;
        // increment node
        var incr = new Node(stLet, [
                                new Node(function(x, y) { return x+y; }, [
                                        new Node(opRetrieve, [new Literal(loop_variable)], state),
                                        step
                                    ], state),
                                new Literal(loop_variable),
                            ], state);
        last.next = incr;
        last = incr;

        // parse body of FOR loop until NEXT is encountered
        var token = null;
        while (true) {
            if (!expr_list.length) {
                throw new BasicError(`Block error`, '`FOR` without `NEXT`', current_line);
            }
            //FIXME -  remove repetition of parseLine
            // make a parseUntil (with until === '\n' for IF, and 'NEXT' for FOR, and null for parseProgram)

            // parse separator
            if (!expr_list.length) break;
            var sep = expr_list.shift();
            if (sep.token_type === '\n') {
                last.next = parser.parseLineNumber(expr_list, last);
                last = last.next;
            }
            else if (sep.token_type !== ':') {
                throw new BasicError(`Syntax error`, 'expected `:`, got `' + sep.payload + '`', current_line);
            }

            var token = expr_list.shift();
            // check for empty statement
            if (token.token_type === ':') continue;
            // optional LET
            if (token.token_type === 'name') {
                expr_list.unshift(token);
                token = KEYWORDS['LET']();
            }

            if (token.payload === 'NEXT') {
                // only one variable allowed
                var next_variable = expr_list.shift();
                // accept missing variable name (formally not allowed)
                if (next_variable.token_type !== 'name') {
                    expr_list.unshift(next_variable);
                }
                else {
                    if (next_variable.payload.slice(-1) === '$') {
                        throw new BasicError('Type mismatch', 'expected `NEXT` with numerical variable name, got `NEXT ' + next_variable.payload + '`', current_line);
                    }
                    if (loop_variable !== next_variable.payload) {
                        throw new BasicError('Block error', 'Expected `NEXT `'+loop_variable+'`, got `NEXT ' + next_variable.payload + '`', current_line);
                    }
                }
                last.next = new Label('NEXT '+ loop_variable);
                last = last.next;
                break;
            }

            // parse arguments in statement-specific way
            // statement parsers must take care of maintaining the linked list
            last = PARSERS[token.payload](parser, expr_list, token, last)
        }

        // create the iteration node
        // iterate if (i*step) < (stop*step) to deal with negative steps
        var cond = new Conditional(new Node(function(x, y, z) { return z*x < z*y; }, [
                                    new Node(opRetrieve, [new Literal(loop_variable)], state),
                                    stop, step,
                                ], state));
        cond.branch = incr;
        last.next = cond;
        return cond;
    }

    function parseInput(parser, expr_list, token, last)
    // parse INPUT
    {
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw new BasicError('Syntax error', 'expected variable name, got `' + name.payload + '`', current_line);
        }
        var indices = parser.parseArguments(expr_list);
        // prompt
        last.next = new Node(stPrint, [new Literal('? ')], state);
        // wait for ENTER kepress before engaging
        //FIXME: Wait() has no state parameter, so we depend on declaring this here with state in a closure
        last.next.next = new Wait(function() { return state.input.interact(state.output); });
        // return payload: do not retrieve the variable, just get its name
        last.next.next.next = new Node(stInput, [new Literal(name.payload)].concat(indices), state);
        return last.next.next.next;
    }

    function parseDefFn(parser, expr_list, token, last)
    // parse DEF FN statement
    {
        var fn = expr_list.shift();
        if (fn.token_type !== 'statement' || fn.payload !== 'FN') {
            throw new BasicError('Syntax error', 'expected `FN`, got `'+fn.payload+'`', current_line);
        }
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw new BasicError('Syntax error', 'expected function name, got `' + name.payload + '`', current_line);
        }
        var token = expr_list.shift();
        if (token.token_type === '(') {
            throw new BasicError('Syntax error', 'expected `(`, got `'+to+'`', current_line);
        }
        var arg = expr_list.shift();
        if (name.token_type != 'name') {
            throw new BasicError('Syntax error', 'expected parameter name, got `' + arg.payload + '`', current_line);
        }
        var token = expr_list.shift();
        if (token.token_type === ')') {
            throw new BasicError('Syntax error', 'expected `)`, got `'+to+'`', current_line);
        }
        var equals = expr_list.shift().payload;
        if (equals !== '=') throw new BasicError('Syntax error', 'expected `=`, got `'+equals+'`', current_line);
        var expr = parser.parseExpression(expr_list);
        state.fns.store(name, arg, expr);
        return last;
    }

    function parseRestore(parser, expr_list, token, last)
    // parse RESTORE
    {
        last.next = new Node(token.operation, [], state);
        return last.next;
    }

    function parseReturn(parser, expr_list, token, last)
    // parse RETURN
    {
        last.next = new Return(state);
        return last.next;
    }

    function parseEnd(parser, expr_list, token, last)
    // parse END
    {
        last.next = new End();
        return last.next;
    }

    function parseRun(parser, expr_list, token, last)
    // parse Run
    {
        last.next = new Run();
        return last.next;
    }
};


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
            throw new BasicError('Out of Data', '', null);
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
        throw new BasicError('Type mismatch' , 'unknown type `'+typeof value+'`', null);
    }
    if (string_name !== string_value) {
        throw new BasicError('Type mismatch' , '', null);
    }
}

function Variables()
{
    this.clear = function()
    {
        this.arrays = {};
        this.scalars = {};
        this.dims = {};
    }

    this.allocate = function(name, indices)
    // allocate an array
    {
        // no redefinitions allowed
        if (name in this.dims || name in this.arrays) throw new BasicError('Duplicate definition', '`'+name+'()` was previously dimensioned', null);
        // BASICODE arrays may have at most two indices
        if (indices.length > 2) throw new BasicError('Subscript out of range', 'too many array dimensions', null);
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
        this.arrays[name] = allocateLevel(indices);
    }

    this.checkSubscript = function(name, indices)
    {
        if (!indices.length) {
            if (!(name in this.dims) && !(name in this.scalars)) {
                this.scalars[name] = defaultValue(name);
            }
        }
        else if (!(name in this.dims)) {
            throw new BasicError('Subscript out of range', 'array was not dimensioned', null);
        }
        else if (indices.length !== this.dims[name].length) {
            throw new BasicError('Subscript out of range' , 'incorrect number of dimensions', null);
        }
        else {
            for (var i=0; i < indices.length; ++i) {
                if (indices[i] < 0 || indices[i] > this.dims[name][i]) {
                    throw new BasicError('Subscript out of range', 'index #'+i+' out of bounds', null);
                }
            }
        }
    }

    this.assign = function(value, name, indices)
    // set a variable
    {
        this.checkSubscript(name, indices);

        if (indices.length === 0) {
            this.scalars[name] = value;
        }
        else if (indices.length === 1) {
            this.arrays[name][indices[0]] = value;
        }
        else {
            this.arrays[name][indices[0]][indices[1]] = value;
        }
    };

    this.retrieve = function(name, indices)
    // retrieve a variable
    {
        this.checkSubscript(name, indices);

        if (indices.length === 0) {
            return this.scalars[name];
        }
        else if (indices.length === 1) {
            return this.arrays[name][indices[0]];
        }
        else {
            return this.arrays[name][indices[0]][indices[1]];
        }
    };

    this.clear();
}



function Functions()
{
    this.clear = function()
    {
        this.exprs = {};
        this.args = {};
    }

    this.store = function(name, arg, expr)
    {
        this.exprs[name] = expr;
        this.args[name] = arg;
    }

    this.evaluate = function(name, arg_value)
    {
        var expr = this.exprs[name]
        var arg = this.args[name]

    }

    this.clear();
}

///////////////////////////////////////////////////////////////////////////////
// variable retrieval

function opRetrieve(name)
//  retrieve a variable from the Variables object in state
{
    var state = this;
    var indices = [].slice.call(arguments, 1);
    var value = state.variables.retrieve(name, indices);
    return value;
}


///////////////////////////////////////////////////////////////////////////////
// statements

// we set `this` to the current program state upon calling these


function stLet(value, name)
// LET
{
    var state = this;
    var indices = [].slice.call(arguments, 2);
    state.variables.assign(value, name, indices);
}

function stDim(name)
// DIM
{
    var state = this;
    var indices = [].slice.call(arguments, 1);
    state.variables.allocate(name, indices);
}

function stPrint()
// PRINT
{
    var state = this;
    var values = [].slice.call(arguments);
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

function stRestore()
// RESTORE
{
    var state = this;
    state.data.restore();
}

function stRead(name)
// READ
{
    var state = this;
    var indices = [].slice.call(arguments, 1);
    var value = state.data.read()
    state.variables.assign(value, name, indices);
}

function stInput(name)
// INPUT
{
    var state = this;
    var indices = [].slice.call(arguments, 1);
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

function subClear()
// clear variables, for GOTO 20
{
    var state = this;
    state.clear();
    state.variables.assign(state.output.width - 1, 'HO', []);
    state.variables.assign(state.output.height - 1, 'VE', []);
}

function subClearScreen()
// GOSUB 100, GOSUB 600
// 600 Switch to graphic screen and clear graphic screen
{
    var state = this;
    state.output.clear();
}

function subSetPos()
// GOSUB 110
{
    var state = this;
    state.output.setColumn(state.variables.retrieve('HO', []));
    state.output.setRow(state.variables.retrieve('VE', []));
}

function subGetPos()
// GOSUB 120
{
    var state = this;
    state.variables.assign(state.output.col, 'HO', []);
    state.variables.assign(state.output.row, 'VE', []);
}

function subWriteBold()
// GOSUB 150
{
    var state = this;
    var text = '   ' + state.variables.retrieve('SR$', []) + '   ';
    state.output.write(' ');
    state.output.invertColour();
    state.output.write(text);
    state.output.invertColour();
    state.output.write(' ');
}

function subReadKey()
// GOSUB 200, GOSUB 210 (after wait)
{
    var state = this;
    var keyval = state.input.readKey();
    var key = '';
    if ((keyval >= 32 && keyval <= 126) || keyval === 13) {
        key = String.fromCharCode(keyval);
        keyval = key.toUpperCase().charCodeAt(0);
    }
    state.variables.assign(keyval, 'IN', []);
    state.variables.assign(key, 'IN$', []);
}

function subSetTimer()
//450 Wait SD*0.1 seconds or for a key stroke
//    When ended: IN$ and IN contain the possible keystroke (see for special codes line 200).
//    SD contains the remaining time from the moment the key was pressed or zero (if no key was pressed)
{
    var state = this;
    var deciseconds = state.variables.retrieve('SD', []);
    state.timer.set(deciseconds * 100);
}

function subReadKeyGetTimer()
// GOSUB 450 (with timer)
//450 Wait SD*0.1 seconds or for a key stroke
//    When ended: IN$ and IN contain the possible keystroke (see for special codes line 200).
//    SD contains the remaining time from the moment the key was pressed or zero (if no key was pressed)
{
    var state = this;
    subReadKey.apply(this);
    var milliseconds = state.timer.remaining();
    state.variables.assign(milliseconds/100, 'SD', []);
}

function subReadChar()
// GOSUB 220
{
    var state = this;
    var col = state.variables.retrieve('HO', []);
    var row = state.variables.retrieve('VE', []);
    var ch = state.output.getScreenChar(row, col);
    state.variables.assign(ch.charCodeAt(0), 'IN', []);
}

function subBeep()
// GOSUB 250
{
    var state = this;
    state.speaker.sound(440, 0.1, 1);
}

function subTone()
// GOSUB 400
//400 Produce a tone using SP, SD and SV
//    SP is frequency level: 0 = lowest, 60='central C', 127 = highest
//    SD is the tone duration in steps of 0.1 seconds
//    SV is the volume: 0=muted 7=medium, 15=loud
//    This subroutine keeps running during the time of SD.
{
    var state = this;
    var freq = state.variables.retrieve('SP', []);
    var dur = state.variables.retrieve('SD', []);
    var vol = state.variables.retrieve('SV', []);
    freq = (freq===0)?0: Math.exp(freq*0.057762 + 2.10125);
    state.speaker.sound(freq, dur*0.1, vol/15.);
}



function subRandom()
// GOSUB 260
{
    var state = this;
    state.variables.assign(Math.random(), 'RV', []);
}

function subFree()
// GOSUB 270
{
    var state = this;
    // theoretically, we should garbage-collect and return free memory
    // but let's just return some largeish (for BASICODE) number of bytes
    state.variables.assign(65536, 'FR', []);
}

function subToggleBreak()
// GOSUB 280
// 280 Disable the stop/break key (FR=1) or enable or (FR=0).
{
    var state = this;
    state.input.suppress_break = true;
}

function subNumberToString()
// GOSUB 300
{
    var state = this;
    var num = state.variables.retrieve('SR', []);
    state.variables.assign(num.toString(10), 'SR$', []);
}

function subNumberFormat()
// GOSUB 310
// 310 Convert number SR to string with a string length of CT and with CN places after decimal point; returned in SR$,
{
    var state = this;
    var num = state.variables.retrieve('SR', []);
    var len = state.variables.retrieve('CT', []);
    var decimals = state.variables.retrieve('CN', []);
    var str = num.toFixed(decimals);
    if (str.length > len) {
        // too long; replace with stars
        str = '*'.repeat(len);
    }
    else if (str.length < len) {
        // left-pad with spaces
        str = ' '.repeat(len-str.length) + str;
    }
    state.variables.assign(str, 'SR$', []);
}

function subToUpperCase()
// GOSUB 330
// 330 Convert all letters in SR$ to capital letters
{
    var state = this;
    var str = state.variables.retrieve('SR$', []);
    state.variables.assign(str.toUpperCase(), 'SR$', []);
}

function subLinePrint()
// GOSUB 350
// 350 Print SR$ on the printer.
{
    var state = this;
    var text = state.variables.retrieve('SR$', []);
    state.printer.write(text);
}

function subLineFeed()
// GOSUB 360
// 360 Carriage return and line feed on the printer.
{
    var state = this;
    state.printer.write('\n');
}

/*
500 Open the file NF$ according to the code in NF:
NF = even number: input: NF= uneven number: output
    NF= 0 or 1 BASICODE cassette
    NF= 2 or 3 own system memory
    NF= 4 or 5 diskette
    NF= 6 or 7 diskette
    IN=0: all OK, IN=1: end of file, IN=-1: error
540 Read into IN$ from the opened file NF$ (in IN the status, see line 500)
560 Send SR$ towards the opened file NF$ (in IN the status, see line 500)
580 Close the file with code NF
*/

function subOpen()
{
    var state = this;
    var nf = state.variables.retrieve('NF', []);
    var name = state.variables.retrieve('NF$', []);
    var mode = (nf%2) ? 'r' : 'w';
    var device = Math.floor(nf/2);
    var status = state.storage[device].open(name, mode) ? 0 : -1;
    state.variables.assign(status, 'IN', []);
}

function subClose()
{
    var state = this;
    var nf = state.variables.retrieve('NF', []);
    var device = Math.floor(nf/2);
    var status = state.storage[device].close() ? 0 : -1;
    state.variables.assign(status, 'IN', []);
}

function subReadFile()
{
    var state = this;
    var nf = state.variables.retrieve('NF', []);
    var device = Math.floor(nf/2);
    var status = 0;
    var str = '';
    try {
        str = state.storage[device].readLine();
        if (str === null) {
            status = 1;
            str = '';
        }
    }
    catch (e) {
        if (typeof e !== 'string') throw e;
        status = -1;
    }
    state.variables.assign(status, 'IN', []);
    state.variables.assign(str, 'IN$', []);
}

function subWriteFile()
{
    var state = this;
    var nf = state.variables.retrieve('NF', []);
    var device = Math.floor(nf/2);
    var status = 0;
    var str = state.variables.retrieve('SR$', []);
    try {
        state.storage[device].writeLine(str);
    }
    catch (e) {
        if (typeof e !== 'string') throw e;
        status = -1;
    }
    state.variables.assign(status, 'IN', []);
}


function subPlot()
// 620 Plot a point at graphic position HO,VE (0<=HO<1 en 0<=VE<1) in fore/background color CN (=0/1; normally white/black)
{
    var state = this;
    var x = state.variables.retrieve('HO', []);
    var y = state.variables.retrieve('VE', []);
    var c = state.variables.retrieve('CN', []);
    state.output.plot(x, y, c);
}

function subDraw()
// 630 Draw a line towards point HO,VE (0<=HO<1 en 0<=VE<1) in fore/background color CN (=0/1; normally white/black)
{
    var state = this;
    var x = state.variables.retrieve('HO', []);
    var y = state.variables.retrieve('VE', []);
    var c = state.variables.retrieve('CN', []);
    state.output.draw(x, y, c);
}

function subText()
//650 Print SR$ as text from graphic position HO,VE (0<=HO<1 en 0<=VE<1). HO and VE stay the same value.
{
    var state = this;
    var x = state.variables.retrieve('HO', []);
    var y = state.variables.retrieve('VE', []);
    var text = state.variables.retrieve('SR$', []);
    state.output.drawText(x, y, text);
}


///////////////////////////////////////////////////////////////////////////////
// interface

const ACTIVE_DELAY = 1;


function Interface(iface_element)
{
    var output_element = iface_element;
    var input_element = iface_element;

    // only allow one program to connect at a time
    this.busy = false;

    this.acquire = function(do_run)
    // acquire this interface, after the previous user released it
    {
        this.busy = true;
        this.break_flag = false;
    }

    this.release = function()
    // release this interface
    {
        this.busy = false;
        this.curtain();
    }

    ///////////////////////////////////////////////////////////////////////////
    // screen

    this.width = 40;
    this.height = 24;
    this.foreground = 'white';
    this.background = 'black';
    // number of ticks in a cursor cycle
    this.cursor_ticks = 240/ACTIVE_DELAY;

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
        //graphics
        this.last_x = 0;
        this.last_y = 0;
    }

    this.curtain = function() {
        context.fillStyle = 'rgba(225,225,225,0.25)';
        context.fillRect(0, 0, output_element.width, output_element.height);
    }

    this.write = function(output)
    {
        var lines = output.toString().split(/\r?\n/);
        var i=1;
        this.writeRaw(lines[0]);
        for (; i < lines.length; ++i) {
            this.lineFeed();
            this.writeRaw(lines[i]);
        }
    }

    this.checkPos = function()
    {
        if (this.col >= this.width) {
            this.col = 0;
            ++this.row;
        }
        // TODO, maybe: should we scroll?
        if (this.row >= this.height) this.row = this.height-1;
    }

    this.writeRaw = function(output)
    {
        if ((this.row >= this.height) || (this.row<0)) return;

        for (var i=0; i < output.length; ++i) {
            var char = '';
            if (output.charCodeAt(i) === 127) {
                // put a space to clear the cursor
                this.putChar(' ');
                --this.col;
                this.checkPos();
                this.putChar(' ');
            }
            else if (output.charCodeAt(i) >= 32 && output.charCodeAt(i) < 127) {
                this.putChar(output[i]);
                ++this.col;
                this.checkPos();
            }
        }
    }

    this.putChar = function(char)
    {
        this.putText(this.col*font_width, this.row*font_height, char);
        // update content buffer
        this.content[this.row] = this.content[this.row].slice(0, this.col) + char + this.content[this.row].slice(this.col+1);
    }

    this.putText = function(x, y, output)
    // x,y are (approximate) top left corner of text box, not baseline
    {
        context.fillStyle = this.background;
        context.fillRect(x-0.5, y-0.5, output.length*font_width+0.5, font_height+0.5);
        context.fillStyle = this.foreground;
        // 0.75 seems about the right baseline offset for Chrome & Firefox...
        context.fillText(output, x, y+0.75*font_height);
    }

    var cursor_now = 0;
    this.cursor = function()
    {
        cursor_now = (++cursor_now) % this.cursor_ticks;
        if (cursor_now > this.cursor_ticks/2) {
            context.fillStyle = this.foreground;
            context.fillRect(this.col*font_width+1, this.row*font_height+1,
                font_width-2, font_height-2);
        }
        else {
            context.fillStyle = this.background;
            context.fillRect(this.col*font_width, this.row*font_height,
                font_width, font_height);
        }
    }

    this.writeCentre = function(row, str)
    // write centred; used by the loader only
    {
        this.setColumn((this.width - str.length)/2);
        this.setRow(row);
        this.write(str);
    }

    this.getScreenChar = function(row, col)
    {
        return this.content[row].slice(col, col+1);
    }

    this.invertColour = function()
    {
        var buf = this.foreground;
        this.foreground = this.background;
        this.background = buf;
    }

    this.setColumn = function(col)
    {
        this.col = col;
        if (this.col >= this.width) this.lineFeed();
    }

    this.lineFeed = function()
    {
        ++this.row;
        this.col = 0;
        if (this.row >= this.height) this.row = this.height-1;
    }

    this.setRow = function(row)
    {
        this.row = row;
        if (this.row >= this.height) this.row = this.height-1;
    }

    this.clear();

    ///////////////////////////////////////////////////////////////////////////
    // graphics


    this.plot = function(x, y, c)
    {
        this.last_x = x*output_element.width;
        this.last_y = y*output_element.height;
        context.fillStyle = c ? this.background : this.foreground;
        context.fillRect(this.last_x, this.last_y, 1, 1);
    }

    this.draw = function(x, y, c)
    {
        var next_x = x*output_element.width;
        var next_y = y*output_element.height;
        context.strokeStyle = c ? this.background : this.foreground;
        context.beginPath();
        context.moveTo(this.last_x, this.last_y);
        context.lineTo(next_x, next_y);
        context.stroke();
        this.last_x = next_x;
        this.last_y = next_y;
    }

    this.drawText = function(x, y, c)
    {
        var pixel_x = x*output_element.width;
        var pixel_y = y*output_element.height;
        this.putText(pixel_x, pixel_y, c);
    }

    ///////////////////////////////////////////////////////////////////////////
    // keyboard

    // make canvas element focussable to catch keypresses
    input_element.tabIndex = 1;
    input_element.focus();

    var self = this;

    // JavaScript to BASICODE keycode dictionary
    const KEYS = {
        8: 127, // backspace
        13: 13, // enter
        37: 28, // left
        38: 31, // up
        39: 29, // right
        40: 30, // down
        112: -1, // F1
        113: -2, // F2
        114: -3, // F3
        115: -4, // F4
        116: -5, // F5
        117: -6, // F6
        118: -7, // F7
        119: -8, // F8
        120: -9, // F9
        121: -10, // F10
        122: -11, // F11
        123: -12, // F12
    }

    input_element.addEventListener('keydown', function(event) {
        // use this for backspace, function keys
        if (event.keyCode === 19 && event.ctrlKey && !self.suppress_break) {
            self.break_flag = true;
        }
        if (event.keyCode in KEYS) {
            self.buffer.push(KEYS[event.keyCode]);
            // preventDefault will stop all keys from being caught by keypress, so use only for backspace and function keys to avoid browser actions
            event.preventDefault();
        }
    });

    input_element.addEventListener('keypress', function(event) {
        self.buffer.push(event.charCode);
        event.preventDefault();
    });

    this.reset = function()
    {
        this.buffer = [];
        // suppress ctrl+break key
        this.suppress_break = false;
        // break has been pressed
        this.break_flag = false;
        // interactive line buffer
        this.line_buffer = '';
    }

    this.keyPressed = function() {
        return self.buffer.length > 0;
    }

    this.readKey = function()
    {
        if (!this.buffer.length) return 0;
        return this.buffer.shift();
    }

    // INPUT support

    this.interact = function(output)
    {
        this.cursor();
        var loc = this.buffer.indexOf(13);
        var new_chars = [];
        if (loc === -1) {
            new_chars = this.buffer.slice();
            this.buffer = [];
        }
        else {
            new_chars = this.buffer.slice(0, loc);
            // leave the CR out of the buffer
            this.buffer = this.buffer.slice(loc+1);
        }
        var new_str = String.fromCharCode.apply(null, new_chars);
        this.line_buffer += new_str;
        output.write(new_str);
        // echo the newline, but don't return it
        // also echo a space to remove the cursor (this is a bit of a hack);
        if (loc !== -1) output.write(' \n');
        // trigger value is true if CR has been found
        return (loc !== -1);
    }

    this.readLine = function()
    {
        var line = this.line_buffer;
        this.line_buffer = '';
        // handle backspaces
        for (var i=0; i < line.length;) {
            if (line.charCodeAt(i) === 127) {
                line = line.slice(0, i-1) + line.slice(i+1);
                --i;
            }
            else if (line.charCodeAt(i) < 32 || line.charCodeAt(i) > 126) {
                line = line.slice(0, i) + line.slice(i+1);
            }
            else ++i;
        }
        return line;
    }

    this.reset();
}


///////////////////////////////////////////////////////////////////////////////
// printer

function Printer() {

    // create hidden iframe for printing
    var print_iframe = document.createElement('iframe');
    print_iframe.hidden = true;
    document.body.appendChild(print_iframe);
    var print_element = document.createElement('pre');
    print_iframe.contentDocument.body.appendChild(print_element)

    this.write = function(text)
    // add text to the print document
    {
        print_element.textContent += text.split(/\r?\n/).join('\n');
    }

    this.flush = function()
    // send the document (if any) to the printer
    {
        if (print_element.textContent) print_iframe.contentWindow.print();
    }
}


///////////////////////////////////////////////////////////////////////////////
// speaker

// Safari still only has the experimental version of the Web Audio API
// not sure if we're not breaking Safari elsewhere, though
window.AudioContext = window.AudioContext || window.webkitAudioContext;
var context = new AudioContext();


function Speaker()
// tone generator
{
    this.tones = 0;

    this.isBusy = function()
    {
        return (this.tones > 0);
    }

    this.sound = function(frequency, duration, volume)
    // play a sound at frequency (Hz) and volume (0--1) for duration (s)
    // caller should check we're not busy first, otherwise first oscillator to stop
    // will unset the busy flag
    {
        // Oscillator node
        var oscillator = context.createOscillator();
        oscillator.type = 'square';
        oscillator.frequency.value = frequency;

        // Gain node
        var gain = context.createGain();
        gain.gain.value = volume;

        // link nodes up
        oscillator.connect(gain);
        gain.connect(context.destination);

        // play the tone
        ++this.tones;
        var now = context.currentTime;
        oscillator.start(now);
        oscillator.stop(now + duration);

        // clean up afterwards
        var speaker = this;
        oscillator.onended = function() {
            // this event seems to be missed by Chromium, occasionally
            --speaker.tones;
            oscillator.disconnect();
            gain.disconnect();
        };
    }
}

///////////////////////////////////////////////////////////////////////////////
// time

function Timer()
{
    var start = null;
    this.duration = 0;

    this.set = function(duration)
    {
        start = new Date();
        this.duration = duration;
    }

    this.clear = function()
    {
        start = null;
        this.duration = 0;
    }

    this.elapsed = function() {
        if (start === null) return true;
        return (new Date() - start) > this.duration;
    }

    this.remaining = function() {
        if (start === null) return 0;
        var remaining = this.duration - (new Date() - start);
        return (remaining<0) ? 0 : remaining;
    }
}

///////////////////////////////////////////////////////////////////////////////
// storage

function Floppy(id)
{
    this.id = id;
    this.open_file = null;
    this.open_key = null;
    this.open_mode = '';
    this.open_line = null;

    this.open = function(name, mode)
    {
        this.open_key = this.id + ':' + name;
        var string = localStorage.getItem(this.open_key);
        this.open_mode = mode;
        this.open_line = 0;
        if (string === undefined || string === null) {
            if (this.open_mode === 'r') {
                this.open_file = null;
                this.open_key = null;
                return false;
            }
            else {
                this.open_file = [];
            }
        }
        else {
            this.open_file = string.split('\n');
        }
        return true;
    }

    this.close = function()
    {
        if (this.open_key === null) return false;
        localStorage.setItem(this.open_key, this.open_file.join('\n'));
        this.open_file = null;
        return true;
    }

    this.readLine = function()
    {
        if (this.open_line > this.open_file.length) return null;
        if (this.open_mode !== 'r') throw 'File not open for read';
        return this.open_file[this.open_line++];
    }

    this.writeLine = function(line)
    {
        if (this.open_mode !== 'w') throw 'File not open for write';
        this.open_file.push(line);
    }

}


///////////////////////////////////////////////////////////////////////////////
// user interface

function BasicodeApp(script)
{
    // create a canvas to work on
    var element = document.createElement('canvas');
    element.className = 'basicode';
    document.body.appendChild(element);

    this.iface = new Interface(element);
    // interval timer for running program
    this.run_interval = null;
    this.program = null;

    var app = this;

    this.handleError = function(e)
    {
        this.stop();
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(0);
        this.iface.write(' '.repeat(this.iface.width));
        this.iface.invertColour();
        this.iface.write(' '.repeat(this.iface.width*3));
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(0);
        if (e instanceof BasicError) {
            this.iface.write(e.message);
            var ln = e.where;
            if (ln === null && this.program !== null) ln = this.program.current_line;
            this.iface.write(' in '+ ln +'\n');
            this.iface.invertColour();
            this.iface.write(e.detail + '\n');
        }
        else {
            this.iface.write('EXCEPTION\n')
            this.iface.invertColour();
            this.iface.write(e + '\n');
            throw e;
        }
    }

    this.load = function(code)
    // load program, parse to AST, connect to output
    {
        // clear screen
        this.iface.clear();
        // reset keyboard buffer
        this.iface.reset();
        try {
            // initialise program object
            this.program = new Parser().parseProgram(tokenise(code));
            this.program.output = this.iface;
            this.program.input = this.iface;
            this.program.printer = new Printer();
            this.program.speaker = new Speaker();
            this.program.timer = new Timer();
            this.program.storage = [new Floppy(0), new Floppy(1), new Floppy(2), new Floppy(3)]
            // show title and description
            this.show();
        } catch (e) {
            this.handleError(e);
        }
    }

    this.show = function()
    // show program title and description
    {
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(0);
        this.iface.write(' '.repeat(this.iface.width));
        this.iface.writeCentre(0, this.program.title);
        this.iface.write('\n\n');
        this.iface.invertColour();
        this.iface.write(this.program.description);
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(this.iface.height - 1);
        this.iface.write(' '.repeat(this.iface.width));
        this.iface.writeCentre(this.iface.height - 1, '-- click to run --');
        this.iface.invertColour();
        this.iface.curtain();
    }

    this.splash = function()
    // intro screen if nothing was loaded
    {
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(0);
        this.iface.write(' '.repeat(this.iface.width));
        this.iface.writeCentre(0, '(c) 2016, 2017 Rob Hagemans');
        this.iface.invertColour();
        var row = 6;
        this.iface.writeCentre(row++, '**. .*. .** .*. .** .*. **. ***');
        this.iface.writeCentre(row++, '*.* *.* *.. .*. *.. *.* *.* *..');
        this.iface.writeCentre(row++, '*.* *.* *.. .*. *.. *.* *.* *..');
        this.iface.writeCentre(row++, '*.* *.* *.. .*. *.. *.* *.* *..');
        this.iface.writeCentre(row++, '..**..***..*...*..*...*.*.*.*.**...');
        this.iface.writeCentre(row++, '*.* *.* ..* .*. *.. *.* *.* *..');
        this.iface.writeCentre(row++, '*.* *.* ..* .*. *.. *.* *.* *..');
        this.iface.writeCentre(row++, '*.* *.* ..* .*. *.. *.* *.* *..');
        this.iface.writeCentre(row++, '**. *.* **. .*. .** .*. **. ***');
        this.iface.writeCentre(17, '---==[2017]==---');
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(this.iface.height - 1);
        this.iface.write(' '.repeat(this.iface.width));
        this.iface.writeCentre(this.iface.height - 1, '-- drag and drop to load --');
        this.iface.invertColour();
        this.iface.curtain();
    }

    this.run = function()
    // execute the program
    {
        // exit if nothing loaded
        if (!this.program || this.program.tree === null) return;

        // clear screen
        this.iface.clear();
        // reset keyboard buffer
        this.iface.reset();
        // reset program state
        this.program.clear();

        var prog = this.program;
        var current = prog.tree;
        app.run_interval = window.setInterval(function() {
            try {
                if (current instanceof Label && typeof current.label === 'number') app.program.current_line = current.label
                if (current) current = current.step(); else {
                    app.stop();
                }
                if (app.iface.break_flag) {
                    app.iface.write('\nBreak\n');
                    app.stop();
                }
            } catch (e) {
                app.handleError(e)
            }
        }, ACTIVE_DELAY);
    }

    this.stop = function()
    // release resources upon program end
    {
        if (this.run_interval !== null) {
            window.clearInterval(this.run_interval);
            this.run_interval = null;
        }
        if (this.program !== null) {
            this.program.output.release();
            this.program.printer.flush();
        }
        this.iface.invertColour();
        this.iface.setColumn(0);
        this.iface.setRow(this.iface.height - 1);
        this.iface.write(' '.repeat(this.iface.width));
        this.iface.writeCentre(this.iface.height - 1, '-- click to run again --');
        this.iface.invertColour();
    }

    // load & run the code provided in the element, if any
    var url = script.getAttribute('src');
    var code = script.innerHTML;
    if (url !== undefined && url !== null && url) {
        var url = script.getAttribute('src');
        var request = new XMLHttpRequest();
        request.open('GET', url, true);
        request.onreadystatechange = function() {
            if (request.readyState === 4 && request.status === 200) {
                app.load(request.responseText);
            }
        }
        request.send(null);
    }
    else if (code) {
        this.load(code);
    }
    else {
        this.splash();
    }

    ///////////////////////////////////////////////////////////////////////////
    // event handlers

    // run file on click

    element.addEventListener('click', function click(e) {
        if (app.run_interval === null) {
            app.run();
        }
    });

    // load files on drag & drop

    element.addEventListener('dragenter', function dragenter(e) {
        e.stopPropagation();
        e.preventDefault();
    });

    element.addEventListener('dragover', function dragover(e) {
        e.stopPropagation();
        e.preventDefault();
    });

    element.addEventListener('drop', function drop(e) {
        e.stopPropagation();
        e.preventDefault();
        var files = e.dataTransfer.files;
        var reader = new FileReader();
        reader.onload = function() {
            app.stop();
            app.load(reader.result);
        };
        reader.readAsText(files[0]);
    });

}

function launch() {
    var scripts = document.getElementsByTagName('script');
    for(var i=0; i < scripts.length; ++i) {
        if (scripts[i].type == 'text/basicode') {
            var app = new BasicodeApp(scripts[i]);
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
// problems with arrays, investigate
// negative numbers in DATA
// - files, colour
// - DEF FN
// - type checks
// - scrolling
// BC3 (v2? 3C? see e.g. journale/STRING.ASC): MID$(A$, 2) => a[1:]
// DDR Basicode uses INPUT "prompt"; A$
// increase delay when waiting for input

// BC3C
// colours
// return CN in GOSUB 200

// controls: repeat/play/pause, load, print buttons
// scrollable info page; center info page on longest line of description

// split interface in keyboard, screen
// clean up state/Program object

// some potential optimisations, if needed:
// - pre-calculate jump targets (second pass of parser?)
