
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     Comment1 = 258,
     Comment2 = 259,
     CST = 260,
     IDF = 261,
     AND = 262,
     OR = 263,
     MainPrgm = 264,
     VAR = 265,
     BEGINPG = 266,
     ENDPG = 267,
     INT = 268,
     FLOAT = 269,
     IF = 270,
     THEN = 271,
     DO = 272,
     WHILE = 273,
     ELSE = 274,
     FOR = 275,
     FROM = 276,
     TO = 277,
     STEP = 278,
     INPUT = 279,
     OUTPUT = 280,
     DEFINE = 281,
     CONST = 282,
     LET = 283,
     ADD = 284,
     SUB = 285,
     MUL = 286,
     DIV = 287,
     AFFECT = 288,
     PVG = 289,
     INF = 290,
     SUP = 291,
     INFEG = 292,
     SUPEG = 293,
     EGAL = 294,
     DIFF = 295,
     PO = 296,
     PF = 297,
     ACCO = 298,
     ACCF = 299,
     UNDERSCORE = 300
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 14 "projetcompi.y"

    int val;
    char* str;
    char* type; // pour les types d’expression



/* Line 1676 of yacc.c  */
#line 105 "projetcompi.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


