include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#Mes prpre doutes d'Action
#Ca m'a permis de tester donc BFS et Djistkra sur des point de depart et d'arriver douteuse
function trouver_points_pieges(matriceChar)
    h, w = size(matriceChar)
    for i in 100:h-100
        for j in 100:w-100
            if matriceChar[i, j] == 'W'
                if matriceChar[i, j-20] == '.' && matriceChar[i, j+20] == '.'
                    println("🎯 Piège trouvé !")
                    println("Départ (sol) : ", (i, j-20))
                    println("Eau au milieu : ", (i, j))
                    println("Arrivée (sol) : ", (i, j+20))
                    return (i, j-20), (i, j+20)
                end
            end
        end
    end
    error("Aucun piège trouvé sur cette carte. Change de zone ou de carte !")
end



#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceChar)
    total_facture = 0.0

    # On parcourt le chemin à partir de la deuxième case
    for k in 2:length(chemin)
        i, j = chemin[k]
        caractere = matriceChar[i, j]
        prix_passage = valuation(caractere)
        
        total_facture += prix_passage
    end

    return total_facture
end

function CPUtime()
end

function Number_State_Value()
end