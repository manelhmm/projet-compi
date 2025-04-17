

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "TS.h"

    int yylex();
    void yyerror(const char *s);
    int cpt = 0;
%}

%union {
    int val;
    char* str;
    char* type; // pour les types d’expression
}

%token <val> CST
%token <str> IDF
%token AND OR
%token MainPrgm VAR BEGINPG ENDPG
%token INT FLOAT
%token IF THEN DO WHILE ELSE
%token FOR FROM TO STEP
%token INPUT OUTPUT
%token DEFINE CONST LET
%token ADD SUB MUL DIV
%token AFFECT PVG
%token INF SUP INFEG SUPEG EGAL DIFF
%token PO PF ACCO ACCF UNDERSCORE comment1 comment2

%left OR
%left AND
%left EGAL
%left ADD SUB
%left MUL DIV

%start programme
%type <type> expression
%type <type> type
%%

programme
    : MainPrgm IDF ';' declaration bloc ENDPG ';'
    ;

bloc
    : BEGINPG commentaire instructions commentaire ENDPG
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
    : VAR IDF ':' type PVG {
        int i, existe = 0;
        for (i = 0; i < 200; i++) {
            if (TS[i].state == 1 && strcmp(TS[i].name, $2) == 0) {
                existe = 1;
                break;
            }
        }
        if (existe) {
            printf("Erreur sémantique: identifiant '%s' déjà déclaré\n", $2);
        } else {
            inserer($2, "IDF", $4, "", cpt++, 1);  // Incrémente cpt et passe-le à inserer
        }
    }
    |VAR commentaire;
;

commentaire
    : comment1
    | comment2
    ;

type
    : INT { $$ = strdup("INT"); }
    | FLOAT { $$ = strdup("FLOAT"); }
;

affectation
    : IDF AFFECT expression PVG {
        int i, found = 0;
        for(i = 0; i < 200; i++) {
            if (TS[i].state == 1 && strcmp(TS[i].name, $1) == 0) {
                found = 1;
                // vérifier type ici si $3 a un type (à définir dans l'union et les règles)
                break;
            }
        }
        if (!found) {
            printf("Erreur sémantique: identifiant '%s' utilisé sans déclaration.\n", $1);
        }
        if (found) {
            if (strcmp(TS[i].type, $3) != 0) {
                printf("Erreur sémantique: affectation incompatible. '%s' est de type %s mais l'expression est de type %s\n", 
                       $1, TS[i].type, $3);
            }
        }
        free($1);
        free($3);
    }
;

expression
    : CST {
        $$ = strdup("INT");
        // Supprimez free($1) car $1 est un entier, pas une chaîne
    }
    | IDF {
        int i, found = 0;
        for(i = 0; i < 200; i++) {
            if (TS[i].state == 1 && strcmp(TS[i].name, $1) == 0) {
                $$ = strdup(TS[i].type); // récupérer type de l'IDF
                found = 1;
                break;
            }
        }
        if (!found) {
            printf("Erreur sémantique: identifiant '%s' non déclaré\n", $1);
            $$ = strdup("UNDEFINED");
        }
        free($1);  // libère le nom de l'IDF
    }
    | expression ADD expression {
        if (strcmp($1, $3) != 0) {
            printf("Erreur sémantique: addition entre types incompatibles\n");
        }
        $$ = strdup($1);  // le résultat a le même type que l'expression
        free($1); free($3);
    }
    | expression SUB expression {
        if (strcmp($1, $3) != 0) {
            printf("Erreur sémantique: soustraction entre types incompatibles\n");
        }
        $$ = strdup($1);
        free($1); free($3);
    }
    | expression MUL expression {
        if (strcmp($1, $3) != 0) {
            printf("Erreur sémantique: multiplication entre types incompatibles\n");
        }
        $$ = strdup($1);
        free($1); free($3);
    }
    | expression DIV expression {
        if (strcmp($1, $3) != 0) {
            printf("Erreur sémantique: division entre types incompatibles\n");
        }
        $$ = strdup($1);
        free($1); free($3);
    }
;

boucle
  : WHILE expression DO bloc {
      if (strcmp($2, "BOOL") != 0) {
          printf("Erreur sémantique ligne %d: condition doit être booléenne\n", @2.first_line);
      }
      free($2);
    }
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
    extern int nb_ligne;
    extern int col;
    extern char *yytext;
    fprintf(stderr, "Erreur ligne %d, colonne %d: %s\nToken inattendu: '%s'\n", 
           nb_ligne, col, s, yytext);
}

int main() {
    initialization();
    int result = yyparse();
    afficher();  // Déplacé avant le return
    return result;


}
