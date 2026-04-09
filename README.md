# pathFinding_Solveur and CROSS-DOCKING Multi-Agent Solveur PROJET SCIENTIFIQUE NANTES UNIVERSITE par N'TCHAM KOMINA ROGER.


--------------------------------------------------------------------------------------------------------------------
### Pour cette partie, moi j'ai utiliser le fichier map (Berlin_0_512) pour faire mes tests, cependant dans le dossier data/street-map/ , j'ai mis d'autre fichier .map qui marche parfaitement pour le test
--------------------------------------------------------------------------------------------------------------------

    * Etape d' Exécution du programme
Pour lancer la simulation et afficher le bilan statistique :

- Ouvrez Julia dans le dossier racine du projet.

- Exécutez les commandes suivante sans les "###": 
------------------------
 ### julia  
 ### include("src/main.jl")
------------------------
--------------------------------------------------------------------------------------------------------------------

    * Configuration du Système
Le projet transforme la topologie urbaine en un entrepôt logistique structuré :

- Parking (Zone Ouest) : Zone initial des AMR (Départ et retour final des 15 AMR)

- Zone de Relais (Centre) : Definition d'un carré centrale 20 * 20 qui constitue notre zone centrale de depot temporaire des colis

- Quais de Déchargement (Zone Est) : Zone de Livraison finale des commandes.

--------------------------------------------------------------------------------------------------------------------

    * Spécifications Techniques
### Algorithmes : A* adapté combiné au SIPP (Safe Interval Path Planning) pour la gestion des collisions temporelles.

### Performance : Planification de 309 missions avec équilibrage de charge automatisé.

### Statistiques : Calcul en temps réel de la distance totale (env. 300 000+ cases) et du temps moyen.

--------------------------------------------------------------------------------------------------------------------
Les fonctionnalité implémentés sont l'adaptation du A* et la configuration structurelle de la carte dans une logique logistique de cross-dock puis les tests et resultats conclusive.

Aussi on a accordé une attention particuliere à la gestion de collision en vue de ne pas surchager et faire planter notre programme.

--------------------------------------------------------------------------------------------------------------------
### Le projet comporte une documentation dans le dossier doc/ qui explique mes idées et la logique te travail suivie.
NB : les "###" sont lancer l'affichage markdown sur github.