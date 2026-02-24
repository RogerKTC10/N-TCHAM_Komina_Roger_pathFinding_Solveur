include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#Mes prpre doutes d'Action
#Ca m'a permis de tester donc BFS et Djistkra sur des point de depart et d'arriver douteuse
function trouver_points_pieges(matriceChar)
    h, w = size(matriceChar)
    
    # 1. On cherche d'abord un vrai piège (Eau ou Marais)
    for cible in ['W', 'S']
        for i in 100:h-100
            for j in 100:w-100
                if matriceChar[i, j] == cible
                    # On cherche du sol autour pour être SUR que le BFS peut démarrer
                    # On cherche dans un petit carré
                    for di in -5:5, dj in -5:5
                        ni, nj = i+di, j+dj
                        # On s'assure que le départ est du SOL ('.')
                        if ni>0 && ni<=h && nj>0 && nj<=w && matriceChar[ni, nj] == '.'
                            # On a trouvé un départ et une arrivée qui forcent le passage par l'obstacle
                            dep = (ni, nj)
                            arr = (ni+20, nj+20) # On crée un décalage
                            
                            println("🎯 Piège trouvé sur '$cible' !")
                            return dep, arr
                        end
                    end
                end
            end
        end
    end
    
    # 2. Si aucun obstacle, on cherche n'importe quel point de SOL
    # C'est ce qui évitera ton erreur "États: 1"
    for i in 1:h, j in 1:w
        if matriceChar[i, j] == '.'
            return (i, j), (h-i, w-j)
        end
    end
end

#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceChar)
    total_facture = 0.0

    # On parcourt le chemin à partir de la deuxième case
    for k in 2:length(chemin)
        i, j = chemin[k]
        caractere = matriceChar[i, j]
        prix_passage = valuation(caractere)
        
        total_facture += prix_passage
    end

    return total_facture
end

function CPUtime(depart_temps)
    return round(time() - depart_temps, digits=6)
end

function Number_State_Value(resultat_algo)
    return resultat_algo.activite
end