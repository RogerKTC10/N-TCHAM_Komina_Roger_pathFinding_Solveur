include("Structure.jl")
using .Struct_Carte: ChargementGrille

function verif_extension(path::String)
    if !isfile(path)
        error("Ce fichier n'existe pas dans votre structure\n $path")
    end
    if !endswith(path, ".map")
        error("Le fichier a la mauvaise extension, on ne peut valider le chargerment \n")
    end
    ligne = read(path, String)
    return ChargementGrille(path, ligne)
end

function nonVide(elts::ChargementGrille)
    if isempty(elts.content)
        error("Fichier vide, on a aucun element dans ton fichier \n")
    end
    return true
end

function entete_certifie(elts::ChargementGrille)
    decoupage = split(elts.content, "\n")
    if !isempty(decoupage)
        doc_type = false
        doc_height = false
        doc_width = false
        doc_map =  false

        for ligne in decoupage
            if startswith(ligne, "type")
                doc_type = true
            elseif startswith(ligne, "height")
                doc_height = true
            elseif startswith(ligne, "width")
                doc_width = true
            elseif startswith(ligne, "map")
                doc_map = true
            end
        end
        if (doc_type == true && doc_height == true && doc_width == true && doc_map == true)
            return (true, decoupage)
        else
            error("Fichier map ne respectant pas la norme Moving AI doc \n")
        end
    end
end

function charger_valider(path::String)
    elts = verif_extension(path) 
    nonVide(elts)
    decide, recup_decoup =  entete_certifie(elts)
    if decide 
       return recup_decoup
    else
        error("Echec de chargement")
    end
end

function scinder(lignes)
    debut = 1:4
    rest = 5:length(lignes)

    entete = lignes[debut]
    apres_entete = lignes[rest]

    return (entete, apres_entete)
end