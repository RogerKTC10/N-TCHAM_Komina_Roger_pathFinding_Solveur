include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceV)
    if isempty(chemin)
        return Inf
    end

    total = 0.0
    # On commence à l'indice 2 pour ignorer le coût de la case de départ
    for k in 2:length(chemin)
        i, j = chemin[k]
        total += matriceV[i, j]
    end
    return total
end

function CPUtime()
end

function Number_State_Value()
end