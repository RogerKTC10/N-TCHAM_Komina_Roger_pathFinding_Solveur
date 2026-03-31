module Structure_Part2
export tripletAMR, IntervalleSIPP, AgentAMR, Commande
    struct tripletAMR
        y::Int
        x::Int
        t::Int
    end

    struct IntervalleSIPP
        t_debut::Int
        t_fin::Int
        crenaux::Int
    end

    struct AgentAMR
        id_Agent::Int
        depart_ag::Tuple{Int, Int}
        arrivee_ag::Tuple{Int, Int}
    end

    struct Commande
        id_colis_relais::Int
        position_relais::Tuple{Int, Int}
        numero_sous_ensDroit::Int
        position_droit::Tuple{Int, Int}
        accomplie::Bool
    end
end