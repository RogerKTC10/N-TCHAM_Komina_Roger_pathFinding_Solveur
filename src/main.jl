include("Security_Transformation/Transformation.jl")
include("Comparaison.jl") 
include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
include("My_Algorithms/Glouton_Doc/Glouton.jl")
include("affichage.jl")

function main()
    path = "data/wc3maps512-map/dragonfire.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)

    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    carte_djis = Struct_Carte.Constructeur_Matrice_Value(matriceV)

    depart, arriver = trouver_points_pieges(matrice)


    println("Lancement BFS...")
    debut_bfstime = time()
    res_bfs = execution_BFS(carte, depart, arriver)
    temps_bfs = CPUtime(debut_bfstime)
    cout_reel_bfs = calculer_cout_chemin(res_bfs.chemin, matrice)


    println("Lancement Dijkstra...")
    debut_djistime = time()
    res_djis = execution_Djisktra(carte_djis, depart, arriver)
    temps_djis = CPUtime(debut_djistime)
    
    println("Lancement Glouton...")
    debut_glouton = time()
    res_glouton = execution_Glouton(matrice, matriceV, depart, arriver)
    temps_glouton = CPUtime(debut_glouton)



    println("BFS      | Coût Réel: $cout_reel_bfs          | États: $(res_bfs.activite)        | CPUtime: $(temps_bfs)")
    println("Dijkstra | Coût Réel: $(res_djis.cout)        | États: $(res_djis.activite)       | CPUtime: $(temps_djis)")
    println("Glouton  | Coût Réel: $(res_glouton.distance) | États: $(res_glouton.activite)    | CPUtime: $(temps_glouton)")
     println("Génération des images de résultats...")
    
    affichage_BFS(carte, res_bfs.chemin, cout_reel_bfs, res_bfs.activite, temps_bfs)
    
    affichage_Djistkra(carte_djis, res_djis.chemin, res_djis.cout, res_djis.activite, temps_djis)
    
    affichage_Glouton(matriceV, res_glouton.chemin, res_glouton.distance, res_glouton.activite, temps_glouton)
end

main()