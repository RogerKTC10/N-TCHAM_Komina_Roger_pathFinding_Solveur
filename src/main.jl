include("Security_Transformation/Transformation.jl")
include("Comparaison.jl") 
include("My_Algorithms/DataStructure_Min.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
include("My_Algorithms/Glouton_Doc/Glouton.jl")
include("My_Algorithms/A_Doc/A_etoile.jl")
include("affichage.jl")

function main()
    path = "data/wc3maps512-map/dragonfire.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)

    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    carteValuer = Struct_Carte.Constructeur_Matrice_Value(matriceV)

    depart, arriver = trouver_points_pieges(matrice)


    println("Lancement BFS...")
    debut_bfstime = time()
    res_bfs = execution_BFS(carte, depart, arriver)
    temps_bfs = CPUtime(debut_bfstime)
    cout_reel_bfs = calculer_cout_chemin(res_bfs.chemin, matrice)


    println("Lancement Dijkstra...")
    debut_djistime = time()
    res_djis = execution_Djisktra(carteValuer, depart, arriver)
    temps_djis = CPUtime(debut_djistime)
    
    println("Lancement Glouton...")
    debut_glouton = time()
    res_glouton = execution_Glouton(matrice, matriceV, depart, arriver)
    temps_glouton = CPUtime(debut_glouton)

    println("Lancement A*...")
    debut_astartime = time()
    res_etoile = execution_Etoile(carteValuer, depart, arriver) # Ta fonction A*
    temps_etoile = CPUtime(debut_astartime)


    println("BFS      | Coût Réel: $cout_reel_bfs          | Etats: $(res_bfs.activite)        | CPUtime: $(temps_bfs)")
    println("Les points du chemin BFS sont : \n", res_bfs.chemin)
    println("\n")

    println("Djikstra | Coût Réel: $(res_djis.cout)        | Etats: $(res_djis.activite)       | CPUtime: $(temps_djis)")
    println("Les points du chemin Djikstra sont : \n", res_djis.chemin)
    println("\n")
    
    println("Glouton  | Coût Réel: $(res_glouton.distance) | Etats: $(res_glouton.activite)    | CPUtime: $(temps_glouton)")
    println("Les points du chemin Glouton sont : \n", res_glouton.chemin)
    println("\n")

    println("A*       | Cout Réel: $(res_etoile.cout)      | Etats: $(res_etoile.activite)     | CPUtime: $(temps_etoile)")
    println("Les points du chemin A* sont : \n", res_etoile.chemin)
    println("\n")
    

    #affichage_BFS(carte, res_bfs.chemin, cout_reel_bfs, res_bfs.activite)
    #affichage_Djistkra(carteValuer, res_djis.chemin, res_djis.cout, res_djis.activite)
    #affichage_Glouton(matriceV, res_glouton.chemin, res_glouton.distance, res_glouton.activite, temps_glouton)
end

main()