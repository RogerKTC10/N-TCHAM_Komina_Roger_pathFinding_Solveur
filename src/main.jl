# On garde tes includes tels quels, ils sont dans le bon ordre
include("Part_Two_Solveur/Adaptation/Structure_Part2.jl")
using .Structure_Part2
include("Part_Two_Solveur/Adaptation/Evolution_A_etoile.jl")
include("Part_Two_Solveur/Utilitaire_Part2.jl")
include("Part_Two_Solveur/Action_Metier/DeplacementAMR.jl")

function main()
    path = "data/street-map/Boston_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    carte = Struct_Carte.Constructeur_Matrice_Value(matriceV)
    
    carnet = Carnet_Commande()
    Generation_Commande(carnet, carte)

    # 3. Initialisation des Agents
    parking_AMR = sous_ensemble_gauche(carte)
    # On utilise bien parking_AMR[i] ici
    liste_agents = [AgentAMR(i, parking_AMR[i], (0, 0)) for i in 1:20]
    
    println("✅ 20 Agents prêts au départ (Colonne 1).")

    # 4. Planification Multi-Agents
    println("\nCalcul des missions en cours...")
    # On lance la planification globale
    archives = planification_AMR(liste_agents, carnet, carte, nothing)

    # 5. Affichage des Résultats
    println("\n--- BILAN DE LA SIMULATION ---")
    println("Nombre total de missions traitées : $(length(archives))")
    
    if !isempty(archives)
        m1 = archives[1] # On récupère la première mission archivée
        
        # On affiche les détails en utilisant les bons noms de champs
        println("----------------------------------------")
        println("Robot ID      : $(m1.id_robot)")
        println("Colis ID      : $(m1.id_colis)")
        println("Destination   : $(m1.quai_final)") # Affiche le Tuple (y, x)
        
        # Vérification du temps final sur le trajet détaillé
        temps_final = m1.trajet_detaille[end].t
        println("Temps d'arrivée : $temps_final secondes")
        println("----------------------------------------")
    end
end

# Exécution
main()





"""
    include("Security_Transformation/Transformation.jl")
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
    println("\n")"""
    