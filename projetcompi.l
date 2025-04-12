%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "projetcompi.tab.h"

    int nb_ligne = 1;
    int col = 0;
%}

lettre     [a-zA-Z]
chiffre    [0-9]
IDF        {lettre}({lettre}|{chiffre})*
cst        {chiffre}+
Comment1   "<!-"([^-]|-[^!]|--[^>])*"-!>"
Comment2   "\\{--"([^-]|-[^-]|[\r\n])*"--\\}"

%%

{Comment1}         { printf("Commentaire une seule ligne (Ligne %d)\n", nb_ligne); col += strlen(yytext); }
{Comment2}         { printf("Commentaire plusieurs lignes (Ligne %d)\n", nb_ligne); col += strlen(yytext); }

"AND"              { col += 3; return AND; }
"OR"               { col += 2; return OR; }
"MainPrgrm"        { col += strlen(yytext); return MainPrgrm; }
"Var"              { col += strlen(yytext); return VAR; }
"BeginPg"          { col += strlen(yytext); return BEGINPG; }
"EndPg"            { col += strlen(yytext); return ENDPG; }
"Int"              { col += strlen(yytext); return INT; }
"Float"            { col += strlen(yytext); return FLOAT; }
"if"               { col += strlen(yytext); return IF; }
"then"             { col += strlen(yytext); return THEN; }
"do"               { col += strlen(yytext); return DO; }
"while"            { col += strlen(yytext); return WHILE; }
"else"             { col += strlen(yytext); return ELSE; }
"for"              { col += strlen(yytext); return FOR; }
"from"             { col += strlen(yytext); return FROM; }
"to"               { col += strlen(yytext); return TO; }
"step"             { col += strlen(yytext); return STEP; }
"input"            { col += strlen(yytext); return INPUT; }
"output"           { col += strlen(yytext); return OUTPUT; }
"@define"          { return DEFINE; }
"Const"            { return CONST; }
"let"              { return LET; }

{IDF} {
    if (strlen(yytext) > 14) {
        printf("Erreur lexicale (ligne %d, colonne %d) : Identifiant '%s' dépasse 14 caractères\n", nb_ligne, col, yytext);
    }
    yylval.str = strdup(yytext);
    col += strlen(yytext);
    return IDF;
}

{cst}              { yylval.val = atoi(yytext); col += strlen(yytext); return CST; }

":="               { col += 2; return AFFECT; }
":"                 { return ':'; }
";"                { col++; return PVG; }
"+"                { col++; return ADD; }
"-"                { col++; return SUB; }
"*"                { col++; return MUL; }
"/"                { col++; return DIV; }
"("                { col++; return PO; }
")"                { col++; return PF; }
"{"                { col++; return ACCO; }
"}"                { col++; return ACCF; }
"<"                { col++; return INF; }
">"                { col++; return SUP; }
"<="               { col += 2; return INFEG; }
">="               { col += 2; return SUPEG; }
"=="               { col += 2; return EGAL; }
"!="               { col += 2; return DIFF; }
[ \t]              { col++; }
\n                 { nb_ligne++; col = 0; }
.                  { printf("Erreur lexicale à la ligne %d, colonne %d : caractère inconnu '%s'\n", nb_ligne, col, yytext); col++; }

%%

int yywrap() { return 1; }

int main() {
    return yyparse();
}
