# Rechadresses

![Rechadresses](logo.png?raw=true "Rechadresses")

## Quickstart

Pré-requis : Docker et docker-compose

```bash
$ git clone https://github.com/TeddyBear06/rechadresses.git
$ cd rechadresses
$ docker-compose up
```

Rendez-vous à l'adresse https://localhost:5001 (il faut accepter le certificat auto-signé) pour tester l'autocomplete !

## Bilan de l'existant

### A. Google Place Autocomplete

Service gratuit mais payant au-delà d'un certain quota.

Exemple : https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete-addressform

### B. API de la "Base Nationale d'Adresses" (BNA)

Permet de trouver des adresses que Google ne trouve pas.

Exemple (formulaire en bas de page) : https://geo.api.gouv.fr/adresse

Possibilité de déployer sa propre instance en suivant ces instructions : https://github.com/etalab/addok-docker

## Objectifs

1. Aider à la saisie utilisateur
2. Obtenir une saisie de qualité

## Données

Les adresses françaises sont disponibles ici : https://adresse.data.gouv.fr/data/ban/adresses/latest/csv/

## Stack techno

### Backend

- [Redis](https://redis.io/) avec le module [RediSearch](https://oss.redislabs.com/redisearch/)
- [Flask](https://flask.palletsprojects.com/en/1.1.x/) (Python)
- [Docker](https://www.docker.com/)

### Frontend

- [JQueryUI autocomplete](https://jqueryui.com/autocomplete/)

## Utilisation (version longue)

Vous devez avoir Docker et docker-compose installés.

Ensuite, exécutez la commande :

```bash
$ docker-compose up
```

Rendez-vous à l'adresse https://localhost:5001 (il faut accepter le certificat auto-signé) pour tester l'autocomplete !

N.B : Pour des raisons de quantité de mémoire utilisée (il faut au moins 16Gb pour charger l'ensemble des départements), seulement les Alpes-Maritimes sont chargées par défaut.

Pour modifier cela et charger l'ensemble des départements, changer :

```bash
ENTRYPOINT [ "./run.sh", "demo" ]
```

En :

```bash
ENTRYPOINT [ "./run.sh", "prod" ]
```

Dans le fichier [Dockerfile](rechadresses/Dockerfile#L14) ;-)

Enjoy!