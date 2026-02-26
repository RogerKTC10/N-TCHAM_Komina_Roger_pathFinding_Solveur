function non_visiter(x, visites)
    return !(x in visites)
end

function execution_Glouton(matriceCons, matrice_valuee, depart, arriver)
    file_priorite = PriorityQueue{Tuple{Int, Int}, Float64}()
    enqueue!(file_priorite, depart, heuristique(depart, arriver))
    parents = Dict()
    visites = Set([depart])
    nb_etats = 0

    h, w = size(matriceCons)
    faux_objet_carte = (height_val = h, width_val = w)

   while !isempty(file_priorite)
        actuel = dequeue!(file_priorite)
        nb_etats += 1
        
        if actuel == arriver
            chemin_final = reconstruire_chemin(parents, depart, arriver)
            cout_total = sum(matrice_valuee[p[1], p[2]] for p in chemin_final)
            return (chemin = chemin_final, distance = cout_total, activite = nb_etats)
        end
        for voisin in Voisinage_Autre(actuel, faux_objet_carte)
            char_cellule = matriceCons[voisin[1], voisin[2]]
            
            if char_cellule != '@' 
                if char_cellule != 'T' 
                    if non_visiter(voisin, visites)
                        push!(visites, voisin)
                        parents[voisin] = actuel
                        score = heuristique(voisin, arriver)
                        enqueue!(file_priorite, voisin, score)
                    end
                end
            end
        end
    end
    return "Aucun chemin trouvé"
end