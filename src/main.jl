# 1. INCLUDES (L'ordre est vital)
include("Part_Two_Solveur/Adaptation/Structure_Part2.jl")
include("./Security_Transformation/Structure.jl") 
include("./Security_Transformation/Transformation.jl")
include("Part_Two_Solveur/Action_Metier/Entrepot_Tri.jl")
include("Part_Two_Solveur/Action_Metier/Fournisseur&Client.jl")
include("Part_Two_Solveur/Action_Metier/DeplacementAMR.jl")

using .Structure_Part2
using .Struct_Carte

function main()
    # 2. CHARGEMENT DE LA CARTE
    path = "data/street-map/Boston_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    carte = Struct_Carte.Constructeur_Matrice_Value(matriceV)
    
    # 3. EXTRACTION DES POINTS
    parking_points = sous_ensemble_gauche(carte)
    
    # 4. INITIALISATION SIPP
    G_dict = Dict((y, x) => true for y in 1:carte.height_val, x in 1:carte.width_val 
                  if carte.grille_val[y, x] == '.')

    intervalles_dict = Dict{Tuple{Int, Int}, Vector{Structure_Part2.IntervalleSIPP}}()
    for (pos, _) in G_dict
        intervalles_dict[pos] = [Structure_Part2.IntervalleSIPP(0, 1000, 1)]
    end

    # 5. GÉNÉRATION RÉELLE DES COMMANDES
    # On initialise un vecteur VIDE de type Commande
    mon_carnet = Structure_Part2.Commande[] 
    
    # On remplit le carnet (La fonction push! dans Generation_Commande va le modifier)
    Generation_Commande(mon_carnet, carte) 

    # 6. FLOTTE D'AGENTS
    # On crée les agents au parking
    liste_agents = [Structure_Part2.AgentAMR(i, parking_points[i], (0, 0)) for i in 1:min(length(parking_points), 10)]

    # 7. VÉRIFICATION AVANT LANCEMENT
    println("--- ÉTAT DU SYSTÈME ---")
    println("Nombre de robots : $(length(liste_agents))")
    println("Nombre de commandes dans le carnet : $(length(mon_carnet))")
    
    if isempty(mon_carnet)
        println("ERREUR : Le carnet est vide. Vérifie zone_relais(carte) dans Entrepot_Tri.jl")
        return
    end

    # 8. PLANIFICATION SIPP
    println("\nLancement de la planification...")
    archives = planification_AMR(liste_agents, mon_carnet, carte, G_dict, intervalles_dict)
    
    println("Simulation terminée. $(length(archives)) missions archivées.")
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
    