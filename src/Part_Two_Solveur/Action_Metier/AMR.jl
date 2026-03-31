include("../../Security_Transformation/Structure.jl")
include("../Adaptation/Structure_Part2.jl")

function valider_agent_sur_carte(agent::Structure_Part2.AgentAMR, G_dict)
    return BFS_Action_dict(agent.depart_ag[1], agent.depart_ag[2], G_dict) &&
           BFS_Action_dict(agent.arrivee_ag[1], agent.arrivee_ag[2], G_dict)
end

function obtenir_position_t(chemin::Vector{Structure_Part2.tripletAMR}, t::Int)
    if t >= length(chemin)
        return (chemin[end].y, chemin[end].x)
    end
    return (chemin[t+1].y, chemin[t+1].x)
end
