# pathFinding_Solveur PROJET SCIENTIFIQUE NANTES UNIVERSITE

                 --------------------------------------------------------------------------------------
                        Travail Réalisé par N'TCHAM KOMINA ROGER (Etudiant à Nantes Université)
                 --------------------------------------------------------------------------------------

                  Mini_ SOLVEUR qui definis un chemin optimal sur une carte 2d avec une vue de graphe.

#------------------------------------------------------------------------------------------------------------------#

    PROJET SCIENTIFIQUE : SOLUTION LOGICIELLE QUI PERMET DE TROUVER UN MEILLEUR CHEMIN A PARTIR D'UN ALGORITHME

#------------------------------------------------------------------------------------------------------------------#

Détails de mon idée : La solution logicielle développée consiste en un programme Julia permettant d’implémenter et de comparer plusieurs algorithmes de recherche de plus court chemin sur une grille 2D contrainte.
Le programme intègre une phase de comparaison au cours de laquelle les algorithmes sont évalués selon différents critères, tels que le coût du chemin obtenu, le nombre de nœuds explorés et l’usage mémoire.

NB : Ce projet sera réalisé en "Julia" et est présenter comme un projet de scientifique de stage par la L3 INFO-MATHS de Nantes Université.

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
                            ---°--MON IDEE DE PLAN DE TRAVAIL QUE JE VEUX SUIVRE--°---
                                        ---°--MON DOSSIER "src/"--°---
src/
├── Models/
│   └── Struct_Carte.jl      
├── Core/
│   ├── Charger_Carte.jl     
│   └── Transformation.jl    
├── Utils/
│   ├── TasMin.jl            
│   ├── Additional_Action.jl 
│   └── Affichage.jl         
├── Algos/
│   ├── BFS_Doc/BFS.jl
│   ├── Dijkstra/Dijkstra.jl
│   ├── Glouton_Doc/Glouton.jl
│   └── A_Doc/A_etoile.jl           
└── main.jl                 