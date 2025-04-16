

#include "TS.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Initialisation des variables globales
TypeTS TS[200];
TypeSM tabS[50], tabM[50];
int cpt, cpts, cptm;

/* 1- Initialisation de la table des symboles */
void initialization()
{
  int i;
  for (i = 0; i < 200; i++) TS[i].state = 0;

  for (i = 0; i < 50; i++) {
    tabS[i].state = 0;
    tabM[i].state = 0;
  }
  cpt = 0;
  cpts = 0;
  cptm = 0;
}

/* 2- Fonction d'insertion des entités dans la table des symboles */
void inserer(char entite[], char code[], char type[], char val[], int i, int y)
{
  switch (y)
  { 
   case 1: // Insertion dans la table des IDF et CONST
     TS[i].state = 1;
     strcpy(TS[i].name, entite);
     strcpy(TS[i].code, code);
     strcpy(TS[i].type, type);
     strcpy(TS[i].val, val);
     cpt++;
     break;

   case 2: // Insertion dans la table des mots clés
     tabM[i].state = 1;
     strcpy(tabM[i].name, entite);
     strcpy(tabM[i].type, code);
     cptm++;
     break;

   case 3: // Insertion dans la table des séparateurs
     tabS[i].state = 1;
     strcpy(tabS[i].name, entite);
     strcpy(tabS[i].type, code);
     cpts++;
     break;
  }
}

/* Fonction Rechercher : Vérifie si l'entité existe déjà dans la table des symboles */
void Rechercher(char entite[], char code[], char type[], char val[], int y) {
  int i;
  switch(y) {
    case 1: // IDF / CONST
      for (i = 0; i < 200; i++) {
        if (TS[i].state == 1 && strcmp(entite, TS[i].name) == 0)
          return; // Déjà présent
      }
      inserer(entite, code, type, val, cpt, 1);
      break;

    case 2: // Mots clés
      for (i = 0; i < 50; i++) {
        if (tabM[i].state == 1 && strcmp(entite, tabM[i].name) == 0)
          return;
      }
      inserer(entite, code, type, val, cptm, 2);
      break;

    case 3: // Séparateurs
      for (i = 0; i < 50; i++) {
        if (tabS[i].state == 1 && strcmp(entite, tabS[i].name) == 0)
          return;
      }
      inserer(entite, code, type, val, cpts, 3);
      break;
  }
}

/* Fonction d'affichage de la table des symboles */
void afficher()
{
  int i;

  printf("/***************Table des symboles IDF*************/\n");
  printf("____________________________________________________________________\n");
  printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
  printf("____________________________________________________________________\n");

  for (i = 0; i < cpt; i++) {
    if (TS[i].state == 1) {
      printf("\t|%11s |%12s | %12s | %12s\n", TS[i].name, TS[i].code, TS[i].type, TS[i].val);
    }
  }

  printf("\n/***************Table des symboles mots cles*************/\n");
  printf("_____________________________________\n");
  printf("\t| NomEntite |  CodeEntite | \n");
  printf("_____________________________________\n");

  for (i = 0; i < cptm; i++) {
    if (tabM[i].state == 1) {
      printf("\t|%10s |%12s | \n", tabM[i].name, tabM[i].type);
    }
  }

  printf("\n/***************Table des symboles separateurs*************/\n");
  printf("_____________________________________\n");
  printf("\t| NomEntite |  CodeEntite | \n");
  printf("_____________________________________\n");

  for (i = 0; i < cpts; i++) {
    if (tabS[i].state == 1) {
      printf("\t|%10s |%12s | \n", tabS[i].name, tabS[i].type);
    }
  }
}
