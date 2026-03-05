# pathFinding_Solveur PROJET SCIENTIFIQUE NANTES UNIVERSITE par N'TCHAM KOMINA ROGER.

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


Note : Pour l'instant l'affichage avec le paquettage "Plots" de julia n'est pas encore au points, mais je pense qu'elle le sera à la fin de la 2eme partie.
L'essentielle de cette 1ere partie (Impléméntation des algorithme de recherche de chemin) sont implémenter avec les resultats visible.

*La majeur partie du code est écrit dans le dossier src/ avec une separation conforme pour chaque algorithme.

BFS : Il suit une logique de propagation case par case, 
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #