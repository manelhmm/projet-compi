flex projetcompi.l
gcc lex.yy.c -lfl -o projetcompi
projetcompi.exe < minisoftt.txt


flex projetcompi.l
bison -d projetcompi.y
gcc lex.yy.c projetcompi.tab.c -o projetcompi -lfl
projetcompi < minisoftt.txt
