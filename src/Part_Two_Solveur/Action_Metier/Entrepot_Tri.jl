function sous_ensemble_gauche(carte::Struct_Carte.Carte_Final_Value_Struct)
    liste_parking = []
    colonne_pk = 1    
    colonne_out = 2   
    
    for y in 1:carte.height_val
        if carte.grille_val[y, colonne_pk] == '.' && carte.grille_val[y, colonne_out] == '.'
            push!(liste_parking, (y, colonne_pk))
        end
    end
    return liste_parking
end

function zone_relais(carte::Struct_Carte.Carte_Final_Value_Struct)
    liste_marchandises = []
    
    milieu_x = div(carte.width_val, 2)
    milieu_y = div(carte.height_val, 2)
    
    for y in (milieu_y - 3):(milieu_y + 3)
        for x in (milieu_x - 2):(milieu_x + 2)
            if y > 0 && y <= carte.height_val && x > 0 && x <= carte.width_val
                # Utilisation de .grille_val ici aussi
                if carte.grille_val[y, x] == '.'
                    push!(liste_marchandises, (y, x))
                end
            end
        end
    end
    
    return liste_marchandises
end

function sous_ensemble_droit(carte::Struct_Carte.Carte_Final_Value_Struct)
    N = carte.width_val
    liste_quais = []
    
    for y in 1:carte.height_val
        if carte.grille_val[y, N] == '.' 
            push!(liste_quais, (y, N))
        end
    end
    return liste_quais
end