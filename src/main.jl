# 1. INCLUDES (L'ordre est vital)
include("Part_Two_Solveur/Adaptation/Structure_Part2.jl")
include("Part_Two_Solveur/Adaptation/Evolution_A_etoile.jl")
include("./Security_Transformation/Structure.jl") 
include("./Security_Transformation/Transformation.jl")
include("Part_Two_Solveur/Action_Metier/Entrepot_Tri.jl")
include("Part_Two_Solveur/Action_Metier/Fournisseur&Client.jl")
include("Part_Two_Solveur/Action_Metier/DeplacementAMR.jl")

using .Structure_Part2
using .Struct_Carte

function main()
    path = "data/street-map/Boston_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    carte = Struct_Carte.Constructeur_Matrice_Value(matriceV)
    
    # 3. EXTRACTION DES POINTS
    parking_points = sous_ensemble_gauche(carte)
    println("Les parkings sont : ", length(parking_points))
    for (i, coord) in enumerate(parking_points)
        println("Place $i :  ($(coord[1]), $(coord[2]))")
    end
    
    zone_transfert = zone_relais(carte)
    println("Mes points de zones de transforts : ", length(zone_transfert))
    for (i, coord) in enumerate(zone_transfert)
        println("Relais $i :  ($(coord[1]), $(coord[2]))")
    end
    

    quai_dechargement = sous_ensemble_droit(carte)
    println("Mes zone de dechargements :", length(quai_dechargement))
    for (i, coord) in enumerate(quai_dechargement)
        println("Quai $i :  ($(coord[1]), $(coord[2]))")
    end
    
    #---------CARNET DE COMMANDE---
    mon_carnet = Carnet_Commande()
    println("Liste de mes commandes disponible pour mes AMR : \n", mon_carnet)

    Generation_Commande(mon_carnet, carte)

    robot_test = Structure_Part2.AgentAMR(1, parking_points[1], (0,0))
    commande_1 = mon_carnet[1]

    G_dict = Dict{Tuple{Int, Int, Int}, Float64}() 
    intervalles_dict = Dict{Tuple{Int, Int}, Vector{Tuple{Int, Int}}}()

    resultat = calcul_mission_complete(robot_test, commande_1, carte, G_dict, intervalles_dict)
    println("Trajet total : $(length(resultat.trajet)) étapes.")
    println("Départ : $(parking_points[1])")
    println("Relais : $(commande_1.position_relais)")
    println("Quai : $(commande_1.position_droit)")
end
main()

#=include("Security_Transformation/Transformation.jl")
    include("Comparaison.jl") 
    include("My_Algorithms/DataStructure_Min.jl")
    include("My_Algorithms/BFS_Doc/BFS.jl")
    include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
    include("My_Algorithms/Glouton_Doc/Glouton.jl")
    include("My_Algorithms/A_Doc/A_etoile.jl")
    
    path = "data/street-map/Boston_0_512.map"
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


    println("Solution BFS: \n")
    println("Distance BFS: $cout_reel_bfs \n")
    println("Etats BFS: $(res_bfs.activite)\n")
    println("CPUtime BFS: $(temps_bfs)\n")
    println("Les points du chemin BFS sont : \n", res_bfs.chemin)
    println("\n")

    println("Solution Djisktra: \n")
    println("Distance Djisktra: $(res_djis.cout)\n")
    println("Etats Djiskstra: $(res_djis.activite)\n")
    println("CPUtime Djiskstra: $(temps_djis)\n")
    println("Les points du chemin Djikstra sont : \n", res_djis.chemin)
    println("\n")
    
    println("Solution Glouton: \n")
    println("Distance Glouton: $(res_glouton.distance)\n")
    println("Etats Glouton: $(res_glouton.activite)\n")
    println("CPUtime Glouton: $(temps_glouton)\n")
    println("Les points du chemin Glouton sont : \n", res_glouton.chemin)
    println("\n")

    println("Solution A*: \n")
    println("Distance A*: $(res_etoile.cout)\n")
    println("Etats A*: $(res_etoile.activite)\n")
    println("CPUtime A*: $(temps_etoile)\n")
    println("Les points du chemin A* sont : \n", res_etoile.chemin)
    println("\n")=#
    