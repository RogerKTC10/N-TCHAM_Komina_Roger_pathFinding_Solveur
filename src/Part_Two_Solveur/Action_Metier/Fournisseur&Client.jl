include("../Adaptation/Structure_Part2.jl")

using .Commande

function Carnet_Commandes()
    mon_carnet = Vector{Commande}

    return mon_carnet
end

function Generation_Commande(carnet, carte, capacite_max=100)
    nb_colis_actuels = count(c -> !c.accomplie, carnet)

    if nb_colis_actuels <= (capacite_max * 0.25)
        
        points_relais = zone_relais(carte)
        points_quais = sous_ensemble_droit(carte)
        positions_occupees = [c.position_relais for c in carnet if !c.accomplie]
        places_libres = filter(p -> !(p in positions_occupees), points_relais)

        println("Réapprovisionnement : $(length(places_libres)) nouveaux colis arrivés")

        taille_initiale = length(carnet)
        nb_quais = length(points_quais)

        for i in 1:length(places_libres)
            source = places_libres[i] 
            idx_quai = ((taille_initiale + i - 1) % nb_quais) + 1
            destination = points_quais[idx_quai]
            
            id_unique = taille_initiale + i
            nouvelle_mission = Commande(id_unique, source, destination, false)
            
            push!(carnet, nouvelle_mission)
        end
    else
        println("Stock OK : $nb_colis_actuels colis en zone relais.")
    end
end

function attribution_Commande()
end