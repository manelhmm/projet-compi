

#ifndef TS_H
#define TS_H

#define MAX_ENTITES 200

// Structure de la table des symboles
typedef struct
{
   int state;
   char name[20];
   char code[20];
   char type[20];
   char val[20];
} TypeTS;

// Structures des symboles pour les mots clés et séparateurs
typedef struct
{ 
   int state; 
   char name[20];
   char type[20];
} TypeSM;

// Déclaration des variables globales
extern TypeTS TS[MAX_ENTITES];
extern TypeSM tabS[50], tabM[50];
extern int cpt, cpts, cptm;

// Déclaration des fonctions
void initialization();
void inserer(char entite[], char code[], char type[], char val[], int i, int y);
void Rechercher(char entite[], char code[], char type[], char val[], int y);
void afficher();

#endif // TS_H
