include("FileSecurity.jl")


function Extraction(path::String)
    contenu = charger_valider(path)
    entete, apres_entete = scinder(contenu)
    recup_heigth = parse(Int, split(entete[2])[2])
    recup_width = parse(Int, split(entete[3])[2])
    nettoyage = String[] 
    for l in apres_entete
        ligne_propre = strip(l) 
        if !isempty(ligne_propre) 
            push!(nettoyage, ligne_propre) 
        end
    end
    return (recup_heigth, recup_width, nettoyage)
end

function nonAlterer(nettoyage, v_height, v_width)
    if length(nettoyage) != v_height
        error("Hauteur altéré")
    end
    
    for i in eachindex(nettoyage)
        if length(nettoyage[i]) != v_width
            error("Largeur altéré à la ligne $i")
        end
    end
    return true
end

function Matrice_Cons(h, w)
    return Matrix{Char}(undef, h, w)
end

function Matrice_Value(h, w)
    return Matrix{Float64}(undef, h, w)
end

function Remplir_Matrice_Cons(path::String)
    contenu = Extraction(path)
    h, w, donnee_recup = contenu
    if nonAlterer(donnee_recup, h, w)
       matriceCons = Matrice_Cons(h, w)
       for i in 1:h
            ligne = donnee_recup[i]
            for j in 1:w
                matriceCons[i, j] = ligne[j]
            end
        end
       return matriceCons
    end
end

function valuation(c::Char)
    if c == 'S'
        return 5.0 
    elseif c == 'W'
        return 8.0 
    elseif c == '@'
        return Inf  
    else
        return 1.0 
    end    
end

function Remplir_Matrice_Value(matrice::Matrix{Char})
    (h, w) = size(matrice)

    matriceValue = Matrice_Value(h, w)

    for i in 1:h 
        for j in 1:w
            matriceValue[i, j] = valuation(matrice[i, j])
        end
    end
    return matriceValue
end