#ifndef TS_H
#define TS_H

#define MAX_ENTITES 200

typedef struct {
   int state;
   char name[20];
   char code[20];
   char type[20];
   char val[20];
   int is_array;     // 0 = non, 1 = oui
   int array_size;   // taille si tableau
} TypeTS;

typedef struct { 
   int state; 
   char name[20];
   char type[20];
} TypeSM;

extern TypeTS TS[MAX_ENTITES];
extern TypeSM tabS[50], tabM[50];
extern int cpt, cpts, cptm;

void initialization();
void inserer(char entite[], char code[], char type[], char val[], int is_array, int array_size, int i, int y);
void Rechercher(char entite[], char code[], char type[], char val[], int y);
void afficher();

#endif
