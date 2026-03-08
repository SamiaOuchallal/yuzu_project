function [a, b, y_pred, R2, b0, b1, sigma, et_b0, et_b1, et_sigma] = extract_p(x, y, choix_REG)

%EXTRACT_P
%  Cette fonction effectue la régression selon le modèle choisi, et
%  calcule les paramètres du modèle, les valeurs prédites, le coefficient
%  de détermination ainsi que les écarts-types des valeurs estimées.

% ENTREES:
% x: abscisses
% y: ordonnées
% choix_REG: régression choisie
% SORTIES:
% a:
% b:
% y_pred:
% R2:
% b0, b1:
% sigma:
% et_b0, et_b1:
% et_sigma:


    x = x(:);
    y = y(:);
    n = length(x);

    switch choix_REG

        case 'LIN'   % y = a x + b
            X = x;
            Y = y;
            B = polyfit(X, Y, 1);
            a = B(1);          
            b = B(2);          
            y_pred = a*x + b;
            b1 = a;
            b0 = b;

        case 'LN'    % y = a ln(x) + b
            X = log(x);
            Y = y;
            B = polyfit(X, Y, 1);
            a = B(1);
            b = B(2);
            y_pred = a*log(x) + b;
            b1 = a;
            b0 = b;

        case 'EXP'   % y = a e^(b x)
            X = x;
            Y = log(y);
            B = polyfit(X, Y, 1);
            b = B(1);
            a = exp(B(2));
            y_pred = a * exp(b*x);
            b1 = b;
            b0 = a;

        case 'PUI'   % y = a x^b
            X = log(x);
            Y = log(y);
            B = polyfit(X, Y, 1);
            b = B(1);
            a = exp(B(2));
            y_pred = a * x.^b;
            b1 = b;
            b0 = a;
    end

    res = y - y_pred;
    sse = sum(res.^2);
    sst = sum((y - mean(y)).^2);
    R2 = 1 - sse/sst;

    sigma = sqrt(sse / (n - 2));

    % variances des coefficients
    Sxx = sum((X - mean(X)).^2);

    var_b1 = sigma^2 / Sxx;
    var_b0 = sigma^2 * (1/n + mean(X)^2 / Sxx);

    et_b1 = sqrt(var_b1);
    et_b0 = sqrt(var_b0);

    % écart-type de sigma
    et_sigma = sigma / sqrt(2*(n - 2));


end