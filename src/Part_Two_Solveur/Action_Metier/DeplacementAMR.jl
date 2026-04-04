#=include("AMR.jl")
include("Entrepot_Tri.jl")
include("Fournisseur&Client.jl")=#

using .Structure_Part2

function calcul_mission_complete(agent::Structure_Part2.AgentAMR, commande::Structure_Part2.Commande, carte, G_dict, intervalles_dict)
     t_initial = 0 
    
     depart = (Int(agent.depart_ag[1]), Int(agent.depart_ag[2]))
     relais = (Int(commande.position_relais[1]), Int(commande.position_relais[2]))
     arrivee = (Int(commande.position_droit[1]), Int(commande.position_droit[2]))

     chemin_aller, cout_1, nodes_1 = execution_Etoile_Adaptation(carte, depart, relais, G_dict, intervalles_dict)

     if isempty(chemin_aller)
        return nothing
     end
     t_arrivee_colis = chemin_aller[end].t 
     chemin_livraison, cout_2, nodes_2 = execution_Etoile_Adaptation(carte, relais, arrivee, G_dict, intervalles_dict)
     if isempty(chemin_livraison)
        return (trajet = chemin_aller, agent_mis_a_jour = agent, cout_total = cout_1, exploration = nodes_1)
     end 
     chemin_livraison_decale = [Structure_Part2.tripletAMR(p.y, p.x, p.t + t_arrivee_colis) for p in chemin_livraison]
     chemin_total = vcat(chemin_aller, chemin_livraison_decale[2:end])
     nouvel_agent = Structure_Part2.AgentAMR(agent.id_Agent, arrivee, (0,0))    
     return (trajet = chemin_total, agent_mis_a_jour = nouvel_agent, cout_total = cout_1 + cout_2, exploration = nodes_1 + nodes_2)
end

#=function planification_AMR(liste_agents, carnet, carte, G_dict, intervalles_dict)
    archives_missions = [] 
    for i in eachindex(carnet)
        idx_robot = ((i - 1) % length(liste_agents)) + 1
        agent_actuel = liste_agents[idx_robot]
        mission = carnet[i]
        
        res = calcul_mission_complete(agent_actuel, mission, carte, G_dict, intervalles_dict)
        
        if res !== nothing
            info_precise = (id_robot = agent_actuel.id_Agent, id_colis = mission.id_colis_relais, quai_final = mission.numero_sous_ensDroit, trajet_detaille = res.trajet)
            push!(archives_missions, info_precise)
            
            liste_agents[idx_robot] = res.agent_mis_a_jour
        end
    end
    
    println("Planification définie : $(length(archives_missions)) missions générées.")
    return archives_missions
end=#

function Mise_a_jour_Intervalles!(intervalles_dict, trajet)
    for point in trajet
        pos = (Int(point.y), Int(point.x))
        t_occupe = point.t
        if haskey(intervalles_dict, pos)
            intervalles_actuels = intervalles_dict[pos]
            nouveaux = Vector{Tuple{Int, Int}}()
            for (debut, fin) in intervalles_actuels
                if t_occupe >= debut && t_occupe <= fin
                    if t_occupe > debut
                        push!(nouveaux, (debut, t_occupe - 1))
                    end
                    if t_occupe < fin
                        push!(nouveaux, (t_occupe + 1, fin))
                    end
                else
                    push!(nouveaux, (debut, fin))
                end
            end
            intervalles_dict[pos] = nouveaux
        end
    end
end

function planification_AMR(liste_agents, carnet, carte, G_dict, intervalles_dict)
    archives_missions = [] 
    
    for i in eachindex(carnet)
        idx_robot = ((i - 1) % length(liste_agents)) + 1
        agent_actuel = liste_agents[idx_robot]
        mission = carnet[i]
        
        # 1. Le robot calcule son chemin (en tenant compte des réservations actuelles)
        res = calcul_mission_complete(agent_actuel, mission, carte, G_dict, intervalles_dict)
        
        if res !== nothing
            # --- AJOUT CRUCIAL ICI ---
            # 2. On enregistre le passage de ce robot pour que les suivants l'évitent
            # C'est ce qui force le CONTOURNEMENT pour les missions d'après
            Mise_a_jour_Intervalles!(intervalles_dict, res.trajet)
            # -------------------------

            info_precise = (
                id_robot = agent_actuel.id_Agent, 
                id_colis = mission.id_colis_relais, 
                quai_final = mission.numero_sous_ensDroit, 
                trajet_detaille = res.trajet
            )
            push!(archives_missions, info_precise)
            
            # Le robot est mis à jour (il est au quai maintenant)
            liste_agents[idx_robot] = res.agent_mis_a_jour
        else
            println("Mission $i : Impossible de trouver un chemin sans collision.")
        end
    end
    return archives_missions
end

function reunir_stats(archives_missions)
    # Initialisation des compteurs
    total_temps = 0
    total_pas = 0
    missions_par_robot = Dict{Int, Int}()

    for m in archives_missions
        total_temps += m.duree
        total_pas += length(m.trajet_detaille)
        
        # On compte les missions par robot
        id = m.id_robot
        missions_par_robot[id] = get(missions_par_robot, id, 0) + 1
    end

    # Affichage simple des résultats
    println("BILAN DES MISSIONS :")
    println("Nombre total de missions : ", length(archives_missions))
    println("Distance totale : ", total_pas, " cases")
    println("Temps moyen : ", round(total_temps / length(archives_missions), digits=2))
    
    println("Missions par robot :")
    for id in sort(collect(keys(missions_par_robot)))
        println("Robot $id : $(missions_par_robot[id])")
    end
end

function retour_final_fin() 
end

function affichage_de_mes_sortie() 
end