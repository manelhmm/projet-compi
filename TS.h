<<<<<<< HEAD
=======


>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
#ifndef TS_H
#define TS_H

#define MAX_ENTITES 200

<<<<<<< HEAD
typedef struct {
=======
// Structure de la table des symboles
typedef struct
{
>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
   int state;
   char name[20];
   char code[20];
   char type[20];
   char val[20];
<<<<<<< HEAD
   int is_array;     // 0 = non, 1 = oui
   int array_size;   // taille si tableau
} TypeTS;

typedef struct { 
=======
} TypeTS;

// Structures des symboles pour les mots clés et séparateurs
typedef struct
{ 
>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
   int state; 
   char name[20];
   char type[20];
} TypeSM;

<<<<<<< HEAD
=======
// Déclaration des variables globales
>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
extern TypeTS TS[MAX_ENTITES];
extern TypeSM tabS[50], tabM[50];
extern int cpt, cpts, cptm;

<<<<<<< HEAD
void initialization();
void inserer(char entite[], char code[], char type[], char val[], int is_array, int array_size, int i, int y);
void Rechercher(char entite[], char code[], char type[], char val[], int y);
void afficher();

#endif
=======
// Déclaration des fonctions
void initialization();
void inserer(char entite[], char code[], char type[], char val[], int i, int y);
void Rechercher(char entite[], char code[], char type[], char val[], int y);
void afficher();

#endif // TS_H
>>>>>>> a9aea29cc2f697500da2c4f1a641b0a38ae3e4ec
