include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

function trouver_points_pieges(matriceChar)
    h, w = size(matriceChar)
    
    for cible in ['W', 'S']
        for i in 100:h-100
            for j in 100:w-100
                if matriceChar[i, j] == cible
                    for di in -5:5, dj in -5:5
                        ni, nj = i+di, j+dj
                        if ni>0 && ni<=h && nj>0 && nj<=w && matriceChar[ni, nj] == '.'
                            dep = (ni, nj)
                            arr = (ni+20, nj+20)  
                            println("Piège trouvé sur '$cible' !")
                            return dep, arr
                        end
                    end
                end
            end
        end
    end
    
    for i in 1:h, j in 1:w
        if matriceChar[i, j] == '.'
            return (i, j), (h-i, w-j)
        end
    end
end

#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceChar)
    total_facture = 0.0
    for k in 2:length(chemin)
        i, j = chemin[k]
        caractere = matriceChar[i, j]
        prix_passage = valuation(caractere)
        
        total_facture = total_facture + prix_passage
    end

    return total_facture
end

function CPUtime(depart_temps)
    return round(time() - depart_temps, digits=6)
end

function Number_State_Value(resultat_algo)
    return resultat_algo.activite
end