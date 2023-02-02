#!/bin/bash

# Variables pour stocker les options
# Variables pour stocker les options et le nom de fichier
#Variable pour les vérifications des options

OPTIONS=""
OPTIONS_GEO=""
OPTIONS_TRI=""
FICHIER=""
FICHIER_S=""
nb_options=0
message_erreur=""
nb_options2=0
message_erreur2=""
nb_options3=0
nb_fichier=0

liste_options=":f:d:tpwmhFGSAPQO--tab--abr--avl"  #On stock toute les options qui sont possiblement présente dans une variable

# Boucle pour lire les options de la ligne de commande
while getopts "$liste_options"  opt; do
  case $opt in
    f)
      FICHIER="$OPTARG"
      ;;
    d)
      OPTIONS="$OPTIONS -d $OPTARG"
      ;;
    t)
      OPTIONS="$OPTIONS -t"
      awk -F ";" '{print $1 ";" $11 ";" $12 ";" $13}' $FICHIER > data_temperature.csv    #redirection des informations de sortie dans le fichier
      FICHIER_S="$FICHIER_S data_temperature.csv"     #on met le fichier temporaire dans une variable pour qu'il puisse étre traiter par le main
      ;;
    p)
      OPTIONS="$OPTIONS -p $OPTARG"
      awk -F ";" '{print $1 ";" $3 ";" $7 ";" "8"}' $FICHIER > data_pression_atmo.csv
      FICHIER_S="$FICHIER_S data_pression_atmo.csv"
      ;;
    w)
      OPTIONS="$OPTIONS -w"
      awk -F ";" '{print $1 ";" $4 ";" $5}' $FICHIER > data_vent.csv
      FICHIER_S="$FICHIER_S data_vent.csv"
      ;;
    m)
      OPTIONS="$OPTIONS -m"
      awk -F ";" '{print $1 ";" $6}' $FICHIER > data_humidité.csv
      FICHIER_S="$FICHIER_S data_humidité.csv"
      ;;
    h)
      OPTIONS="$OPTIONS -h"
      awk -F ";" '{print $1 ";" $14}' $FICHIER > data_altitude.csv
      FICHIER_S="$FICHIER_S data_altitude.csv"
      ;;
    F)
      OPTIONS_GEO="$OPTIONS_GEO -F"
      ;;
    G)
      OPTIONS_GEO="$OPTIONS_GEO -G"
      ;;
    S)
      OPTIONS_GEO="$OPTIONS_GEO -S"
      ;;
    A)
      OPTIONS_GEO="$OPTIONS_GEO -A"
      ;;
    P)
      OPTIONS_GEO="$OPTIONS_GEO -P"
      ;;
    Q)
      OPTIONS_GEO="$OPTIONS_GEO -Q"
      ;;
    --tab)
      OPTIONS_TRI="$OPTIONS_TRI --tab"
      ;;
    --abr)
      OPTIONS_TRI="$OPTIONS_TRI  --abr"
      ;;
    --avl)
      OPTIONS_TRI="$OPTIONS_TRI  --abl"
      ;;

    \?)
      echo "Option invalide : -$OPTARG" >&2  #Si l'option est invalide en revoie un message d'erreur et on arrète le programme
      exit 1
      ;;
    :)
      echo "L'option -$OPTARG requiert un argument." >&2 #Si les options qui necessitent un argument n'en ont pas alors on affiche un message d'erreur
      exit 1
      ;;
  esac
done


for option in -F -G -S -A -P -Q; do   #On créer une boucle for qui va scanner la variable OPTION
  if [[ "$OPTIONS_GEO" == *"$option"* ]]; then
    nb_options=$((nb_options + 1))  #Si on trouve plus d'une fois la une de ces variable alors un message d'erreur s'affichera
    if [[ $nb_options -gt 1 ]]; then
      message_erreur="Erreur seule une de ces options peut etre utilisée: -F -G -S -A -P -Q" #stockage du message en variable
      break
    fi
  fi
done

if [[ $nb_options -gt 1 ]]; then
  echo "$message_erreur" >&2 #affichage du message d'erreur 
  exit 1
fi

for option in --tab --abr --avl; do   #On parcours la variable OPTION
  if [[ "$OPTIONS_TRI" == *"$option"* ]]; then
    nb_options2=$((nb_options2 + 1))
    if [[ $nb_options2 -gt 1 ]]; then
      message_erreur2="Erreur: seule une de ces  options peuvent être utilisée: --tab --abr --avl" 
      break
    fi
  fi
done

if [[ $nb_options2 -gt 1 ]]; then
  echo "$message_erreur2" >&2 #On affiche un message d'erreur si plus d'une de ces trois options sont présente
  exit 1
fi


for option in --tab --abr --avl; do
  if [[ "$OPTIONS" == *"$option"* ]]; then
    nb_options3=$((nb_options3 + 1)) #Si aucune de ces options n'est choisi ajoute automatiquement l'option --avl dans la variable OPTION
  fi
done

if [[ $nb_options3 -eq 0 ]]; then
  OPTIONS_TRI="$OPTIONS_TRI --avl"
fi

# Vérifie si le fichier main existe, sinon le compile
if [ ! -f "main" ]; then
  make
fi

# Appelle l'executable main avec les options et le fichier
                            
while [ -n "$FICHIER_S" ]; do # Boucle jusqu'à ce que la variable FICHIER_S soit vide
                       
  fichier_tempo="${FICHIER_S%% *}"  #Récupération du premier nom de fichier
  FICHIER_S="${FICHIER_S#* }"  # Mise à jour de la variable FICHIER_S en enlevant le premier nom de fichier
  
  ./main "$fichier_tempo" "$OPTION_GEO" "$OPTION_TRI"
  # Vérification si la variable FICHIER_S a été mise à jour
  if [ "$FICHIER_S" = "${FICHIER_S#* }" ]; then
    # Si la variable FICHIER_S n'a pas été mise à jour, elle est vide
    # Interruption de la boucle
    break
  fi
done

echo Les options finale $OPTIONS $FICHIER_S $OPTION_GEO $OPTIONS_TRI