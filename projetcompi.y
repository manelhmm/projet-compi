%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex();
    void yyerror(const char *s);
%}

%union {
    int val;
    char* str;
}

%token <val> CST
%token <str> IDF
%token AND OR
%token MainPrgrm VAR BEGINPG ENDPG
%token INT FLOAT
%token IF THEN DO WHILE ELSE
%token FOR FROM TO STEP
%token INPUT OUTPUT
%token DEFINE CONST LET
%token ADD SUB MUL DIV
%token AFFECT PVG
%token INF SUP INFEG SUPEG EGAL DIFF
%token PO PF ACCO ACCF

%start programme

%%

programme
    : MainPrgrm bloc ENDPG
    ;

bloc
    : BEGINPG instructions ENDPG
    ;

instructions
    : instructions instruction
    | instruction
    ;

instruction
    : declaration
    | affectation
    | boucle
    | condition
    | io
    ;

declaration
    : VAR IDF ':' type PVG
    ;

type
    : INT
    | FLOAT
    ;

affectation
    : IDF AFFECT expression PVG
    ;

expression
    : CST
    | IDF
    | expression ADD expression
    | expression SUB expression
    | expression MUL expression
    | expression DIV expression
    ;

boucle
    : WHILE expression DO bloc
    | FOR IDF FROM expression TO expression STEP expression DO bloc
    ;

condition
    : IF expression THEN bloc ELSE bloc
    ;

io
    : INPUT IDF PVG
    | OUTPUT IDF PVG
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur de syntaxe : %s\n", s);
}
