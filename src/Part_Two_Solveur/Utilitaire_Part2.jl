include("Adaptation/Structure_Part2.jl") 
include("../Security_Transformation/Transformation.jl")
include("../My_Algorithms/Utils_Algorithms.jl")

using .Structure_Part2 
using .Struct_Carte


function voisinage_SIPP(triplet::Structure_Part2.tripletAMR, carte::Struct_Carte.Carte_Final_Value_Struct, G, intervalles_dict)
    y_act = triplet.y
    x_act = triplet.x
    t_act = triplet.t
    t_suiv = t_act + 1 

    candidats = [Structure_Part2.tripletAMR(y_act - 1, x_act, t_suiv), 
                 Structure_Part2.tripletAMR(y_act + 1, x_act, t_suiv), 
                 Structure_Part2.tripletAMR(y_act, x_act + 1, t_suiv), 
                 Structure_Part2.tripletAMR(y_act, x_act - 1, t_suiv),
                 Structure_Part2.tripletAMR(y_act, x_act, t_suiv)]
             
    voisins_valides = Structure_Part2.tripletAMR[]
    for c in candidats
        if c.y >= 1 && c.y <= carte.height_val && c.x >= 1 && c.x <= carte.width_val
            if BFS_Action_dict(c.y, c.x, G) 
                for inter in intervalles_dict[(c.y, c.x)]
                    if c.t >= inter.t_debut && c.t <= inter.t_fin
                        push!(voisins_valides, c)
                        break
                    end
                end
            end
        end
    end
    return voisins_valides
end

function g_adapter(triplet::Structure_Part2.tripletAMR)
    return triplet.t
end

function h_adapter(triplet::Structure_Part2.tripletAMR, arrivee::Tuple{Int, Int})
    return abs(triplet.y - arrivee[1]) + abs(triplet.x - arrivee[2])
end

function heuristique_Etoile_adaptation(triplet::Structure_Part2.tripletAMR, arrivee::Tuple{Int, Int})
    return g_adapter(triplet) + h_adapter(triplet, arrivee)
end

# LIGNE 53 : Idem ici, on précise le module
function recup_cout_chemin(y::Int, x::Int, carte::Struct_Carte.Carte_Final_Value_Struct)
    return carte.grille_val[y, x] 
end

function reconstruire_chemin_adaptation(parents, depart_triplet, arrivee_triplet)
    chemin = []
    actuel = arrivee_triplet 
    while actuel != depart_triplet
        push!(chemin, actuel)
        if !haskey(parents, actuel)
            error("Le chemin est en perte ou inexistant")
        end
        actuel = parents[actuel]
    end
    push!(chemin, depart_triplet)
    return reverse(chemin)
end