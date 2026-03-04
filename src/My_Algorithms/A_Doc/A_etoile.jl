using DataStructures

function execution_Etoile(G::Struct_Carte.Carte_Final_Value_Struct, vdepart, varriver)
    matriceVal = G.grille_val 
    
    g_score = Dict{Tuple{Int, Int}, Float64}() # On stocke le coût réel (g)
    g_score[vdepart] = 0.0
    parents = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    
    nb_etat_evaluer = 0
    maFile = tas_min()

    maFile[vdepart] = heuristique_Etoile(0.0, vdepart, varriver)

    while !isempty(maFile)
        actuel = dequeue!(maFile)
        nb_etat_evaluer += 1

        if actuel == varriver
            break
        end

        for voisin in Voisinage_Autre(actuel, G)
            val_voisin = matriceVal[voisin[1], voisin[2]]

            if val_voisin < Inf
                nouveau_g = g_score[actuel] + val_voisin

                if !haskey(g_score, voisin) || nouveau_g < g_score[voisin]
                    g_score[voisin] = nouveau_g 
                    parents[voisin] = actuel
                    priorite_f = heuristique_Etoile(nouveau_g, voisin, varriver)
                    maFile[voisin] = priorite_f
                end
            end
        end
    end
    
    if haskey(parents, varriver)
        chemin = reconstruire_chemin(parents, vdepart, varriver)
        return (chemin = chemin, cout = g_score[varriver], activite = nb_etat_evaluer)
    else
        return (chemin = [], cout = Inf, activite = nb_etat_evaluer)
    end
end