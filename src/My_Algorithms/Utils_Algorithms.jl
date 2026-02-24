
#----------LA PARTIE QUI CONCERNE UNIQUEMENT LE BFS--------------------

function BFS_dic_Action(i::Char)
    if (i == '@' || i == 'T')
        return ("Zone de blocage, passage refusé", false)
    elseif (i == '.' || i == 'S' || i == 'W')
        return ("Passage facile pour le BFS", true)
    else
        return ("Caractère inconnu", false)  
    end
end

function Voisinage(i, j)
   nord = (i - 1, j)
   sud = (i + 1, j)
   est = (i, j + 1)
   ouest = (i, j - 1)
   tab = [nord, sud, est, ouest]
   return tab
end

function reconstruire_chemin(parents, depart, arrivee)
    chemin = []
    actuel = arrivee
    while actuel != depart
        push!(chemin, actuel)

        if !haskey(parents, actuel)
            error("Le chemin est rompu ou inexistant !")
        end

        actuel = parents[actuel]
    end
    push!(chemin, depart)
    chemin_inverse = reverse(chemin)

    return chemin_inverse
end

#----------LA PARTIE QUI CONCERNE UNIQUEMENT LE DJISTKRA--------------------
function Voisinage_Autre(coordonner, carte)
    i, j = coordonner
    nord = (i - 1, j)
    sud = (i + 1, j)
    est = (i, j + 1)
    ouest = (i, j - 1)
    direction = [nord, sud, est, ouest]

    valides = [] 
    for (i, j) in direction 
       if 1 <= i <= carte.height_val && 1 <= j <= carte.width_val 
           push!(valides, (i, j)) 
       end
    end
    return valides
end

#----------LA PARTIE QUI CONCERNE UNIQUEMENT LE A*--------------------

#----------LA PARTIE QUI CONCERNE UNIQUEMENT LE GLOUTON--------------------

#----------LA PARTIE QUI CONCERNE l'AFFICHAGE--------------------

