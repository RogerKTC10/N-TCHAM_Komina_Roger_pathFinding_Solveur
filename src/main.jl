include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
include("Comparaison.jl")
include("affichage.jl")

function main()
    path = "data/street-map/Paris_0_1024.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    
    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    carte_djis =  Struct_Carte.Constructeur_Matrice_Value(matriceV)
    depart = (121, 180)
    arriver = (1020, 1024)
    res = execution_BFS(carte, depart, arriver);
    res_djis = execution_Djisktra(carte_djis, depart, arriver)
    println(res, "\n")
    println("Djistra Chemin \n", res_djis)

    #Resulta de BFS
    println("BFS : Distance = $dist_bfs | Activité = $activite_bfs")
    affichage_BFS(carte, res.chemin, res.distance, res.activite)
    #Resultat Djistkra
    println("Dijkstra : Coût = $cout_djis | Activité = $activite_djis")
    affichage_Djistkra(carte_djis, res_djis.chemin, res_djis.distance, res_djis.activite)
     
    #-------------------------UN TRUC OPTIONNELLE QUE J4AI MISE------------------------- 
    #cout_BFS = Cout_dist_BFS(res.chemin, matriceV)
    #println("Cout du Chemin parcourue\n", cout_BFS)
end
main()
