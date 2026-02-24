function heuristique(a, b)
    return abs(a[1] - b[1]) + abs(a[2] - b[2])
end

function execution_Glouton(carte, depart, arriver)
    # Priorité basée UNIQUEMENT sur la distance à l'arrivée
    file_priorite = PriorityQueue{Tuple{Int, Int}, Float64}()
    enqueue!(file_priorite, depart, heuristique(depart, arriver))
    
    parents = Dict()
    visites = Set([depart])
    nb_etats = 0
    trouve = false

    while !isempty(file_priorite)
        actuel = dequeue!(file_priorite)
        nb_etats += 1

        if actuel == arriver
            trouve = true
            break
        end

        for voisin in Voisinage(actuel[1], actuel[2], carte)
            if !(voisin in visites)
                push!(visites, voisin)
                parents[voisin] = actuel
                # On ajoute à la file selon l'heuristique SEULEMENT
                enqueue!(file_priorite, voisin, heuristique(voisin, arriver))
            end
        end
    end
    
    # ... reconstruction du chemin identique à ton code ...
end