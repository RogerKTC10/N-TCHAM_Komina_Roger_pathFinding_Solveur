module  Struct_Carte
   export ChargementGrille, 
          Carte_final_Struct, 
          Carte_Final_Value_Struct,
          Constructeur_Matrice_Cons,
          Constructeur_Matrice_Value

    struct ChargementGrille
        path :: String
        content :: String
    end

    struct Carte_final_Struct
        grille::Matrix{Char}  
        height::Int
        width::Int
    end
#Ca c'est pour Djisktra 
    struct Carte_Final_Value_Struct
        grille_val::Matrix{Float64}
        height_val::Int
        width_val::Int
    end

    #-----------CONSTRUCTEUR MATRICE_CONS DIRECTE-----------#

    function Constructeur_Matrice_Cons(grille::Matrix{Char})
        Carte_final_Struct(
            grille, 
            size(grille, 1),
            size(grille, 2))
    end

    function Constructeur_Matrice_Value(grille_poids::Matrix{Float64})
        Carte_Final_Value_Struct(
           grille_poids, 
           size(grille_poids, 1),
           size(grille_poids, 2))
    end

end
