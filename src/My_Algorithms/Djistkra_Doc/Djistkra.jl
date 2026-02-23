using .DataStructure_Min
using .Struct_Carte
using DataStructures


function execution_Djisktra(G::Carte_Final_Value_Struct, vdepart, varriver)
    matriceDjis = G.grille_val  #Iici je considère ma matrice comme un graphe dont les sommet sont les cases et les arretes sont les deplacement Nord, Ouest, Est, Sud a faire sur la carte ... 
    h, w = G.height_val, G.width_val

    distance_djis = Dict{Tuple{Int, Int}, Float64}()
    distance_djis[vdepart] = 0.0

    parents = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    visiter = Set{vdepart}
    
    maFile = tas_min()

    maFile[vdepart] = 0.0

    while !isempty(maFile)
        extrai_min_noeud = dequeue!(maFile)
        if extrai_min_noeud == varriver
            break
        end
    end

    for voisin in Voisinage(extrai_min_noeud, j)
        i_visiter, j_visiter = voisin

        valuation_voisin = matriceDjis[i_]

        distance_djistkra = distance_djis[extrai_min_noeud] + valuation_voisin
        if !haskey(distance_djis, v) || nouvelle_dist < distance_djis[v]
                distance_djis[v] = nouvelle_dist
                parents[v] = u
                
                # On ajoute ou on met à jour dans ton tas
                file_priorite[v] = nouvelle_dist
        end
    end
end