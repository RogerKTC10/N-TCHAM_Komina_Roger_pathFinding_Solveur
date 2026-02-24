include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceV)
    # Si le chemin est vide (pas de solution), le coût est infini
    if isempty(chemin)
        return Inf
    end

    total = 0.0
    for pos in chemin
        # On extrait les coordonnées du tuple (i, j)
        i, j = pos
        total += matriceV[i, j]
    end
    return total
end

function CPUtime()
end

function Number_State_Value()
end