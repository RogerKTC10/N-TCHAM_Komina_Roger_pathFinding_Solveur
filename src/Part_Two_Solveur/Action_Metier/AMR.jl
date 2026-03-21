include("../../Security_Transformation/Structure.jl")
include("../Adaptation/Structure_Part2.jl")

using .Structure
using .Structure_Part2

function valider_agent_sur_carte(agent::AgentAMR, G_dict)
    return BFS_Action_dict(agent.depart_ag[1], agent.depart_ag[2], G_dict) &&
           BFS_Action_dict(agent.arrivee_ag[1], agent.arrivee_ag[2], G_dict)
end

function obtenir_position_t(chemin::Vector{tripletAMR}, t::Int)
    if t >= length(chemin)
        return (chemin[end].x, chemin[end].y)
    end
    return (chemin[t+1].x, chemin[t+1].y)
end
