using DataStructures

function execution_Djisktra(G::Struct_Carte.Carte_Final_Value_Struct, vdepart, varriver)
    matriceDjis = G.grille_val  #Iici je considère ma matrice comme un graphe dont les sommet sont les cases et les arretes sont les deplacement Nord, Ouest, Est, Sud a faire sur la carte ... 
    h, w = G.height_val, G.width_val

    distance_djis = Dict{Tuple{Int, Int}, Float64}()
    distance_djis[vdepart] = 0.0
    parents = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    
    nb_etat_evaluer = 0
    maFile = tas_min()
    maFile[vdepart] = 0.0

    while !isempty(maFile)
        extrai_min_noeud = dequeue!(maFile)
        nb_etat_evaluer = nb_etat_evaluer + 1

        if extrai_min_noeud == varriver
            break
        end

        for voisin in Voisinage_Autre(extrai_min_noeud, G)
            i_visiter, j_visiter = voisin

            valuation_voisin = matriceDjis[i_visiter, j_visiter]

            if valuation_voisin < Inf
               distance_djistkra = distance_djis[extrai_min_noeud] + valuation_voisin

                if !haskey(distance_djis, voisin) || distance_djistkra < distance_djis[voisin]
                    distance_djis[voisin] = distance_djistkra
                    parents[voisin] = extrai_min_noeud
            
                    # On ajoute ou on met à jour dans ton tas
                    maFile[voisin] = distance_djistkra
                end
            end
        end
    end
    
    if haskey(parents, varriver)
       chemin_djisktra = reconstruire_chemin(parents, vdepart, varriver)
       cout_total_parcours  = distance_djis[varriver]
       return (chemin = chemin_djisktra, cout = cout_total_parcours, activite = nb_etat_evaluer)
    else
        return (chemin = [], cout = Inf, activite = nb_etat_evaluer)
    end
end