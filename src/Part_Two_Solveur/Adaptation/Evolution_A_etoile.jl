include("../Utilitaire_Part2.jl")

using DataStructures
using .Structure_Part2  
using .Struct_Carte


function execution_Etoile_Adaptation(G::Struct_Carte.Carte_Final_Value_Struct, vdepart::Tuple{Int,Int}, varriver::Tuple{Int,Int}, G_dict, intervalles_dict)
    g_score = Dict{Structure_Part2.tripletAMR, Float64}() 
    depart_triplet = Structure_Part2.tripletAMR(vdepart[1], vdepart[2], 0)
    g_score[depart_triplet] = 0.0
    parents = Dict{Structure_Part2.tripletAMR, Structure_Part2.tripletAMR}()
    nb_etat_evaluer = 0
    maFile = PriorityQueue{Structure_Part2.tripletAMR, Float64}()

    maFile[depart_triplet] = 0.0 + h_adapter(depart_triplet, varriver)
    while !isempty(maFile)
        actuel = dequeue!(maFile)
        nb_etat_evaluer = nb_etat_evaluer + 1

        if actuel.y == varriver[1] && actuel.x == varriver[2] 
            chemin_suivi = reconstruire_chemin_adaptation(parents, depart_triplet, actuel)
            return (chemin = chemin_suivi, cout = g_score[actuel], activite = nb_etat_evaluer)
        end

        for voisin in voisinage_SIPP(actuel, G, G_dict, intervalles_dict)
            
            if voisin.x == actuel.x && voisin.y == actuel.y
                poids_action = 1.0 
            else
                poids_action = recup_cout_chemin(voisin.y, voisin.x, G)
            end

            nouveau_g = g_score[actuel] + poids_action 

            if !haskey(g_score, voisin) || nouveau_g < g_score[voisin]
                g_score[voisin] = nouveau_g 
                parents[voisin] = actuel
                priorite_f = nouveau_g + h_adapter(voisin, varriver)
                maFile[voisin] = priorite_f
            end
        end
    end 
    return (chemin = [], cout = Inf, activite = nb_etat_evaluer)
end