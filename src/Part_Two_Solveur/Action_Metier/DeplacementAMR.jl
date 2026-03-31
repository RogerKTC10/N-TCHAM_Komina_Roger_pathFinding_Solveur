include("AMR.jl")
include("Entrepot_Tri.jl")
include("Fournisseur&Client.jl")

using .Structure_Part2

function calcul_mission_complete(agent::Structure_Part2.AgentAMR, commande::Structure_Part2.Commande, carte, G_dict, intervalles_dict)
    t_initial = 0 
    chemin_aller, cout_1, nodes_1 = execution_Etoile_Adaptation(carte, agent.depart_ag, commande.position_relais, G_dict, intervalles_dict)
    
    if isempty(chemin_aller)
        return nothing
    end

    t_arrivee_colis = chemin_aller[end].t 
    
    chemin_livraison, cout_2, nodes_2 = execution_Etoile_Adaptation(carte, commande.position_relais, commande.position_droit, G_dict, intervalles_dict)

    if isempty(chemin_livraison)
        return (trajet = chemin_aller, agent_mis_a_jour = agent, cout_total = cout_1, exploration = nodes_1)
    end

    chemin_total = vcat(chemin_aller, chemin_livraison[2:end])
    
    nouvel_agent = Structure_Part2.AgentAMR(agent.id_Agent, commande.position_droit, (0,0))
    
    return (trajet = chemin_total, agent_mis_a_jour = nouvel_agent, cout_total = cout_1 + cout_2, exploration = nodes_1 + nodes_2)
end


function planification_AMR(liste_agents, carnet, carte, G_dict, intervalles_dict)
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
end


function Gestion_des_Accidents() 
end

function reunir_stat() 
end

function retour_final_fin() 
end

function affichage_de_mes_sortie() 
end