include("../Utilitaire_Part2.jl")

using DataStructures

function execution_Etoile_Adaptation(G::Carte_Final_Value_Struct, vdepart::Tuple{Int,Int}, varriver::Tuple{Int,Int}, G_dict)
   
    g_score = Dict{tripletAMR, Int}() 
    
    depart_triplet = tripletAMR(vdepart[1], vdepart[2], 0)
    g_score[depart_triplet] = 0
    
    parents = Dict{tripletAMR, tripletAMR}()
    
    nb_etat_evaluer = 0
    maFile = PriorityQueue{tripletAMR, Int}()

    maFile[depart_triplet] = heuristique_Etoile_adaptation(depart_triplet, varriver)

    while !isempty(maFile)
        actuel = dequeue!(maFile)
        nb_etat_evaluer = nb_etat_evaluer + 1

        if actuel.x == varriver[2] && actuel.y == varriver[1]
            return (chemin = reconstruire_chemin_adaptation(parents, depart_triplet, actuel), 
                    cout = g_score[actuel], 
                    activite = nb_etat_evaluer)
        end

        for voisin in voisinage_adaptation(actuel, G, G_dict)
            nouveau_h = heuristique_adapter(voisin) 

            if !haskey(g_score, voisin) || nouveau_h < g_score[voisin]
                g_score[voisin] = nouveau_h 
                parents[voisin] = actuel
                
                priorite_f = heuristique_Etoile_adaptation(voisin, varriver)
                maFile[voisin] = priorite_f
            end
        end
    end
    return (chemin = [], cout = Inf, activite = nb_etat_evaluer)
end