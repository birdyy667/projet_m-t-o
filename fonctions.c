#include "fonctions.h"

/* Comparer deux structures de données pour le tri */
int compare(const void *a, const void *b) {
  /* Conversion des pointeurs en structures de données */
  struct data *ia = (struct data *)a;
  struct data *ib = (struct data *)b;

  /* Comparaison des colonnes 1 */
  if (ia->col1 != ib->col1)
    return ia->col1 - ib->col1;
  /* Comparaison des colonnes 2 en cas d'égalité sur la colonne 1 */
  else
    return ia->col2 - ib->col2;
}

/* Trier les données d'un fichier CSV */
void sort_csv(const char *file_name) {
  /* Ouvrir le fichier */
  FILE *fp = fopen(file_name, "r");
  /* Vérifier l'ouverture */
  if (fp == NULL) {
    printf("Impossible d'ouvrir le fichier %s\n", file_name);
    return;
  }

  /* Initialiser le tableau de données */
  struct data *data_array = NULL;
  int i = 0, j = 0, k = 0, n = 0;
  char line[1024];

  /* Lire les données du fichier */
  while (fgets(line, 1024, fp)) {
    char *tmp = strdup(line);
    int col1 = atoi(strtok(tmp, ";"));
    int col2 = atoi(strtok(NULL, ";"));

    /* Vérifier les duplicatas */
    int duplicate = 0;
    for (j = 0; j < k; j++) {
      if (col1 == data_array[j].col1 && col2 == data_array[j].col2) {
        duplicate = 1;
        break;
      }
    }

    /* Ajouter les données uniques au tableau */
    if (!duplicate) {
      n++;
      data_array = realloc(data_array, n * sizeof(struct data));
      data_array[k].col1 = col1;
      data_array[k].col2 = col2;
      k++;
    }
    free(tmp);
  }

  /* Fermer le fichier */
  fclose(fp);

  /* Trier les données */
  qsort(data_array, k, sizeof(struct data), compare);

  /* Afficher les données triées */
  for (i = 0; i < k; i++)
    printf("%d;%d\n", data_array[i].col1, data_array[i].col2);

  /* Libérer la mémoire */
  free(data_array);
}
