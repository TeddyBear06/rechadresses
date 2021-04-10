#!/bin/bash

# On vide Redis
redis-cli -h redis FLUSHDB

# On créer l'index
redis-cli -h redis FT.CREATE idx:addr ON HASH PREFIX 1 addr: SCHEMA adresse TEXT PHONETIC "dm:fr"

# Permet de faire les opérations nécessaires pour remplir l'index
traiterDepartement () {
    # On récupère le fichier CSV
    wget https://adresse.data.gouv.fr/data/ban/adresses/latest/csv/adresses-$1.csv.gz
    # On le décompresse
    gunzip adresses-$1.csv.gz
    # On formate la donnée CSV pour être mangée par Redis
    awk -F ";" '{print "hset addr:"$1" adresse \"" $3 " " $5 " " $6 " " $8"\""}' adresses-$1.csv | redis-cli -h redis --pipe
    # On va créer un dictionnaire de suggestions
    awk -F ";" '{print "FT.SUGADD ac \"" $3 " " $5 " " $6 " " $8"\" 1 PAYLOAD \""$1"\""}' adresses-$1.csv | redis-cli -h redis --pipe
    # On supprime le fichier CSV par gain de place
    rm adresses-$1.csv
}

# Si c'est pour une démo, on ne charge que les Alpes-Maritimes
if [ $1 = "demo" ]
then
    traiterDepartement 83
else
    # Sinon, on traite tous les départements
    for i in {01..95}; 
    do
        # Sauf le 20 car il n'existe plus depuis les années 70 (séparation de la Corse)
        if [[ 10#$i -eq 20 ]]; then
            continue
        fi
        traiterDepartement $i
    done

    # Les DOMs
    for i in {971..974}; 
    do 
        traiterDepartement $i
    done

    # Mayotte
    traiterDepartement 976

    # La Corse <3
    traiterDepartement 2A
    traiterDepartement 2B
fi