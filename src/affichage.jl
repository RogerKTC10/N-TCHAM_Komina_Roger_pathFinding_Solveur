import Pkg
Pkg.add("Plots")
using Plots

#using .Struct_Carte

function affichage_BFS(carte, chemin, distance, activite)
    grille_recup  = zeros(Int, carte.height, carte.width)
    for i in 1:carte.height
        for j in 1:carte.width
            if carte.grille[i,j] == '@'
                grille_recup[i, j] = 1
            else
                grille_recup[i, j] = 0
            end
        end
    end

    affich = heatmap(grille_recup,
                  color = cgrad([:lightgrey, :brown]),
                  yflip = true,
                  aspect_ratio = :equal,
                  legend = false,
                  title = "Distance : $distance | Activité : $activite")
    if !isempty(chemin)
       x_coords = Int[]
       y_coords = Int[] 
       for (i, j) in chemin 
            push!(x_coords, j) 
            push!(y_coords, i)
       end 
       scatter!(affich, x_coords, y_coords, 
              color = :yellow, 
              markersize = 4, 
              label = "Chemin suivi par le BFS_Algo")
      scatter!(affich, [x_coords[1]], [y_coords[1]], color=:green, markersize=5, shape=:circle)
      scatter!(affich, [x_coords[end]], [y_coords[end]], color=:red, markersize=5, shape=:circle)
    
    end
    
    savefig(affich, "res/resultat_bfs.png")                   
end