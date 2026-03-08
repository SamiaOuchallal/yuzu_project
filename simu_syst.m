function [n,y] = simu_syst(type, xmin, xmax, a, b, N)
%SIMU_SYST
%  Cette fonction génère un ensemble de points selon le système choisi
%  (linéaire, logarithmique, puissance ou exponentiel.
% ENTREES:
% type: 1: linéaire, 2: logarithmique, 3: puissance, 4: exponentiel
% xmin: borne minimale de l'intervalle
% xmax: borne maximale de l'intervalle
% a: premier paramètre
% b: second paramètre
% N: nombre de points
% SORTIES:
% n: vecteur de N points entre xmin et xmax
% y: valeurs


    n = linspace(xmin, xmax, N)
    switch type
        case 1
            y = a*n + b;

        case 2
            y = a*log(b*n);

        case 3
            y = a*n.^b;

        case 4
            y = a*exp(b*n);
         
    end

end