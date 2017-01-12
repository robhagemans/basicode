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
// compatibility/polyfills

// Web Audio API
// Safari still only has the experimental version of the Web Audio API
// not sure if we're not breaking Safari elsewhere, though
window.AudioContext = window.AudioContext || window.webkitAudioContext;

// String repeat method
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/repeat
if (!String.prototype.repeat) {
  String.prototype.repeat = function(count) {
    'use strict';
    if (this == null) {
      throw new TypeError('can\'t convert ' + this + ' to object');
    }
    var str = '' + this;
    count = +count;
    if (count != count) {
      count = 0;
    }
    if (count < 0) {
      throw new RangeError('repeat count must be non-negative');
    }
    if (count == Infinity) {
      throw new RangeError('repeat count must be less than infinity');
    }
    count = Math.floor(count);
    if (str.length == 0 || count == 0) {
      return '';
    }
    // Ensuring count is a 31-bit integer allows us to heavily optimize the
    // main part. But anyway, most current (August 2014) browsers can't handle
    // strings 1 << 28 chars or longer, so:
    if (str.length * count >= 1 << 28) {
      throw new RangeError('repeat count must not overflow maximum string size');
    }
    var rpt = '';
    for (;;) {
      if ((count & 1) == 1) {
        rpt += str;
      }
      count >>>= 1;
      if (count == 0) {
        break;
      }
      str += str;
    }
    return rpt;
  }
}


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

function SeparatorToken(bracket_char)
{
    this.token_type = bracket_char;
    this.payload = bracket_char;
}

function LiteralToken(value)
{
    this.token_type = 'literal';
    this.operation = function opLiteral(x) { return x; };
    this.payload = value;
}

function NameToken(value)
{
    this.token_type = 'name';
    this.payload = value;
}

function newFunctionToken(keyword, operation) {
    return (function() {
        return (new function FunctionToken() {
            this.token_type = 'function';
            this.payload = keyword;
            this.operation = operation;
        }() );
    } );
}
function newStatementToken(keyword, operation) {
    return (function() {
        return (new function StatementToken() {
            this.token_type = 'statement';
            this.payload = keyword;
            this.operation = operation;
        }() );
    } );
}
function newOperatorToken(keyword, narity, precedence, operation) {
    return (function() {
        return (new function OperatorToken() {
            this.token_type = 'operator';
            this.payload = keyword;
            this.narity = narity;
            this.precedence = precedence;
            this.operation = operation;
        }() );
    } );
}

var SYMBOLS = {
    '^': newOperatorToken('^', 2, 12, Math.pow),
    '*': newOperatorToken('*', 2, 11, opMultiply),
    '/': newOperatorToken('/', 2, 11, opDivide),
    '+': newOperatorToken('+', null, 8, opPlus),
    '-': newOperatorToken('-', null, 8, opMinus),
    '=': newOperatorToken('=', 2, 7, opEqual),
    '>': newOperatorToken('>', 2, 7, opGreaterThan),
    '>=': newOperatorToken('>=', 2, 7, opGreaterThanOrEqual),
    '<': newOperatorToken('<', 2, 7, opLessThan),
    '<=': newOperatorToken('<=', 2, 7, opLessThanOrEqual),
    '<>': newOperatorToken('<>', 2, 7, opNotEqual),
}

var KEYWORDS = {
    'ABS': newFunctionToken('ABS', Math.abs),
    'AND': newOperatorToken('AND', 2, 5, opAnd),
    'ASC': newFunctionToken('ASC', fnAsc),
    'ATN': newFunctionToken('ATN', Math.atan),
    'CHR$': newFunctionToken('CHR$', String.fromCharCode),
    'COS': newFunctionToken('COS', Math.cos),
    'DIM': newStatementToken('DIM', stDim),
    'EXP': newFunctionToken('EXP', Math.exp),
    'INPUT': newStatementToken('INPUT', stInput),
    'INT': newFunctionToken('INT', Math.trunc),
    'LEFT$': newFunctionToken('LEFT$', fnLeft),
    'LEN': newFunctionToken('LEN', fnLen),
    'LET': newStatementToken('LET', stLet),
    'LOG': newFunctionToken('LOG', Math.log),
    'MID$': newFunctionToken('MID$', fnMid),
    'NOT': newOperatorToken('NOT', 1, 6, opNot),
    'OR': newOperatorToken('OR', 2, 4, opOr),
    'PRINT': newStatementToken('PRINT', stPrint),
    'READ': newStatementToken('READ', stRead),
    'RESTORE': newStatementToken('RESTORE', stRestore),
    'RIGHT$': newFunctionToken('RIGHT$', fnRight),
    'SGN': newFunctionToken('SGN', Math.sign),
    'SIN': newFunctionToken('SIN', Math.sin),
    'SQR': newFunctionToken('SQR', Math.sqrt),
    'TAB': newFunctionToken('TAB', fnTab),
    'TAN': newFunctionToken('TAN', Math.tan),
    'VAL': newFunctionToken('VAL', fnVal),
    // declarations with no runtime effect
    'DATA': newStatementToken('DATA', null),
    'DEF': newStatementToken('DEF', null),
    'REM': newStatementToken('REM', null),
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
    'FN': newFunctionToken('FN', fnFn),
}

// additional reserved words: AS, AT, GR, LN, PI, ST, TI, TI$


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

    function readInteger()
    // read an unsigned integer literal (i.e. a string of numbers)
    {
        var start_pos = pos;
        for (; pos < expr_string.length-1; ++pos){
            if (!isNumberChar(expr_string[pos+1])) break;
        }
        return expr_string.slice(start_pos, pos+1);
    }

    this.readValue = function()
    {
        // for VAL(), we should also accept a - here
        var sign = '';
        var mantissa = '0';
        var decimal = '0';
        var exponent = '0';
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
                if (expr_string[pos+1] === '-' || expr_string[pos+1] === '+') {
                    exponent = expr_string[pos+1];
                    ++pos;
                }
                ++pos;
                exponent += readInteger();
            }
        }
        return parseFloat(sign + mantissa + '.' + decimal + 'e' + exponent);
    }

    this.tokenise = function()
    {
        // start with a line break to get the parser to expect a line number
        var expr_list = [new SeparatorToken('\n')];
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
                expr_list.push(new SeparatorToken(char));
            }
            // double quotes, starts a string
            else if (char === '"') {
                expr_list.push(new LiteralToken(readString()));
            }
            // numeric character, starts a number literal
            else if (isNumberChar(char) || char === '.') {
                expr_list.push(new LiteralToken(this.readValue()));
            }
            else if (isAlphaChar(char)) {
                var name = readName();
                if (name in KEYWORDS) {
                    // call function that calls new on a constructor
                    expr_list.push(KEYWORDS[name]());
                    if (name === 'REM') {
                        expr_list.push(new LiteralToken(readComment()));
                    }
                }
                else {
                    expr_list.push(new NameToken(name));
                }
            }
            else if (char !== ' ') {
                // we can't throw here in case there's subroutines<1000 attached
                expr_list.push(new SeparatorToken(char));
                console.log('Unexpected symbol `'+ char + '` during lexing');
            }
        }
        return expr_list;
    }
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

function Node(func, node_args, program)
// used as expression or statement node
{
    this.func = func;
    this.args = node_args;
    this.next = null;
    this.program = program;

    // traverse AST to evaluate this node and all its subnodes
    this.evaluate = function()
    {
        // evaluate all arguments
        var args = this.args.map(function (x) { return x.evaluate(); });
        // call the function with the array supplied as arguments
        return this.func.apply(this.program, args);
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

function Run(program)
{
    this.next = null;

    this.step = function() {
        subClear(program);
        return program.tree;
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
            throw new BasicError('Type mismatch', 'expected numerical expression, got `'+ condition+'`');
        }
        if (condition > 0 && condition <= this.branches.length) {
            return this.branches[condition-1];
        }
        else {
            return this.next;
        }
    }
}

function Jump(target, program, is_sub)
{
    this.target = target;
    this.next = null;

    this.step = function()
    {
        if (!(target in program.line_numbers)) {
            throw new BasicError('Undefined line number in `GOTO ' + target + '`');
        }
        if (is_sub) program.sub_stack.push(this.next);
        return program.line_numbers[target];
    }
}

function Return(program)
// RETURN node
{
    this.step = function()
    {
        return program.sub_stack.pop();
    }
}

function Wait(wait_condition)
// execute node after waiting for condition to become true
// unlike Conditional, the condition is evaluated repeatedy until true
// e.g. wait for a keypress

{
    this.trigger = wait_condition;
    this.next = null;
    this.delay = IDLE_DELAY;

    this.step = function()
    {
        if (this.trigger()) return this.next;
        return this;
    }
}

function For(loop_name, start, stop, incr, program)
{
    this.next = null;

    this.step = function()
    {
        program.variables.assign(start.evaluate(), loop_name, []);
        var for_record = {
            'name': loop_name,
            'next': this.next,
            'stop': stop.evaluate(),
            'incr': incr.evaluate(),
        }
        program.loop_stack.unshift(for_record);
        return this.next;
    }
}

function Next(loop_name, program)
// iteration node
{
    this.next = null;
    this.delay = BUSY_DELAY;

    this.step = function()
    {
        var for_record = program.loop_stack[0];
        while (loop_name !== for_record.name) {
            console.log('Popping from loop stack unexpectedly, did we jump out of a loop?');
            program.loop_stack.shift();
            for_record = program.loop_stack[0];
        }
        var loop_var = program.variables.retrieve(loop_name, []);
        var incr = for_record.incr;
        var stop = for_record.stop;
        // iterate if ((i+step)*step) < (stop*step) to deal with negative steps
        if (incr*(loop_var+incr) <= incr*stop) {
            program.variables.assign(loop_var + incr, loop_name, []);
            return for_record.next;
        }
        program.loop_stack.shift();
        return this.next;
    }
}


//////////////////////////////////////////////////////////////////////
// program object

function Program(basicode)
{
    // parsing output
    this.title = '';
    this.description = '';
    this.data = new Data();
    this.fns = new Functions();
    this.line_numbers = {};
    this.tree = new Label();

    // build the tree
    var tokenised_code = new Lexer(basicode).tokenise();
    var parser = new Parser(tokenised_code, this);
    parser.parse(this.tree);

    // runtime state
    this.variables = new Variables();
    this.sub_stack = [];
    this.loop_stack = [];
    this.current_line = 999;

    this.clear = function()
    {
        this.variables.clear();
        this.data.restore();
        this.sub_stack = [];
        this.current_line = 999;
    }

    this.attach = function(machine)
    // attach program to machine emulator
    {
        this.output = machine.display;
        this.input = machine.keyboard;
        this.printer = machine.printer;
        this.speaker = machine.speaker;
        this.timer = machine.timer;
        this.storage = machine.storage;
    }
}


//////////////////////////////////////////////////////////////////////
// parser


function Parser(expr_list, program)
{
    // current line being parsed
    var current_line = 999;

    // for loop variables
    var for_stack = [];

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
            units.push(new Node(token.operation, args, program));
        }
        return units;
    };

    this.parseExpression = function(parameter, fn_name)
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
                    throw new BasicError('Syntax error', 'unexpected operator type', current_line);
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
                        if (token.payload === 'FN') var name = expr_list.shift();
                        var args = this.parseArguments(parameter, fn_name);
                        if (token.payload === 'FN') args.unshift(new Literal(name.payload));
                        units.push(new Node(token.operation, args, program));
                        break;
                    case '(':
                        // recursive call, gets a Node object containing AST
                        units.push(this.parseExpression(parameter, fn_name));
                        var bracket = expr_list.shift(token);
                        if (bracket.token_type !== ')') {
                            throw new BasicError('Syntax error', 'expected `)`, got `' + bracket.payload + '`', current_line);
                        }
                        break;
                    case 'literal':
                        units.push(new Literal(token.payload));
                        break;
                    case 'name':
                        // user function parameter, must not be array element
                        if (parameter !== undefined && token.payload === parameter) {
                            units.push(new Node(opRetrieveParameter, [new Literal(fn_name)], program));
                        }
                        else {
                            var indices = this.parseArguments(parameter, fn_name);
                            units.push(new Node(opRetrieve, [new Literal(token.payload)].concat(indices), program));
                        }
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

    this.parseArguments = function(parameter, fn_name)
    {
        var args = [];
        if (expr_list.length > 0 && expr_list[0].token_type === '(') {
            expr_list.shift();
            while (expr_list.length > 0) {
                args.push(this.parseExpression(parameter, fn_name));
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

    this.parseLineNumber = function(last)
    {
        if (!expr_list.length) return null;
        var token = expr_list.shift();
        while (expr_list.length) {
            // ignore empty lines
            while (token.token_type === '\n') token = expr_list.shift();
            // we do need a line number at the start
            if (token.token_type != 'literal') {
                throw new BasicError('Syntax error', 'expected line number, got `'+token.payload+'`', current_line);
            }
            var line_number = token.payload;
            // ignore lines < 1000
            if (line_number >= 1000) break;
            while (token.token_type !== '\n') token = expr_list.shift();
        }
        if (line_number <= current_line) {
            throw new BasicError('Syntax error', 'expected line number > `' + current_line+'`, got `'+ line_number + '`', current_line);
        }
        current_line = line_number;
        var label = new Label(line_number);
        program.line_numbers[line_number] = label;
        last.next = label;
        return label;
    }

    this.parse = function(last, end_token)
    {
        while (expr_list.length) {
            // parse separator
            if (expr_list[0].token_type !== 'literal' && expr_list[0].payload === end_token) break;
            var sep = expr_list.shift();
            if (sep.token_type === '\n') {
                // parseLineNumber deals with multiple LFs
                last.next = this.parseLineNumber(last);
                last = last.next;
            }
            else if (sep.token_type !== ':') {
                throw new BasicError(`Syntax error`, 'expected `:`, got `' + sep.payload + '`', current_line);
            }
            if (!expr_list.length) break;
            if (expr_list[0].token_type !== 'literal' && expr_list[0].payload === end_token) break;
            // handle empty statement
            if (expr_list[0].token_type === ':' || expr_list[0].token_type === '\n') continue;
            // parse statements
            var token = expr_list.shift();
            // optional LET
            if (token.token_type === 'name') {
                expr_list.unshift(token);
                token = KEYWORDS['LET']();
            }
            // parse arguments in statement-specific way
            // statement parsers must take care of maintaining the linked list
            last = PARSERS[token.payload].call(this, token, last)
        }
        return last;
    }

    ///////////////////////////////////////////////////////////////////////////
    // statement syntax

    this.parseLet = function(token, last)
    // parse LET statement
    {
        var name = expr_list.shift();
        if (name.token_type != 'name') {
            throw new BasicError('Syntax error', 'expected variable name, got `' + name.payload + '`', current_line);
        }
        var indices = this.parseArguments();
        var equals = expr_list.shift().payload;
        if (equals !== '=') throw new BasicError('Syntax error', 'expected `=`, got `'+equals+'`', current_line);
        var value = this.parseExpression();
        // statement must have access to interpreter state, so program is first argument
        last.next = new Node(token.operation, [value, new Literal(name.payload)].concat(indices), program);
        return last.next;
    }

    this.parsePrint = function(token, last_node)
    // parse PRINT statement
    {
        var last = null;
        while (expr_list.length > 0) {
            var expr = this.parseExpression();
            if (expr !== null) {
                last_node.next = new Node(stPrint, [expr], program);
                last_node = last_node.next;
                last = expr;
            }
            else if (expr_list[0].token_type !== ';') break;
            if (!expr_list.length) break;
            if (expr_list[0].token_type === ':' || expr_list[0].token_type === '\n') break;
            last = ';';
            if (expr_list[0].token_type === ';') expr_list.shift();
        }
        if (last !== ';') {
            last_node.next = new Node(stPrint, [new Literal('\n')], program);
            last_node = last_node.next;
        }
        return last_node;
    }

    this.parseData = function(token, last)
    // parse DATA statement
    {
        var values = []
        var neg = false;
        while (expr_list.length > 0) {
            var value = expr_list.shift();
            // only literals allowed in DATA
            // we're not allowing empty DATA statements or repeated commas
            if (value === null || (value.token_type !== 'literal' && (neg || (value.token_type !== 'operator' || value.payload !== '-')))) {
                throw new BasicError('Syntax error', 'expected string or number literal, got `'+value.payload+'`', current_line);
            }
            if (value.token_type === 'operator' && value.payload === '-') {
                neg = true;
                continue;
            }
            values.push(neg?-value.payload:value.payload);
            neg = false;
            // parse separator (,)
            if (!expr_list.length) break;
            if (expr_list[0].token_type !== ',') break;
            expr_list.shift();
        }
        // data is stored immediately upon parsing, DATA is then a no-op statement
        program.data.store(values);
        return last;
    }

    this.parseRead = function(token, last)
    // parse READ or DIM statement
    {
        var pt = last;
        while (expr_list.length > 0) {
            var name = expr_list.shift();
            if (name.token_type != 'name') {
                throw new BasicError('Syntax error', 'expected variable name, got `' + name.payload + '`', current_line);
            }
            var indices = this.parseArguments();

            last.next = new Node(token.operation, [new Literal(name.payload)].concat(indices), program);
            last = last.next;

            if (!expr_list.length) break;
            if (expr_list[0].token_type !== ',') break;
            expr_list.shift();
        }
        return last;
    }

    this.parseRem = function(token, last)
    // parse REM
    {
        var rem = expr_list.shift();
        if (rem.token_type !== 'literal') {
            throw new BasicError('Syntax error', 'expected literal, got `'+rem.payload+'`', current_line);
        }
        // BASICODE standard: title in REM on line 1000
        // description and copyrights in REMS on lines 30000 onwards
        rem = rem.payload;
        var rem_trim = rem.trim();
        if (rem_trim[0] === '"') {
            rem = rem_trim.slice(1);
            if (rem[rem.length-1] === '"') rem = rem.slice(0, rem.length-1)
        }
        if (current_line === 1000) {
            program.title = rem;
        }
        else if (current_line >= 30000) {
            program.description += rem + '\n';
        }
        return last;
    }

    this.parseGoto = function(token, last)
    // parse GOTO
    {
        var line_number = expr_list.shift();
        if (line_number.token_type !== 'literal' || typeof line_number.payload !== 'number') {
            throw new BasicError('Syntax error', 'expected line number, got `'+line_number.payload+'`', current_line);
        }
        // GOTO 20 is a BASICODE fixture, clear and jump to 1010
        if (line_number.payload === 20) {
            last.next = new Node(subClear, [], program);
            last.next.next = new Jump(1010, program, false)
            return last.next.next;
        }
        // GOTO 950 means END
        else if (line_number.payload === 950) return new End();
        else if (line_number.payload < 1000) {
            throw new BasicError('Unimplemented BASICODE', '`GOTO '+line_number.payload+'` not implemented', current_line);
        }
        // other line numbers are resolved at run time
        last.next = new Jump(line_number.payload, program, false);
        // put a short delay on jumps to avoid overloading the browser on loops
        last.next.delay = BUSY_DELAY;
        return last.next;
    }

    this.parseGosub = function(token, last)
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
        last.next = new Jump(line_number.payload, program, true);
        return last.next;
    }

    var SUBS = {
        100: function(last) {last.next = new Node(subClearScreen, [], program); return last.next; },
        110: function(last) {last.next = new Node(subSetPos, [], program); return last.next; },
        120: function(last) {last.next = new Node(subGetPos, [], program); return last.next; },
        150: function(last) {last.next = new Node(subWriteBold, [], program); return last.next; },
        200: function(last) {last.next = new Node(subReadKey, [], program); return last.next; },
        210: function(last) {
            last.next = new Wait(function waitForKey() { return program.input.keyPressed(); });
            last.next.next = new Node(subReadKey, [], program);
            return last.next.next;
        },
        220: function(last) {last.next = new Node(subReadChar, [], program); return last.next; },
        250: function(last) {last.next = new Node(subBeep, [], program); return last.next; },
        260: function(last) {last.next = new Node(subRandom, [], program); return last.next; },
        270: function(last) {last.next = new Node(subFree, [], program); return last.next; },
        280: function(last) {last.next = new Node(subToggleBreak, [], program); return last.next; },
        300: function(last) {last.next = new Node(subNumberToString, [], program); return last.next; },
        310: function(last) {last.next = new Node(subNumberFormat, [], program); return last.next; },
        330: function(last) {last.next = new Node(subToUpperCase, [], program); return last.next; },
        350: function(last) {last.next = new Node(subLinePrint, [], program); return last.next; },
        360: function(last) {last.next = new Node(subLineFeed, [], program); return last.next; },
        400: function(last) {
            last.next = new Node(subTone, [], program);
            last.next.next = new Wait(function waitForTone() { return !program.speaker.isBusy(); });
            return last.next.next;
        },
        450: function(last) {
            last.next = new Node(subSetTimer, [], program);
            last.next.next = new Wait(function waitForKeyWithTimeout() { return (program.input.keyPressed() || program.timer.elapsed()); });
            last.next.next.next = new Node(subReadKeyGetTimer, [], program);
            return last.next.next.next;
        },
        500: function(last) {last.next = new Node(subOpen, [], program); return last.next; },
        540: function(last) {last.next = new Node(subReadFile, [], program); return last.next; },
        560: function(last) {last.next = new Node(subWriteFile, [], program); return last.next; },
        580: function(last) {last.next = new Node(subClose, [], program); return last.next; },
        600: function(last) {last.next = new Node(subClearScreen, [], program); return last.next; },
        620: function(last) {last.next = new Node(subPlot, [], program); return last.next; },
        630: function(last) {last.next = new Node(subDraw, [], program); return last.next; },
        650: function(last) {last.next = new Node(subText, [], program); return last.next; },
        // GOSUB 950 (unofficial) same as GOTO 950
        950: function(last) {last.next = new End(); return last.next; },
    }

    this.parseIf = function(token, last)
    // parse IF
    {
        var condition = this.parseExpression();
        var node = new Conditional(condition);
        last.next = node;
        var then = expr_list.shift()
        if (then.token_type !== 'statement' || (then.payload !== 'THEN' && then.payload !== 'GOTO')) {
            throw new BasicError('Syntax error', 'expected `THEN`, got `'+then.payload+'`', current_line);
        }
        // supply a GOTO if jump target given after THEN
        var jump = expr_list[0]
        if (jump.token_type === 'literal') {
            expr_list.unshift(KEYWORDS['GOTO']());
        }
        node.branch = new Label('THEN');
        node.next = new Label('FI');
        expr_list.unshift(new SeparatorToken(':'));
        var end_branch = this.parse(node.branch, '\n');
        end_branch.next = node.next;
        // give back the separator so the next line parses correctly
        expr_list.unshift(new SeparatorToken('\n'));
        // merge branch back into single node
        return node.next;
    }

    this.parseOn = function(token, last)
    // parse ON jumps
    {
        var condition = this.parseExpression();
        var jump = expr_list.shift();
        if (jump.token_type !== 'statement' || (jump.payload !== 'GOTO' && jump.payload !== 'GOSUB')) {
            throw new BasicError('Syntax error', 'expected `GOTO` or `GOSUB`, got `'+jump.payload+'`', current_line);
        }
        var is_sub = false;
        // target for RETURN and switch fallthrough
        var label = new Label('NO');
        var nodes = [];
        while (expr_list.length) {
            // create jump node of the right kind, and attach to a dummy object
            var node = PARSERS[jump.payload].call(this, jump, {})
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

    this.parseFor = function(token, last)
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
        var start = this.parseExpression();
        var to = expr_list.shift();
        if (to.token_type !== 'statement' || to.payload !== 'TO') {
            throw new BasicError('Syntax error', 'expected `TO`, got `'+to.payload+'`', current_line);
        }
        var stop = this.parseExpression();
        var step = expr_list.shift();
        if (step.token_type !== 'statement' || step.payload !== 'STEP') {
            expr_list.unshift(step);
            step = new Literal(1);
        }
        else {
            step = this.parseExpression();
        }
        // loop init
        last.next = new For(loop_variable, start, stop, step, program);
        last = last.next;
        // keep track of for loops while parsing
        for_stack.unshift(loop_variable);
        // parse body of FOR loop until NEXT is encountered
        last = this.parse(last, 'NEXT');
        // parse NEXT
        var next = this.parseNext(expr_list.shift(), last);
        // pop the varible off the FOR stack
        for_stack.shift();
        return next;
    }

    this.parseNext = function(token, last)
    // regular NEXT is handled by FOR parser
    // if we encounter it unexpectedly, this is where we get
    {
        if (token === undefined || token === null || token.payload !== 'NEXT') {
            throw new BasicError('Block error', '`FOR` without `NEXT`', current_line);
        }
        // only one variable allowed
        var next_variable = expr_list.shift();
        // accept missing variable name (formally not allowed)
        if (next_variable.token_type !== 'name') {
            expr_list.unshift(next_variable);
        }
        else if (for_stack[0] !== next_variable.payload) {
            throw new BasicError('Block error', 'expected `NEXT `'+loop_variable+'`, got `NEXT ' + next_variable.payload + '`', current_line);
        }
        // create the iteration node
        last.next = new Next(for_stack[0], program);
        // replace NEXT J,I with NEXT J: NEXT I
        if (expr_list[0].token_type === ',') {
            expr_list.shift();
            expr_list.unshift(KEYWORDS['NEXT']());
            expr_list.unshift(new SeparatorToken(':'));
        }
        return last.next;
    },

    this.parseInput = function(token, last)
    // parse INPUT
    {
        var prompt = ' ?';
        // allow a prompt string literal
        if ((expr_list[0].token_type === 'literal') && (typeof expr_list[0].payload === 'string')) {
            prompt = expr_list.shift().payload;
            var semicolon = expr_list.shift();
            if (semicolon.token_type !== ';') {
                throw new BasicError('Syntax error', 'expected `;`, got `'+semicolon.payload+'`', current_line);
            }
        }
        // prompt
        last.next = new Node(stPrint, [new Literal('? ')], program);
        last = last.next;
        do {
            var name = expr_list.shift();
            if (name.token_type !== 'name') {
                throw new BasicError('Syntax error', 'expected variable name, got `' + name.payload + '`', current_line);
            }
            var indices = this.parseArguments();
            // wait for ENTER keypress before engaging
            last.next = new Wait(function() { return program.input.interact(program.output); });
            // do not retrieve the variable, just get its name
            last.next.next = new Node(stInput, [new Literal(name.payload)].concat(indices), program);
            last = last.next.next;
            var comma = null;
            if (expr_list[0].token_type === ',') comma = expr_list.shift();
        } while (comma);
        return last;
    }

    this.parseDefFn = function(token, last)
    // parse DEF FN statement
    {
        var fn = expr_list.shift();
        if (fn.token_type !== 'function' || fn.payload !== 'FN') {
            throw new BasicError('Syntax error', 'expected `FN`, got `'+fn.payload+'`', current_line);
        }
        var name = expr_list.shift();
        if (name.token_type !== 'name') {
            throw new BasicError('Syntax error', 'expected function name, got `' + name.payload + '`', current_line);
        }
        var token = expr_list.shift();
        if (token.token_type !== '(') {
            throw new BasicError('Syntax error', 'expected `(`, got `'+token.payload+'`', current_line);
        }
        var arg = expr_list.shift();
        if (name.token_type !== 'name') {
            throw new BasicError('Syntax error', 'expected parameter name, got `' + arg.payload + '`', current_line);
        }
        var token = expr_list.shift();
        if (token.token_type !== ')') {
            throw new BasicError('Syntax error', 'expected `)`, got `'+token.payload+'`', current_line);
        }
        var equals = expr_list.shift().payload;
        if (equals !== '=') throw new BasicError('Syntax error', 'expected `=`, got `'+equals+'`', current_line);
        var expr = this.parseExpression(arg.payload, name.payload);
        program.fns.store(name.payload, arg, expr);
        return last;
    }

    this.parseRestore = function(token, last)
    // parse RESTORE
    {
        last.next = new Node(token.operation, [], program);
        return last.next;
    }

    this.parseReturn = function(token, last)
    // parse RETURN
    {
        last.next = new Return(program);
        return last.next;
    }

    this.parseEnd = function(token, last)
    // parse END
    {
        last.next = new End();
        return last.next;
    }

    this.parseRun = function(token, last)
    // parse RUN
    {
        last.next = new Run();
        return last.next;
    }

    var PARSERS = {
        'DATA': this.parseData,
        'DIM': this.parseRead,
        'FOR': this.parseFor,
        'GOSUB': this.parseGosub,
        'GOTO': this.parseGoto,
        'IF': this.parseIf,
        'INPUT': this.parseInput,
        'LET': this.parseLet,
        'NEXT': this.parseNext,
        'ON': this.parseOn,
        'PRINT': this.parsePrint,
        'READ': this.parseRead,
        'REM': this.parseRem,
        'RESTORE': this.parseRestore,
        'RETURN': this.parseReturn,
        'END': this.parseEnd,
        'STOP': this.parseEnd,
        'RUN': this.parseRun,
        'DEF': this.parseDefFn,
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
        if (this.pointer < this.vault.length) return this.vault[this.pointer++];
        else throw new BasicError('Out of Data', '', null);
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
            //throw new BasicError('Subscript out of range', 'array was not dimensioned', null);
            // auto-dim array at 10 for each index
            var new_indices = [];
            for (var i=0; i < indices.length; ++i) {
                new_indices.push(10);
            }
            console.log('Auto-allocating array '+name+' with '+new_indices.length+' indices.');
            this.allocate(name, new_indices);
        }
        else if (indices.length !== this.dims[name].length) {
            throw new BasicError('Subscript out of range' , 'expected '+this.dims[name].length+' indices, got '+indices.length, null);
        }
        else {
            for (var i=0; i < indices.length; ++i) {
                if (indices[i] < 0 || indices[i] > this.dims[name][i]) {
                    throw new BasicError('Subscript out of range', 'indices '+indices+' out of bounds '+this.dims[name], null);
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
            this.arrays[name][Math.round(indices[0])] = value;
        }
        else {
            this.arrays[name][Math.round(indices[0])][Math.round(indices[1])] = value;
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
            return this.arrays[name][Math.round(indices[0])];
        }
        else {
            return this.arrays[name][Math.round(indices[0])][Math.round(indices[1])];
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
    }

    this.evaluate = function(name, arg_value)
    {
        this.args[name] = arg_value;
        return this.exprs[name].evaluate();
    }

    this.clear();
}


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// operations, statements, functions

// we set `this` to the current program state upon calling these

function opMultiply(x, y)
{
    return x * y;
}

function opDivide(x, y)
{
    return x / y;
}

function opPlus(x, y)
// + adds numbers or concatenates strings; unary plus leaves unchanged
{
    if (y === undefined) return x; else return x + y;
}

function opMinus(x, y)
// - can be unary negation or binary subtraction
{
    if (y === undefined) return -x; else return x - y;
}

function opEqual(x, y)
{
    return -(x === y);
}

function opGreaterThan(x, y)
{
    return -(x > y);
}

function opGreaterThanOrEqual(x, y)
{
    return -(x >= y);
}

function opLessThan(x, y)
{
    return -(x < y);
}

function opLessThanOrEqual(x, y)
{
    return -(x <= y);
}

function opNotEqual(x, y)
{
    return -(x !== y);
}

function opAnd(x, y)
{
    return (x & y);
}

function opNot(x)
{
    return (~x);
}

function opOr(x, y)
{
    return (x | y);
}

function opRetrieveParameter(fn_name)
// retrieve the user function parameter (only one allowed, no arrays)
{
    return this.fns.args[fn_name];
}

function opRetrieve(name)
//  retrieve a variable from the Variables object in program (this)
{
    var indices = [].slice.call(arguments, 1);
    var value = this.variables.retrieve(name, indices);
    return value;
}

function fnTab(x)
// set column to a given position during PRINT
// outside of PRINT, this is not allowed
// but we're not throwing any errors
{
    this.output.setColumn(x);
    return '';
}

function fnAsc(x)
{
    return x.charCodeAt(0);
}

function fnMid(x, start, n)
{
    if (n === undefined) return x.slice(start-1);
    else return x.slice(start-1, start+n-1);
}

function fnLeft(x, n)
{
    return x.slice(0, n);
}

function fnRight(x, n)
{
    return x.slice(-n);
}

function fnLen(x, n)
{
    return x.length;
}

function fnVal(x)
{
    return new Lexer(x).readValue();
}

function fnFn(name, x)
{
    return this.fns.evaluate(name, x);
}


///////////////////////////////////////////////////////////////////////////////
// statements


function stLet(value, name)
// LET
{
    var indices = [].slice.call(arguments, 2);
    this.variables.assign(value, name, indices);
}

function stDim(name)
// DIM
{
    var indices = [].slice.call(arguments, 1);
    this.variables.allocate(name, indices);
}

function stPrint(value)
// PRINT value;
{
    if (typeof value === 'string') {
        this.output.write(value);
    }
    else if (value < 0) {
        this.output.write(value.toString(10) + ' ');
    }
    else {
        this.output.write(' ' + value.toString(10) + ' ');
    }
}

function stRestore()
// RESTORE
{
    this.data.restore();
}

function stRead(name)
// READ
{
    var indices = [].slice.call(arguments, 1);
    var value = this.data.read()
    this.variables.assign(value, name, indices);
}

function stInput(name)
// INPUT
{
    var indices = [].slice.call(arguments, 1);
    var value = this.input.readLine();
    if (name.slice(-1) !== '$') {
        // convert string to number
        // note that this will currently simply return 0 if it can't convert
        // no 'Redo from start'
        value = new Lexer(value).readValue();
    }
    this.variables.assign(value, name, indices);
}


///////////////////////////////////////////////////////////////////////////////
// BASICODE subroutines and jumps

function subClear()
// GOTO 20
// clear variables
{
    this.clear();
    // basicode-3
    this.variables.assign(this.output.width - 1, 'HO', []);
    this.variables.assign(this.output.height - 1, 'VE', []);
    this.variables.assign(this.output.pixel_width, 'HG', []);
    this.variables.assign(this.output.pixel_height, 'VG', []);
    // basicode-3c
    this.variables.allocate('CC', [10]);
    this.variables.assign(7, 'CC', [0]);
    this.variables.assign(0, 'CC', [1]);
}

function subClearScreen()
// GOSUB 100, GOSUB 600
// 600 Switch to graphic screen and clear graphic screen
{
    subSetColour.call(this);
    this.output.clear();
}

function subSetPos()
// GOSUB 110
{
    this.output.setColumn(Math.round(this.variables.retrieve('HO', [])));
    this.output.setRow(Math.round(this.variables.retrieve('VE', [])));
}

function subGetPos()
// GOSUB 120
{
    this.variables.assign(this.output.col, 'HO', []);
    this.variables.assign(this.output.row, 'VE', []);
}

function subWriteBold()
// GOSUB 150
{
    subSetColour.call(this);
    var text = '  ' + this.variables.retrieve('SR$', []) + '  ';
    this.output.write(' ');
    this.output.invertColour();
    this.output.write(text);
    this.output.invertColour();
    this.output.write(' ');
}

function subReadKey()
// GOSUB 200, GOSUB 210 (after wait)
{
    // GOSUB 200 should hold only capitals in IN$ and IN
    var keyval = this.input.readKey();
    var cn_keyval = 0;
    var key = '';
    if ((keyval >= 32 && keyval <= 126) || keyval === 13) {
        key = String.fromCharCode(keyval);
        keyval = key.toUpperCase().charCodeAt(0);
        cn_keyval = keyval;
        if (key >= 'A' && key <= 'Z') {
            cn_keyval = key.toLowerCase().charCodeAt(0);
        }
        key = key.toUpperCase();
    }
    // IN$ and IN return capitalised key codes
    // special keys generate a code in IN but not IN$
    this.variables.assign(keyval, 'IN', []);
    this.variables.assign(key, 'IN$', []);
    // in BC-3c, CN contains the character code of the lowercase letter
    // if an uppercase key was entered, and vice versa
    //FIXME: we sould be able to switch this off for BC-2 and BC-3 programs
    //this.variables.assign(cn_keyval, 'CN', []);
}

function subSetTimer()
// GOSUB 450 (with subReadKeyGetTimer)
{
    var deciseconds = this.variables.retrieve('SD', []);
    this.timer.set(deciseconds * 100);
}

function subReadKeyGetTimer()
// GOSUB 450 (with subSetTimer)
// Wait SD*0.1 seconds or for a key stroke
// When ended: IN$ and IN contain the possible keystroke (see for special codes line 200).
// SD contains the remaining time from the moment the key was pressed or zero (if no key was pressed)
{
    subReadKey.apply(this);
    var milliseconds = this.timer.remaining();
    this.variables.assign(milliseconds/100, 'SD', []);
}

function subReadChar()
// GOSUB 220
{
    var col = this.variables.retrieve('HO', []);
    var row = this.variables.retrieve('VE', []);
    var ch = this.output.getScreenChar(row, col);
    this.variables.assign(ch.charCodeAt(0), 'IN', []);
}

function subBeep()
// GOSUB 250
{
    this.speaker.sound(440, 0.1, 1);
}

function subTone()
// GOSUB 400
//400 Produce a tone using SP, SD and SV
//    SP is frequency level: 0 = lowest, 60='central C', 127 = highest
//    SD is the tone duration in steps of 0.1 seconds
//    SV is the volume: 0=muted 7=medium, 15=loud
//    This subroutine keeps running during the time of SD.
{
    var freq = this.variables.retrieve('SP', []);
    var dur = this.variables.retrieve('SD', []);
    var vol = this.variables.retrieve('SV', []);
    freq = (freq===0)?0: Math.exp(freq*0.057762 + 2.10125);
    this.speaker.sound(freq, dur*0.1, vol/15.);
}

function subRandom()
// GOSUB 260
{
    this.variables.assign(Math.random(), 'RV', []);
}

function subFree()
// GOSUB 270
{
    // theoretically, we should garbage-collect and return free memory
    // but let's just return some largeish (for BASICODE) number of bytes
    this.variables.assign(65536, 'FR', []);
}

function subToggleBreak()
// GOSUB 280
// 280 Disable the stop/break key (FR=1) or enable or (FR=0).
{
    this.input.suppress_break = true;
}

function subNumberToString()
// GOSUB 300
{
    var num = this.variables.retrieve('SR', []);
    this.variables.assign(num.toString(10), 'SR$', []);
}

function subNumberFormat()
// GOSUB 310
// 310 Convert number SR to string with a string length of CT and with CN places after decimal point; returned in SR$,
{
    var num = this.variables.retrieve('SR', []);
    var len = this.variables.retrieve('CT', []);
    var decimals = this.variables.retrieve('CN', []);
    var str = num.toFixed(decimals);
    if (str.length > len) {
        // too long; replace with stars
        str = '*'.repeat(len);
    }
    else if (str.length < len) {
        // left-pad with spaces
        str = ' '.repeat(len-str.length) + str;
    }
    this.variables.assign(str, 'SR$', []);
}

function subToUpperCase()
// GOSUB 330
// 330 Convert all letters in SR$ to capital letters
{
    var str = this.variables.retrieve('SR$', []);
    this.variables.assign(str.toUpperCase(), 'SR$', []);
}

function subLinePrint()
// GOSUB 350
// 350 Print SR$ on the printer.
{
    var text = this.variables.retrieve('SR$', []);
    this.printer.write(text);
}

function subLineFeed()
// GOSUB 360
// 360 Carriage return and line feed on the printer.
{
    this.printer.write('\n');
}

function subOpen()
// GOSUB 500
/*
Open the file NF$ according to the code in NF:
NF = even number: input: NF= uneven number: output
    NF= 0 or 1 BASICODE cassette
    NF= 2 or 3 own system memory
    NF= 4 or 5 diskette
    NF= 6 or 7 diskette
    IN=0: all OK, IN=1: end of file, IN=-1: error
*/
{
    var nf = this.variables.retrieve('NF', []);
    var name = this.variables.retrieve('NF$', []);
    var mode = (nf%2) ? 'w' : 'r';
    var device = Math.floor(nf/2);
    var status = this.storage[device].open(name, mode) ? 0 : -1;
    this.variables.assign(status, 'IN', []);
}

function subClose()
// GOSUB 540
// Read into IN$ from the opened file NF$ (in IN the status, see line 500)
{
    var nf = this.variables.retrieve('NF', []);
    var device = Math.floor(nf/2);
    var status = this.storage[device].close() ? 0 : -1;
    this.variables.assign(status, 'IN', []);
}

function subReadFile()
// GOSUB 560
// Send SR$ towards the opened file NF$ (in IN the status, see line 500)
{
    var nf = this.variables.retrieve('NF', []);
    var device = Math.floor(nf/2);
    var status = 0;
    var str = '';
    try {
        str = this.storage[device].readLine();
        if (str === null) {
            status = 1;
            str = '';
        }
    }
    catch (e) {
        if (typeof e !== 'string') throw e;
        status = -1;
    }
    this.variables.assign(status, 'IN', []);
    this.variables.assign(str, 'IN$', []);
}

function subWriteFile()
// GOSUB 580
// Close the file with code NF
{
    var nf = this.variables.retrieve('NF', []);
    var device = Math.floor(nf/2);
    var status = 0;
    var str = this.variables.retrieve('SR$', []);
    try {
        this.storage[device].writeLine(str);
    }
    catch (e) {
        if (typeof e !== 'string') throw e;
        status = -1;
    }
    this.variables.assign(status, 'IN', []);
}

function subPlot()
// GOSUB 620
// Plot a point at graphic position HO,VE (0<=HO<1 en 0<=VE<1) in fore/background color CN (=0/1; normally white/black)
{
    subSetColour.call(this);
    var x = this.variables.retrieve('HO', []);
    var y = this.variables.retrieve('VE', []);
    var c = this.variables.retrieve('CN', []);
    this.output.plot(x, y, c);
}

function subDraw()
// GOSUB 630
// Draw a line towards point HO,VE (0<=HO<1 en 0<=VE<1) in fore/background color CN (=0/1; normally white/black)
{
    subSetColour.call(this);
    var x = this.variables.retrieve('HO', []);
    var y = this.variables.retrieve('VE', []);
    var c = this.variables.retrieve('CN', []);
    this.output.draw(x, y, c);
}

function subText()
// GOSUB 650
// Print SR$ as text from graphic position HO,VE (0<=HO<1 en 0<=VE<1). HO and VE stay the same value.
{
    subSetColour.call(this);
    var x = this.variables.retrieve('HO', []);
    var y = this.variables.retrieve('VE', []);
    var text = this.variables.retrieve('SR$', []);
    var c = this.variables.retrieve('CN', []);
    this.output.drawText(x, y, c, text);
}

function subSetColour()
{
    var COLOURS = {
        0: 'black',
        1: 'blue',
        2: 'red',
        3: 'violet',
        4: 'green',
        5: 'lightblue',
        6: 'yellow',
        7: 'white',
    }

    var fg = this.variables.retrieve('CC', [0]);
    var bg = this.variables.retrieve('CC', [1]);
    this.output.foreground = COLOURS[fg];
    this.output.background = COLOURS[bg];
}


///////////////////////////////////////////////////////////////////////////////
// screen

function Display(output_element)
{
    // only allow one program to connect at a time
    this.busy = false;

    this.width = 40;
    this.height = 24;
    this.foreground = 'white';
    this.background = 'black';
    // number of ticks in a cursor cycle
    this.cursor_ticks = 640/IDLE_DELAY;

    // resize the canvas to fit the font size
    var context = output_element.getContext('2d');
    var font_height = 24;
    context.font = font_height+'px monospace';
    var measures = context.measureText('M');
    var font_width = measures.width;
    output_element.width = measures.width*this.width;
    output_element.height = font_height*this.height;
    this.pixel_width = output_element.width;
    this.pixel_height = output_element.height;

    // set the context on the resized canvas
    context = output_element.getContext('2d');
    context.font = 'normal lighter '+font_height+'px monospace';


    this.acquire = function(do_run)
    // acquire this interface, after the previous user released it
    {
        this.busy = true;
    }

    this.release = function()
    // release this interface
    {
        this.busy = false;
        this.curtain();
        this.resetColours();
    }

    this.resetColours = function()
    {
        this.foreground = 'white';
        this.background = 'black';
    }

    this.clear = function() {
        this.resetColours();
        context.fillStyle = this.background;
        context.fillRect(0, 0, output_element.width, output_element.height);
        this.row = 0;
        this.col = 0;
        this.content = (' '.repeat(this.width)+'\n').repeat(this.height).split('\n');
        //graphics
        this.last_x = 0;
        this.last_y = 0;
    }

    this.clearRow = function(row) {
        context.fillStyle = this.background;
        context.fillRect(0, row*font_height, output_element.width, font_height);
        this.content[row] = ' '.repeat(this.width);
    }

    this.curtain = function()
    {
        context.fillStyle = 'rgba(225,225,225,0.25)';
        context.fillRect(0, 0, output_element.width, output_element.height);
    }

    this.scroll = function()
    {
        context.drawImage(output_element,
            0, font_height, this.pixel_width, this.pixel_height-font_height,
            0, 0, this.pixel_width, this.pixel_height-font_height);
        context.fillStyle = this.background;
        context.fillRect(0, this.pixel_height-font_height, this.pixel_width, font_height);
        this.content = this.content.slice(1).concat(' '.repeat(this.width));
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
        if (this.row >= this.height) {
            this.scroll();
            this.row = this.height-1;
        }
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
        this.clearText(this.col*font_width, this.row*font_height, char);
        this.putText(this.col*font_width, this.row*font_height, 0, char);
        // update content buffer
        this.content[this.row] = this.content[this.row].slice(0, this.col) + char + this.content[this.row].slice(this.col+1);
    }

    this.clearText = function(x, y, output)
    // x,y are (approximate) top left corner of text box, not baseline
    {
        context.fillStyle = this.background;
        context.fillRect(x-0.5, y-0.5, output.length*font_width+0.5, font_height+0.5);
    }

    this.putText = function(x, y, c, output)
    // x,y are (approximate) top left corner of text box, not baseline
    {
        context.fillStyle = (c===0) ? this.foreground : this.background;
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
        if (this.row >= this.height) {
            this.scroll();
            this.row = this.height-1;
        }
    }

    this.setRow = function(row)
    {
        this.row = row;
        if (this.row >= this.height) {
            this.scroll();
            this.row = this.height-1;
        }
    }

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

    this.drawText = function(x, y, c, text)
    {
        var pixel_x = x*output_element.width;
        var pixel_y = y*output_element.height;
        this.putText(pixel_x, pixel_y, c, text);
    }

    // initialise
    this.clear();
}


///////////////////////////////////////////////////////////////////////////////
// keyboard

function Keyboard(input_element)
{
    // JavaScript to BASICODE keycode dictionary
    var KEYS = {
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

    var self = this;

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

    // Break key combination has been pressed
    this.break_flag = false;

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
        output.cursor();
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
        if (print_element.textContent) {
            print_iframe.contentWindow.print();
            print_element.textContent = '';
        }
    }
}


///////////////////////////////////////////////////////////////////////////////
// speaker

function Speaker()
// tone generator
{
    var context = new AudioContext();
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
        if (this.open_mode !== 'r') throw 'File not open for read';
        if (this.open_line >= this.open_file.length) return null;
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

var BUSY_DELAY = 1;
var IDLE_DELAY = 60;
// minimum delay (nested delays are 'clamped' by the browser)
var MIN_DELAY = 4;


function BasicodeApp(script)
{
    // create a canvas to work on
    var element = document.createElement('canvas');
    element.className = 'basicode';
    document.body.insertBefore(element, script);

    // make canvas element focussable to catch keypresses
    element.tabIndex = 1;
    element.focus();

    // set up emulator
    this.display = new Display(element);
    this.keyboard = new Keyboard(element);
    this.printer = new Printer();
    this.speaker = new Speaker();
    this.timer = new Timer();
    this.storage = [new Floppy(0), new Floppy(1), new Floppy(2), new Floppy(3)]

    // runtime members
    this.program = null;
    this.running = null;

    var app = this;

    this.handleError = function(e)
    {
        this.stop();
        this.display.invertColour();
        this.display.clearRow(0);
        this.display.setRow(0);
        this.display.setColumn(0);
        if (e instanceof BasicError) {
            this.display.write(e.message);
            var ln = e.where;
            if ((ln === undefined || ln === null) && this.program !== null) ln = this.program.current_line;
            this.display.write(' in '+ ln +'\n');
            this.display.invertColour();
            if (e.detail) {
                this.display.clearRow(1);
                this.display.clearRow(2);
                this.display.setColumn(0);
                this.display.setRow(1);
                this.display.write(e.detail);
            }
        }
        else {
            this.display.write('EXCEPTION\n')
            this.display.invertColour();
            this.display.clearRow(1);
            this.display.clearRow(2);
            this.display.setColumn(0);
            this.display.setRow(1);
            this.display.write(e);
            throw e;
        }
    }

    this.load = function(code)
    // load program, parse to AST, connect to output
    {
        // clear screen
        this.display.clear();
        // reset keyboard buffer
        this.keyboard.reset();
        try {
            // initialise program object
            this.program = new Program(code);
            this.program.attach(this);
            // show title and description
            this.show();
        } catch (e) {
            this.handleError(e);
        }
    }

    this.show = function()
    // show program title and description
    {
        this.display.invertColour();
        this.display.clearRow(0);
        this.display.writeCentre(0, this.program.title);
        this.display.write('\n\n');
        this.display.invertColour();
        this.display.write(this.program.description);
        this.display.invertColour();
        this.display.clearRow(this.display.height - 1);
        this.display.writeCentre(this.display.height - 1, '-- click to run --');
        this.display.invertColour();
        this.display.curtain();
    }

    this.splash = function()
    // intro screen if nothing was loaded
    {
        this.display.invertColour();
        this.display.clearRow(0);
        this.display.writeCentre(0, '(c) 2016, 2017 Rob Hagemans');
        this.display.invertColour();
        var row = 6;
        this.display.writeCentre(row++, '**. .*. .** .*. .** .*. **. ***');
        this.display.writeCentre(row++, '*.* *.* *.. .*. *.. *.* *.* *..');
        this.display.writeCentre(row++, '*.* *.* *.. .*. *.. *.* *.* *..');
        this.display.writeCentre(row++, '*.* *.* *.. .*. *.. *.* *.* *..');
        this.display.writeCentre(row++, '..**..***..*...*..*...*.*.*.*.**...');
        this.display.writeCentre(row++, '*.* *.* ..* .*. *.. *.* *.* *..');
        this.display.writeCentre(row++, '*.* *.* ..* .*. *.. *.* *.* *..');
        this.display.writeCentre(row++, '*.* *.* ..* .*. *.. *.* *.* *..');
        this.display.writeCentre(row++, '**. *.* **. .*. .** .*. **. ***');
        this.display.writeCentre(17, '---==[2017]==---');
        this.display.invertColour();
        this.display.clearRow(this.display.height - 1);
        this.display.writeCentre(this.display.height - 1, '-- drag and drop to load --');
        this.display.invertColour();
        this.display.curtain();
    }

    this.run = function()
    // execute the program
    {
        // exit if nothing loaded
        if (!this.program || this.program.tree === null) return;

        // clear screen
        this.display.clear();
        // reset keyboard buffer
        this.keyboard.reset();
        // reset program state
        this.program.clear();

        var current = this.program.tree;
        var delay = 0;

        function step() {
            try {
                while (true) {
                    if (current instanceof Label && typeof current.label === 'number') {
                        app.program.current_line = current.label;
                    }
                    if (current.delay) delay += current.delay;
                    current = current.step();
                    if (!current) {
                        app.stop();
                        break;
                    }
                    if (app.keyboard.break_flag) throw new BasicError('Break', '');
                    if (current && (delay >= MIN_DELAY)) {
                        app.running = window.setTimeout(step, delay);
                        delay = 0;
                        break;
                    }
                };
            } catch (e) {
                app.handleError(e);
            }
        }
        // get started
        this.running = window.setTimeout(step, MIN_DELAY);
    }

    this.stop = function()
    // release resources upon program end
    {
        if (this.running) window.clearTimeout(this.running);
        this.running = null;
        if (this.program !== null) {
            this.display.release();
            this.printer.flush();
        }
        this.display.invertColour();
        this.display.clearRow(this.display.height - 1);
        this.display.writeCentre(this.display.height - 1, '-- click to run again --');
        this.display.invertColour();
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
        if (!app.running) app.run();
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
