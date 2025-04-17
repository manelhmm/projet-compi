

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "projetcompi.tab.h"
    #include "TS.h"
<<<<<<< HEAD
    #define ERROR -1 
=======
>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec

    void print_comment(const char* type, const char* text);
    int nb_ligne = 1;
    int col = 0;
%}

lettre     [a-zA-Z]
chiffre    [0-9]
tiret_bas  "_"
IDF        {lettre}({lettre}|{chiffre}|{tiret_bas}({lettre}|{chiffre}))*
cst        {chiffre}+
Comment1   "<"[ ]*"!-"([^\n]|-[^!]|![^>])*"-"[ ]*"!>"
Comment2   "{"[ ]*"--"([^-]|-[^-])*"--"[ ]*"}"

%%

<<<<<<< HEAD
{Comment1} { 
    printf("[Commentaire ligne] %s\n", yytext); 
    col += strlen(yytext); 
    return Comment1;  
}

{Comment2} {
    printf("[Commentaire multi-lignes] %s\n", yytext);
    col += strlen(yytext);
    return Comment2;
}


=======
{Comment1}         { printf("[Commentaire] Ligne %d: %s\n", nb_ligne, yytext); col += strlen(yytext); }
{Comment2}         { printf("[Commentaire multi-lignes] Ligne %d: %s\n", nb_ligne, yytext); col += strlen(yytext); }

>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
"MainPrgm"         { printf("[Mot-cle] MainPrgm\n"); Rechercher("MainPrgm", "MainPrgm", "", "", 2); return MainPrgm; }  
"BeginPg"          { printf("[Mot-cle] BeginPg\n"); Rechercher("BeginPg", "BEGINPG", "", "", 2); return BEGINPG; }
"AND"              { printf("[Mot-cle] AND\n"); Rechercher("AND", "AND", "", "", 2); col += 3; return AND; }
"OR"               { printf("[Mot-cle] OR\n"); Rechercher("OR", "OR", "", "", 2); col += 2; return OR; }
"Var"              { printf("[Mot-cle] Var\n"); Rechercher("Var", "VAR", "", "", 2); return VAR; }
"EndPg"            { printf("[Mot-cle] EndPg\n"); Rechercher("EndPg", "ENDPG", "", "", 2); return ENDPG; }
"Float"            { printf("[Mot-cle] Float\n"); Rechercher("Float", "FLOAT", "", "", 2); yylval.str = strdup(yytext); return FLOAT; }
"Int"              { printf("[Mot-cle] Int\n"); Rechercher("Int", "INT", "", "", 2); yylval.str = strdup(yytext); return INT; }

"if"               { printf("[Mot-cle] if\n"); Rechercher("if", "IF", "", "", 2); return IF; }
"then"             { printf("[Mot-cle] then\n"); Rechercher("then", "THEN", "", "", 2); return THEN; }
"do"               { printf("[Mot-cle] do\n"); Rechercher("do", "DO", "", "", 2); return DO; }
"while"            { printf("[Mot-cle] while\n"); Rechercher("while", "WHILE", "", "", 2); return WHILE; }
"else"             { printf("[Mot-cle] else\n"); Rechercher("else", "ELSE", "", "", 2); return ELSE; }
"for"              { printf("[Mot-cle] for\n"); Rechercher("for", "FOR", "", "", 2); return FOR; }
"from"             { printf("[Mot-cle] from\n"); Rechercher("from", "FROM", "", "", 2); return FROM; }
"to"               { printf("[Mot-cle] to\n"); Rechercher("to", "TO", "", "", 2); return TO; }
"step"             { printf("[Mot-cle] step\n"); Rechercher("step", "STEP", "", "", 2); return STEP; }
"input"            { printf("[Mot-cle] input\n"); Rechercher("input", "INPUT", "", "", 2); return INPUT; }
"output"           { printf("[Mot-cle] output\n"); Rechercher("output", "OUTPUT", "", "", 2); return OUTPUT; }
"@define"          { printf("[Mot-cle] @define\n"); Rechercher("@define", "DEFINE", "", "", 2); return DEFINE; }
"Const"            { printf("[Mot-cle] Const\n"); Rechercher("Const", "CONST", "", "", 2); return CONST; }
"let"              { printf("[Mot-cle] let\n"); Rechercher("let", "LET", "", "", 2); return LET; }

{cst} { 
    printf("[CONST] %s\n", yytext); 
    Rechercher(yytext, "CONST", "INTEGER", yytext, 1); 
    yylval.val = atoi(yytext); 
    col += strlen(yytext); 
    return CST; 
}

{IDF} {
    /* Vérification de la longueur maximale */
    if (strlen(yytext) > 14) {
<<<<<<< HEAD
        printf("Erreur ligne %d: Identifiant '%s' dépasse 14 caractères\n", nb_ligne, yytext);
        col += strlen(yytext);
        return ERROR;
=======
        printf("[Erreur] Ligne %d: Identifiant trop long '%s'\n", nb_ligne, yytext);
    }
    else {
        printf("[IDF] %s\n", yytext);  // Affichage de l'identifiant
        Rechercher(yytext, "IDF", "", "", 1);
>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
    }
    
    /* Vérification des tirets bas */
    if (yytext[strlen(yytext)-1] == '_') {
        printf("Erreur ligne %d: Identifiant '%s' ne peut terminer par un tiret bas\n", nb_ligne, yytext);
        col += strlen(yytext);
        return ERROR;
    }
    
    if (strstr(yytext, "__") != NULL) {
        printf("Erreur ligne %d: Identifiant '%s' contient des tirets bas consécutifs\n", nb_ligne, yytext);
        col += strlen(yytext);
        return ERROR;
    }
    
    /* Si tout est valide */
    printf("[IDF valide] %s\n", yytext); 
    Rechercher(yytext, "IDF", "", "", 1);
    yylval.str = strdup(yytext);
    col += strlen(yytext);
    return IDF;
}

":="               { printf("[Séparateur] :=\n"); Rechercher(":=", "AFFECT", "", "", 3); col += 2; return AFFECT; }
":"                { printf("[Séparateur] :\n"); Rechercher(":", "DP", "", "", 3); return ':'; }
";"                { printf("[Séparateur] ;\n"); Rechercher(";", "PVG", "", "", 3); col++; return PVG; }
"+"                { printf("[Opérateur] +\n"); Rechercher("+", "ADD", "", "", 3); col++; return ADD; }
"-"                { printf("[Opérateur] -\n"); Rechercher("-", "SUB", "", "", 3); col++; return SUB; }
"*"                { printf("[Opérateur] *\n"); Rechercher("*", "MUL", "", "", 3); col++; return MUL; }
"/"                { printf("[Opérateur] /\n"); Rechercher("/", "DIV", "", "", 3); col++; return DIV; }
"("                { printf("[Séparateur] (\n"); Rechercher("(", "PO", "", "", 3); col++; return PO; }
")"                { printf("[Séparateur] )\n"); Rechercher(")", "PF", "", "", 3); col++; return PF; }
"{"                { printf("[Séparateur] {\n"); Rechercher("{", "ACCO", "", "", 3); col++; return ACCO; }
"}"                { printf("[Séparateur] }\n"); Rechercher("}", "ACCF", "", "", 3); col++; return ACCF; }
"<"                { printf("[Opérateur] <\n"); Rechercher("<", "INF", "", "", 3); col++; return INF; }
">"                { printf("[Opérateur] >\n"); Rechercher(">", "SUP", "", "", 3); col++; return SUP; }
"<="               { printf("[Opérateur] <=\n"); Rechercher("<=", "INFEG", "", "", 3); col += 2; return INFEG; }
">="               { printf("[Opérateur] >=\n"); Rechercher(">=", "SUPEG", "", "", 3); col += 2; return SUPEG; }
"=="               { printf("[Opérateur] ==\n"); Rechercher("==", "EGAL", "", "", 3); col += 2; return EGAL; }
"!="               { printf("[Opérateur] !=\n"); Rechercher("!=", "DIFF", "", "", 3); col += 2; return DIFF; }
"_"                { printf("[Opérateur] _\n"); Rechercher("_", "UNDERSCORE", "", "", 3); col++; return UNDERSCORE; }

[ \t]              { col++; }  // Espaces et tabulations (pas de printf)
\n                 { nb_ligne++; col = 0; }  // Saut de ligne (pas de printf)
.                  { printf("[Erreur] Ligne %d: Caractère invalide '%s'\n", nb_ligne, yytext); col++; }

%%
void print_comment(const char* type, const char* text) {
    printf("[%s]\n%s\n", type, text);}
int yywrap(void) { return 1; }
