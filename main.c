#include "fonctions.h"

int main(int argc, char *tab[])
{
    // Vérifier le nombre d'arguments passés au programme
    if (argc != 2)
    {
        // Afficher un message d'aide si nécessaire
        printf("Usage: %s [option]\n", tab[0]);
        return 1;
    }

    // Comparer l'argument avec les différentes options possibles
    if (strcmp(tab[1], "data_temperature.csv") == 0)
    {
        // Afficher un message indiquant l'option choisie
        printf("Option sélectionnée : data_temperature.csv\n");
        
    }
    else if (strcmp(tab[1], "data_pression_atmo.csv") == 0)
    {
        // Afficher un message indiquant l'option choisie
        printf("Option sélectionnée : data_pression_atmo.csv\n");

    }
    else if (strcmp(tab[1], "data_vent.csv") == 0)
    {
        // Afficher un message indiquant l'option choisie
        printf("Option sélectionnée : data_vent.csv\n");

    }
    else if (strcmp(tab[1], "data_humidité.csv") == 0)
    {
        // Afficher un message indiquant l'option choisie
        printf("Option sélectionnée : data_humidité.csv\n");

    }
    else if (strcmp(tab[1], "data_altitude.csv") == 0)
    {
        // Afficher un message indiquant l'option choisie
        printf("Option sélectionnée : data_altitude.csv\n");
            printf("Usage: %s <csv_file>\n", tab[0]);
        sort_csv(tab[1]);
    }

    // Retourner 0 pour indiquer une sortie réussie
    return 0;
}