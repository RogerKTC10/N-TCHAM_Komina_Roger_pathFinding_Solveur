include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("Security_Transformation/Transformation.jl")
#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceV)
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