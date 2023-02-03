#!/bin/bash

#Indication du nom du fichier .csv
datafile="data_altitude.csv"

#Indication des titres souhaite pour les axes et le titre du graphique
xlabel="stations"
ylabel="Altitude"
title="Altitude Plot"

#Indication du nom du fichier de sortie
outputfile="plot_altitude.png"

#Execution Gnuplot
gnuplot << EOF

#Definition des titres des axes et du titre du graphique
set xlabel "$xlabel" # Titre de l'axe des abscisses
set ylabel "$ylabel" # Titre de l'axe des ordonnees
set title "$title" # Titre du graphique

#Definition du format de sortie
set terminal png # Le format de sortie est PNG
set output "$outputfile" # Nom du fichier de sortie

#Trace du graphique a partir du fichier .csv
plot"$datafile" with lines# Tracer le graphique a partir des colonnes altitude et station du fichier .csv

quit # Quitter Gnuplot

EOF
# Ouverture du fichier PNG cree
xdg-open plot_altitude.png
