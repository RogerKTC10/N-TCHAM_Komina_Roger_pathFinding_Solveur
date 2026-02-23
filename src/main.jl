include("Security_Transformation/FileSecurity.jl")
#using .Struct_Carte
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("Comparaison.jl")
include("affichage.jl")

function main()
    path = "data/street-map/Paris_0_1024.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    #=println(matrice)=#

    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    depart = (121, 180)
    arriver = (1020, 1024)
    res = execution_BFS(carte, depart, arriver);
    println(res)
     cout_BFS = Cout_dist_BFS(res.chemin, matriceV)
     println("Cout du Chemin parcourue\n", cout_BFS)
    affichage_BFS(carte, res.chemin, res.distance, res.activite)
    #readline()

end
main()
