package Scanner;

import java_cup.runtime.Symbol;
import Parser.sym;

%%

%unicode
%class Lexical
%line
%column
%standalone
%ignorecase
%char
%cup
%public


%{
    public static String curLine;


  /**
   * Factory method for creating Symbols for a given type.
   * @param type The type of this symbol
   * @return A symbol of a specific type
   */
    public Symbol symbol(int type) {
        curLine = "line :" + yyline;
        return new Symbol(type, yyline, yycolumn);
    }
  
  /**
   * Factory method for creating Symbols for a given type and its value.
   * @param type The type of this symbol
   * @param value The value of this symbol
   * @return A symbol of a specific type
   */
    public Symbol symbol(int type, Object value) {
        curLine = "line :" + yyline;
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


LineTerminator = \r|\n|\r\n
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = [0-9]+


WhiteSpace     = {LineTerminator} | [ \t\f]

Printable      = [ -~]

Any            = [^] | \n

%state STRINGLITERAL, CHARLITERAL, STRING_RECOVER, CHAR_RECOVER, LONG_COMMENT, SHORT_COMMENT

%%

<YYINITIAL> {

	/* Control flow keywords */
	"if"    { return symbol(sym.IF, yytext()); }
	"else"  { return symbol(sym.ELSE, yytext()); }
	"while" { return symbol(sym.WHILE, yytext()); }
    "for" { return symbol(sym.FOR, yytext()); }


	/* Primitive type keywords */
	"boolean" { return symbol(sym.BOOLEAN, yytext()); }
	"int"     { return symbol(sym.INT, yytext()); }
	"char"    { return symbol(sym.CHAR, yytext()); }
	"string"  { return symbol(sym.STRING, yytext()); }

	/* Command keywords */
	"return" { return symbol(sym.RETURN, yytext()); }
	"print"  { return symbol(sym.PRINT, yytext()); }

	/* Boolean literals */
	"false" { return symbol(sym.FALSE, yytext()); }
	"true"  { return symbol(sym.TRUE, yytext()); }

	/* Identifiers */
	{Identifier} { return symbol(sym.IDENTIFIER, yytext()); }

	/* Integer literals */
	{Integer} { return symbol(sym.INT_LITERAL, yytext()); }

	/* Separators */
	"(" { return symbol(sym.LPAREN, yytext()); }
	")" { return symbol(sym.RPAREN, yytext()); }
	"{" { return symbol(sym.LBRACE, yytext()); }
	"}" { return symbol(sym.RBRACE, yytext()); }
	"," { return symbol(sym.COMMA, yytext()); }
	";" { return symbol(sym.SEMI, yytext()); }


	/* Operators */
	"+"  { return symbol(sym.ADD, yytext()); }
	"-"  { return symbol(sym.SUB, yytext()); }
	"*"  { return symbol(sym.STAR, yytext()); }
	"/"  { return symbol(sym.DIV, yytext()); }
	"!"  { return symbol(sym.NOT, yytext()); }
	"&&" { return symbol(sym.AND, yytext()); }
	"||" { return symbol(sym.OR, yytext()); }
	"==" { return symbol(sym.EQ, yytext()); }
	"!=" { return symbol(sym.NE, yytext()); }
	"<=" { return symbol(sym.LE, yytext()); }
	"<"  { return symbol(sym.LT, yytext()); }
	">=" { return symbol(sym.GE, yytext()); }
	">"  { return symbol(sym.GT, yytext()); }
	"="  { return symbol(sym.ASSIGN, yytext()); }
    "++"  { return symbol(sym.INCREMENT, yytext()); }
    "--"  { return symbol(sym.DECREMENT, yytext()); }


	/* String literal */
	\" { yybegin(STRINGLITERAL); }

	/* Character literal */
	\' { yybegin(CHARLITERAL); }

	/* Whitespace */
	{WhiteSpace} { /* ignore */ }

	/* Comments */
	"/*" { yybegin(LONG_COMMENT); }
	"//" { yybegin(SHORT_COMMENT); }
	"*/" {  }

	/* Any other illegal character. */
	{Any} { }

}

<STRINGLITERAL> {


	/* End of string literal */
	\"            { yybegin(YYINITIAL); return new Symbol(sym.STRING_LITERAL); }

	/* Escape sequences */
	\\n           {  }
	\\0           {  }
	\\{Printable} {  }

	/* Legal unescaped characters */
	{Printable}   { }

	/* Stray newline */
	{LineTerminator} { yybegin(YYINITIAL); }

	/* Other, illegal characters */
	{Any}         { yybegin(STRING_RECOVER); }

}

<CHARLITERAL> {

	/* End of char literal. */
	\'            { yybegin(YYINITIAL); }

	/* Escape sequences. */
	\\n           {  }
	\\0           { }
	\\{Printable} {  }

	/* Regular unescaped characters. */
	{Printable}   { }

	/* Illegal characters. */
	{Any}         { }

}

<STRING_RECOVER> {
	\"      { yybegin(YYINITIAL); }
	\\{Any} { /* Continue to respect escaped double-quotes, but do nothing. */ }
	{Any}   { /* Do nothing. */ }
}

<CHAR_RECOVER> {
	\'      { yybegin(YYINITIAL); }
	\\{Any} { }
	{Any}   { }
}

<LONG_COMMENT> {
	"*/"    { yybegin(YYINITIAL); }
	{Any}   { }
}

<SHORT_COMMENT> {
	{LineTerminator} { yybegin(YYINITIAL); }
	{Any}            { }
}
