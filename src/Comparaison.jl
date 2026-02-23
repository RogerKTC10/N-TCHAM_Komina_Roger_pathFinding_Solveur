#include("Security_Transformation/Transformation.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#---Spécifiquement pour le BFS------
function Cout_dist_BFS(chemin, valuate_Matrice)
    cout_parcours =  0.0
        for coord in view(chemin, 2:length(chemin))
            (i, j) = coord
            val = valuate_Matrice[i, j]

            cout_parcours += val
        end
    return cout_parcours
end

function CPUtime()
end

function Number_State_Value()
end