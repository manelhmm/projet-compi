flex projetcompi.l
bison -d -v projetcompi.y
gcc lex.yy.c projetcompi.tab.c TS.c -o projetcompi -lfl
projetcompi.exe < minisoftt.txt