include("My_Algorithms/DataStructure_Min.jl")
include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Djistkra_Doc/Djistkra.jl")


include("Comparaison.jl") 
include("affichage.jl")

function main()
    path = "data/wc3maps512-map/bootybay.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)

    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    carte_djis = Struct_Carte.Constructeur_Matrice_Value(matriceV)

    depart, arriver = trouver_points_pieges(matrice)

    println("Lancement BFS...")
    res_bfs = execution_BFS(carte, depart, arriver)

    println("Lancement Dijkstra...")
    res_djis = execution_Djisktra(carte_djis, depart, arriver)

    cout_reel_bfs = calculer_cout_chemin(res_bfs.chemin, matrice)

    println("BFS      | Coût Réel: $cout_reel_bfs | États: $(res_bfs.activite)")
    println("Dijkstra | Coût Réel: $(res_djis.cout) | États: $(res_djis.activite)")
end

main()