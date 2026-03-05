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


les fichiers "affichage.jl" n'est pas encore au point, et elle ne concerne pas ce premier rendu. 

L'essentielle de cette 1ere partie (Impléméntation des algorithme de recherche de chemin) sont implémenter avec les resultats visible.

*La majeur partie du code est écrit dans le dossier src/ avec une separation conforme pour chaque algorithme.

BFS : Il suit une logique de propagation case par case. il se déploie à partir du point de départ comme une onde circulaire, explorant la grille (Graphe representé sous forme matricielle) sans aucun discernement. Chaque case est traitée comme une unité équivalente, l'algorithme ne progressant vers une nouvelle "couronne" de voisins que lorsqu'il a épuisé toutes les possibilités de la profondeur actuelle. Cette progression par balayage systématique lui permet de couvrir l'espace de manière exhaustive, garantissant la découverte du chemin le plus court en nombre de pas, mais au prix d'une exploration aveugle qui ignore la direction de l'arrivée ou la difficulté réelle du terrain.

Djisktra : Quant à lui, il suit une logique suit une logique de pondération : il ne se contente plus de compter les cases, mais il évalue l'effort réel nécessaire pour les traverser. Au lieu d'une onde circulaire uniforme, son exploration se déforme et s'adapte au relief de la carte, privilégiant les sentiers faciles même s'ils rallongent la distance géométrique. En utilisant une file de priorité, il délaisse la progression case par case pour se concentrer systématiquement sur le nœud le "moins coûteux" du front d'expansion, garantissant ainsi une efficacité aspect cout lors de la recherche du chemin optimal.

Glouton : Ici il suit une logique d'instinct et d'anticipation : il délaisse totalement le coût du chemin déjà parcouru pour ne se concentrer que sur la distance estimée restant à parcourir. Contrairement à Dijkstra qui regarde en arrière pour assurer l'économie, le Glouton regarde exclusivement vers l'avant, choisissant systématiquement la case qui semble la plus proche de l'arrivée selon une fonction heuristique.

A* : quant à lui, il suit une logique de compromis optimal : il fusionne la prudence de Dijkstra avec l'ambition du Glouton. Son originalité réside dans l'utilisation d'une fonction d'évaluation combinée,  que j'ai appeler "heuristique_Etoile" f(n) = g(n) + h(n), où il additionne le coût réel déjà payé (g) et l'estimation du coût restant (h). Cette approche permet de garantir l'optimalité du chemin trouvé (comme Dijkstra) tout en réduisant considérablement le nombre de nœuds explorés grâce au guidage de l'heuristique (comme le Glouton).
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #