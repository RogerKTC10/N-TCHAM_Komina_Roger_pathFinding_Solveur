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
    path = "data/street-map/Berlin_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    carte = Struct_Carte.Constructeur_Matrice_Value(matriceV)
    
    parking_points = sous_ensemble_gauche(carte)
    println("Le nombre de place parkings sont : ", length(parking_points))
    #=for (i, coord) in enumerate(parking_points)
        println("Place $i :  ($(coord[1]), $(coord[2]))")
    end=#
    
    zone_transfert = zone_relais(carte)
    println("Le nombre de colis dans la zones de transforts : ", length(zone_transfert))
    #=for (i, coord) in enumerate(zone_transfert)
        println("Relais $i :  ($(coord[1]), $(coord[2]))")
    end=#
    

    quai_dechargement = sous_ensemble_droit(carte)
    println("Le nombre de quai de dechargements :", length(quai_dechargement))
    #=for (i, coord) in enumerate(quai_dechargement)
        println("Quai $i :  ($(coord[1]), $(coord[2]))")
    end=#
    
    #---------CARNET DE COMMANDE---
    tous_les_trajets = []
    mon_carnet = Carnet_Commande()
    #println("Liste de mes commandes disponible pour mes AMR : \n", mon_carnet)

    Generation_Commande(mon_carnet, carte)
    liste_robots = []
    positions_depart = []
    for i in 1:15
        p_init = parking_points[i]
        push!(liste_robots, Structure_Part2.AgentAMR(i, p_init, (0,0)))
        push!(positions_depart, p_init)
    end

    G_dict = Dict{Tuple{Int, Int, Int}, Float64}() 
    intervalles_dict = Dict{Tuple{Int, Int}, Vector{Tuple{Int, Int}}}()

    for y in 1:carte.height_val
        for x in 1:carte.width_val
            intervalles_dict[(y, x)] = [(0, 500000)] 
        end
    end

    println("Planification debut")
    mes_archives, temps_finaux = planification_AMR(liste_robots, mon_carnet, carte, G_dict, intervalles_dict)

    if !isempty(mes_archives)
        reunir_stats(mes_archives)
        Afficher_Trace_Missions(mes_archives, 30)
        println("Planification terminée. Les robots ont évité les collisions.")

        println("\nLancement de la phase de retour au Parking en fin de mission")
        mission_retour_parking(liste_robots, positions_depart, carte, G_dict, intervalles_dict, temps_finaux)

    else
        println("Erreur : Aucune mission n'a pu être planifiée.")
    end

end
main()

#------DECOMMENTER LE CODE CI DESSUS SI VOUS VOULER EXECUTER LA PARTIE 1 DU PROJET

    #=include("Security_Transformation/Transformation.jl")
    include("Comparaison.jl") 
    include("My_Algorithms/DataStructure_Min.jl")
    include("My_Algorithms/BFS_Doc/BFS.jl")
    include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
    include("My_Algorithms/Glouton_Doc/Glouton.jl")
    include("My_Algorithms/A_Doc/A_etoile.jl")
    using .Struct_Carte
    function main()
        path = "data/street-map/Berlin_0_512.map"
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
        println("\n")

        println("Solution Djisktra: \n")
        println("Distance Djisktra: $(res_djis.cout)\n")
        println("Etats Djiskstra: $(res_djis.activite)\n")
        println("CPUtime Djiskstra: $(temps_djis)\n")
        println("\n")
    
        println("Solution Glouton: \n")
        println("Distance Glouton: $(res_glouton.distance)\n")
        println("Etats Glouton: $(res_glouton.activite)\n")
        println("CPUtime Glouton: $(temps_glouton)\n")
        println("\n")

        println("Solution A*: \n")
        println("Distance A*: $(res_etoile.cout)\n")
        println("Etats A*: $(res_etoile.activite)\n")
        println("CPUtime A*: $(temps_etoile)\n")
        println("\n")

        println("Les points du chemin BFS sont : \n", res_bfs.chemin)
        println("Les points du chemin Djikstra sont : \n", res_djis.chemin)
        println("Les points du chemin Glouton sont : \n", res_glouton.chemin)
        println("Les points du chemin A* sont : \n", res_etoile.chemin)
    end
    main()=#