function [bruit] = simu_bruit(type_b, N, m, sigma)
%SIMU_BRUIT
%  Cette fonction génère un vecteur de bruit selon le type choisi (gaussien
%  ou uniforme).
% ENTREES:
% type_b: 1: gaussien, 2: uniforme
% N: nombre de points
% m: moyenne du bruit
% sigma: écart-type du bruit
% SORTIES:
% bruit: vecteur de taille N contenant le bruit choisi

    switch type_b

        case 1   % Bruit gaussien
            bruit = m + sigma * randn(1, N);

        case 2   % Bruit uniforme centré
            bruit = 2 * rand(1, N) - 1 + m + sigma;
    end

end