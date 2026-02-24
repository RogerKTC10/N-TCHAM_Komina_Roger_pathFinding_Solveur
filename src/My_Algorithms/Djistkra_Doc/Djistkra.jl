using .DataStructure_Min
using .Struct_Carte
using DataStructures

function execution_Djisktra(G::Carte_Final_Value_Struct, vdepart, varriver)
    matriceDjis = G.grille_val  #Iici je considère ma matrice comme un graphe dont les sommet sont les cases et les arretes sont les deplacement Nord, Ouest, Est, Sud a faire sur la carte ... 
    h, w = G.height_val, G.width_val

    distance_djis = Dict{Tuple{Int, Int}, Float64}()
    distance_djis[vdepart] = 0.0
    parents = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    
    maFile = tas_min()
    maFile[vdepart] = 0.0

    while !isempty(maFile)
        extrai_min_noeud = dequeue!(maFile)
        if extrai_min_noeud == varriver
            break
        end

        for voisin in Voisinage(extrai_min_noeud, G)
            i_visiter, j_visiter = voisin

            valuation_voisin = matriceDjis[i_visiter, j_visiter]

            distance_djistkra = distance_djis[extrai_min_noeud] + valuation_voisin
            if !haskey(distance_djis, voisin) || distance_djistkra < distance_djis[voisin]
                distance_djis[voisin] = distance_djistkra
                parents[voisin] = extrai_min_noeud
            
                # On ajoute ou on met à jour dans ton tas
                maFile[voisin] = distance_djistkra
            end
        end
    end

    chemin_djisktra = reconstruire_chemin(parents, vdepart, varriver)
    cout_total_parcours  = distance_djis[varriver]
    return (chemin_djisktra, cout_total_parcours)
end