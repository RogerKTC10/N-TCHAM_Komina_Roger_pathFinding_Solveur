# pathFinding_Solveur and CROSS-DOCKING Multi-Agent Solveur PROJET SCIENTIFIQUE NANTES UNIVERSITE par N'TCHAM KOMINA ROGER.

Ce projet implémente une solution de planification de trajectoires multi-agents (MAPF) pour une flotte de 15 robots mobiles autonomes (AMR) dans un système de Cross-Docking basé sur la carte réelle transformé en un systeme logistique de Cross-Dock.

--------------------------------------------------------------------------------------------------------------------

    * Etape d' Exécution du programme
Pour lancer la simulation et afficher le bilan statistique :

- Ouvrez Julia dans le dossier racine du projet.

- Exécutez la commande suivante : Julia include("src/main.jl")

--------------------------------------------------------------------------------------------------------------------

    * Configuration du Système
Le projet transforme la topologie urbaine en un entrepôt logistique structuré :

- Parking (Zone Ouest) : Zone initial des AMR (Départ et retour final des 15 AMR)

- Zone de Relais (Centre) : Definition d'un carré centrale 20 * 20 qui constitue notre zone centrale de depot temporaire des colis

- Quais de Déchargement (Zone Est) : Zone de Livraison finale des commandes.

--------------------------------------------------------------------------------------------------------------------

    * Spécifications Techniques
Algorithmes : A* adapté combiné au SIPP (Safe Interval Path Planning) pour la gestion des collisions temporelles.

Performance : Planification de 309 missions avec équilibrage de charge automatisé.

Statistiques : Calcul en temps réel de la distance totale (env. 300 000+ cases) et du temps moyen.

--------------------------------------------------------------------------------------------------------------------

    * Structure du Projet
Architecture Structurelle que j'ai décidé de mettre en Oeuvre et de suivre :

N-TCHAM_KOMINA_ROGER_PATHFINDING_SOLVEUR/
├── data/  
│     ├──street-map/ 
│     └──wc3maps512-map/                
├── doc/ 
│    ├──Documentation_Cross-Docking_N-TCHAM.pdf           
├── res/ # TEST ET DEMONSTRATION
├── src/ # ASPECT CODE
│   ├── My_Algorithms/ 
│   │   └──A_Doc/
│   │   │    └──A_etoile.jl 
│   │   └──BFS_Doc/ 
│   │   │    └──BFS.jl
│   │   └──Djistkra_Doc/
│   │   │    └──Djisktra.jl
│   │   └──Glouton_Doc/
│   │   │    └──Glouton.jl
│   │   └──DataStructure_Min.jl
│   │   └──Utils_Algorithms.jl
│   ├── Part_Two_Solveur/  
│   │   └── Action_Metier/
│   │   │    └──AMR.jl 
│   │   │    └──DeplacementAMR.jl
│   │   │    └──Entrepot_Tri.jl
│   │   │    └──Fournisseur&Client.jl
│   │   └── Adaptation/  
│   │   │    └──Evolution_A_etoile.jl
│   │   │    └──Structure_Part2.jl 
│   ├── Utilitaire_Part2.jl
│   ├── Security_Transformation/
│   │          └──FileSecurity.jl
│   │          └──Structure.jl
│   │          └──Transformation.jl
│   ├── Comparaison.jl (Optionnel mais que j'ai mis qui concerne la partie 1)
│   └── main.jl            
└── README.md     

--------------------------------------------------------------------------------------------------------------------

