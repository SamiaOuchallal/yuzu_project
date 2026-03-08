function interface_main()

    global donnees_pretes theme_actuel;
    donnees_pretes = false;
    theme_actuel = 'Yuzu';


% Création de la fenêtre principale

    f = figure('Name','YUZU', 'Units', 'normalized', 'NumberTitle', 'off', 'Position', [0.07 0.1 0.85 0.85], 'Color', [255 250 200]/255);
    set(f, 'MenuBar', 'none');    

% Composants principaux
    
    panel_fct = uipanel('Parent',f, 'Units', 'normalized','Position',[0 0.4 0.5 0.5], 'ForegroundColor', [0 0 0], 'BackgroundColor', [255 250 200]/255);
    panel_regression = uipanel('Parent',f, 'Units', 'normalized', 'Position',[0.5 0.4 0.5 0.5], 'ForegroundColor', [0 0 0], 'BackgroundColor', [255 250 200]/255);
    panel_affichage = uipanel('Parent',f, 'Units', 'normalized', 'Position',[0 0 1 0.5], 'ForegroundColor', [0 0 0], 'BackgroundColor', [255 250 200]/255);
    
    panel_pres = uipanel('Parent', f, 'Units', 'normalized', 'Position', [0 0.85 1 0.15], 'BackgroundColor', [223 248 6]/255);

% panel_pres:

    uilabel('Parent', panel_pres, 'Text', 'Bienvenue dans Yuzu !','Position',[550 35 700 50], 'FontSize',15,'FontColor',[0.1 0.1 0.1], 'FontWeight', 'bold');
    
    uilabel('Parent', panel_pres, 'Text', 'GONCALVES Mateo, LITOU Olivia, OUCHALLAL Samia, VOMO Marlène', 'Position', [440 0 700 50], 'FontSize', 12, 'FontWeight', 'bold', 'FontColor', [0 0 0]);

    ax1 = uiaxes('Parent', panel_pres, 'Units', 'normalized', 'Position', [0.01 0.05 0.25 0.85]);
    imshow('yuzu.jpg', 'Parent', ax1);
    axis(ax1, 'off');

    ax2 = uiaxes('Parent', panel_pres, 'Units', 'normalized', 'Position', [0.74 0.05 0.25 0.85]);
    imshow('EPISEN_logo-RVB.jpg', 'Parent', ax2);
    axis(ax2, 'off');

    btn_debug = uibutton(panel_pres, 'Text','Débug', 'Position',[15 5 90 30], 'ButtonPushedFcn', @mode_debug, 'BackgroundColor',[168 245 226]/255, 'FontColor', [0 0 0]);
    btn_reset = uibutton(panel_pres, 'Text','Reset', 'Position', [15 40 90 30], 'ButtonPushedFcn',@reset_interface, 'BackgroundColor', [168 245 226]/255, 'FontColor',[0 0 0])
    btn_pdf = uibutton(panel_pres, 'Text', 'PDF', 'Position', [15 75 90 30], 'ButtonPushedFcn',@export_pdf, 'BackgroundColor', [168 245 226]/255, 'FontColor', [0 0 0])


% panel_fct:

    panel_page1 = uipanel('Parent',panel_fct, 'Position',[0 0 1 1], 'Visible','on', 'BackgroundColor',[255 250 200]/255);
    panel_page2 = uipanel('Parent',panel_fct, 'Position',[0 0 1 1], 'Visible','off', 'BackgroundColor',[255 250 200]/255);

    btn_page1 = uicontrol('Parent',panel_fct, 'Style','pushbutton', 'String','Paramètres du système', 'Position',[150 290 130 25], 'Callback',@afficher_page1, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);
    btn_page2 = uicontrol('Parent',panel_fct, 'Style','pushbutton', 'String','Paramètres du bruit', 'Position',[350 290 120 25], 'Callback',@afficher_page2, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);


    % Sous-panel: panel_page1:

    panel_page11 = uipanel('Parent',panel_page1, 'Position',[0 0 1 1], 'Visible','on', 'BackgroundColor',[255 250 200]/255);
    panel_page12 = uipanel('Parent',panel_page1, 'Position',[0 0 1 1], 'Visible','off', 'BackgroundColor',[255 250 200]/255);
    panel_page13 = uipanel('Parent',panel_page1, 'Position',[0 0 1 1], 'Visible','off', 'BackgroundColor',[255 250 200]/255);
    panel_page14 = uipanel('Parent',panel_page1, 'Position',[0 0 1 1], 'Visible','off', 'BackgroundColor',[255 250 200]/255);


    btn_page11 = uicontrol('Parent',panel_page1, 'Style','pushbutton', 'String','Linéaire (y=ax+b)', 'Position',[20 210 130 25], 'Callback',@afficher_panel_page11, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);
    btn_page12 = uicontrol('Parent',panel_page1, 'Style','pushbutton', 'String','Logarithmique (y=log(x))', 'Position',[20 180 130 25], 'Callback',@afficher_panel_page12, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);
    btn_page13 = uicontrol('Parent',panel_page1, 'Style','pushbutton', 'String','Puissance (y=λx**µ)', 'Position',[20 150 130 25], 'Callback',@afficher_panel_page13, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);
    btn_page14 = uicontrol('Parent',panel_page1, 'Style','pushbutton', 'String','Exponentielle (y=λexp(µx))', 'Position',[20 120 130 25], 'Callback',@afficher_panel_page14, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);
   

    btn_page11.BackgroundColor = [168 245 226]/255;
    btn_page11.ForegroundColor = [0 0 0]

    btn_valider = uicontrol('Parent',panel_page1, 'Style','pushbutton', 'String','Valider', 'Position',[460 250 80 25], 'Callback',@valider_nb_pts, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);


    nb_pts_field = uislider('Parent', panel_page1,'Position', [170 260 260 30], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_nb_pts_value, 'FontColor',[0 0 0])
    nb_pts_label = uilabel(panel_page1,'Text', 'Nombre de points = 0', 'Position', [15 250 165 25], 'FontColor', [0 0 0]);


    global type_f;
    type_f = 1;

        % panel_page11 : Linéaire

    xmin_field_li = uislider('Parent', panel_page11,'Position', [270 200 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmin_field_li_label = uilabel(panel_page11,'Text', 'xmin = 0', 'Position', [200 190 80 25], 'FontColor', [0 0 0]);

    xmax_field_li = uislider('Parent', panel_page11,'Position', [270 140 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmax_field_li_label = uilabel(panel_page11,'Text', 'xmax = 0', 'Position', [200 130 80 25], 'FontColor', [0 0 0]);

    a_field_li = uislider('Parent', panel_page11,'Position', [470 200 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    a_field_li_label = uilabel(panel_page11,'Text', 'a = 0', 'Position', [400 190 80 25], 'FontColor', [0 0 0]);

    b_field_li = uislider('Parent', panel_page11,'Position', [470 140 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    b_field_li_label = uilabel(panel_page11,'Text', 'b = 0', 'Position', [400 130 80 25], 'FontColor', [0 0 0]);


    btn_valider_li = uicontrol('Parent', panel_page11, 'Style', 'pushbutton', 'String','Valider', 'Position', [380 80 80 25], 'Callback', @valider_lineaire,'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0])


        % panel_page12 : Logarithmique

    xmin_field_lo = uislider('Parent', panel_page12,'Position', [270 200 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmin_field_lo_label = uilabel(panel_page12,'Text', 'xmin = 0', 'Position', [200 190 80 25], 'FontColor', [0 0 0]);

    xmax_field_lo = uislider('Parent', panel_page12,'Position', [270 140 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmax_field_lo_label = uilabel(panel_page12,'Text', 'xmax = 0', 'Position', [200 130 80 25], 'FontColor', [0 0 0]);

    a_field_lo = uislider('Parent', panel_page12,'Position', [470 200 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    a_field_lo_label = uilabel(panel_page12,'Text', 'λ = 0', 'Position', [400 190 80 25], 'FontColor', [0 0 0]);

    b_field_lo = uislider('Parent', panel_page12,'Position', [470 140 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    b_field_lo_label = uilabel(panel_page12,'Text', 'μ = 0', 'Position', [400 130 80 25], 'FontColor', [0 0 0]);


    btn_valider_lo = uicontrol('Parent', panel_page12, 'Style', 'pushbutton', 'String','Valider', 'Position', [380 80 80 25], 'Callback', @valider_logarithme, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0])



        % panel_page13 : Puissance

    xmin_field_pu = uislider('Parent', panel_page13,'Position', [270 200 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmin_field_pu_label = uilabel(panel_page13,'Text', 'xmin = 0', 'Position', [200 190 80 25], 'FontColor', [0 0 0]);

    xmax_field_pu = uislider('Parent', panel_page13,'Position', [270 140 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmax_field_pu_label = uilabel(panel_page13,'Text', 'xmax = 0', 'Position',[200 130 80 25], 'FontColor', [0 0 0]);

    a_field_pu = uislider('Parent', panel_page13,'Position', [470 200 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    a_field_pu_label = uilabel(panel_page13,'Text', 'λ = 0', 'Position', [400 190 80 25], 'FontColor', [0 0 0]);

    b_field_pu = uislider('Parent', panel_page13,'Position', [470 140 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    b_field_pu_label = uilabel(panel_page13,'Text', 'μ = 0', 'Position', [400 130 80 25], 'FontColor', [0 0 0]);


    btn_valider_pu = uicontrol('Parent', panel_page13, 'Style', 'pushbutton', 'String','Valider', 'Position', [380 80 80 25], 'Callback', @valider_puissance, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0])



        % panel_page14 : Exponentielle

    xmin_field_ex = uislider('Parent', panel_page14,'Position', [270 200 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmin_field_ex_label = uilabel(panel_page14,'Text', 'xmin = 0', 'Position', [200 190 80 25], 'FontColor', [0 0 0]);

    xmax_field_ex = uislider('Parent', panel_page14,'Position', [270 140 100 25], 'Limits', [1 1000], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    xmax_field_ex_label = uilabel(panel_page14,'Text', 'xmax = 0', 'Position', [200 130 80 25], 'FontColor', [0 0 0]);

    a_field_ex = uislider('Parent', panel_page14,'Position', [470 200 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    a_field_ex_label = uilabel(panel_page14,'Text', 'λ = 0', 'Position',[400 190 80 25], 'FontColor', [0 0 0]);

    b_field_ex = uislider('Parent', panel_page14,'Position', [470 140 100 25], 'Limits', [1 500], 'Value',1, 'ValueChangedFcn',@update_slider, 'FontColor',[0 0 0])
    b_field_ex_label = uilabel(panel_page14,'Text', 'μ = 0', 'Position', [400 130 80 25], 'FontColor', [0 0 0]);


    btn_valider_ex = uicontrol('Parent', panel_page14, 'Style', 'pushbutton', 'String','Valider', 'Position', [380 80 80 25], 'Callback', @valider_exponentielle, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0])



    % Sous-panel: panel_page2:

    popup_bruit = uicontrol('Parent',panel_page2,'Style','popupmenu', 'String',{'Gaussien','Uniforme'},'Position',[20 150 120 25], 'Callback',@popup_bruit_callback, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);

    m_field = uislider('Parent', panel_page2, 'Position', [310 200 100 25], 'FontColor',[0 0 0] , 'Limits', [-100 100], 'Value',0, 'ValueChangedFcn',@update_m_value)
    m_label = uilabel(panel_page2,'Text', 'm = 0', 'Position', [240 190 80 22], 'FontColor',[0 0 0]);
    
    sigma_field = uislider('Parent', panel_page2, 'Position', [310 150 100 25], 'FontColor',[0 0 0], 'Limits', [-100 100], 'Value',0, 'ValueChangedFcn',@update_sigma_value)
    sigma_label = uilabel(panel_page2,'Text', 'σ = 0', 'Position', [240 140 80 22], 'FontColor',[0 0 0]);


    btn_valider_b = uicontrol('Parent', panel_page2, 'Style', 'pushbutton', 'String','Valider', 'Position', [450 100 80 25], 'Callback', @valider_bruit, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0])


% panel_regression:

    btn_regression_li = uibutton(panel_regression, 'Text','Régression linéaire', 'Position',[20 250 150 30], 'ButtonPushedFcn', @valider_regression_lineaire, 'BackgroundColor',[7 209 102]/255, 'FontColor', [0 0 0]);
    btn_regression_lo = uibutton(panel_regression, 'Text','Régression logarithmique', 'Position',[20 200 150 30], 'ButtonPushedFcn', @valider_regression_logarithme, 'BackgroundColor',[7 209 102]/255, 'FontColor', [0 0 0]);
    btn_regression_pu = uibutton(panel_regression, 'Text','Régression puissance', 'Position',[20 150 150 30], 'ButtonPushedFcn', @valider_regression_puissance, 'BackgroundColor',[7 209 102]/255, 'FontColor', [0 0 0]);
    btn_regression_ex = uibutton(panel_regression, 'Text','Régression exponentielle', 'Position',[20 100 150 30], 'ButtonPushedFcn', @valider_regression_exponentielle, 'BackgroundColor',[7 209 102]/255, 'FontColor', [0 0 0]);
    
    
    label_R2 = uilabel('Parent', panel_regression, 'Text', 'R² : --', 'Position', [190 250 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    label_b0 = uilabel('Parent', panel_regression, 'Text', 'b₀ : --', 'Position', [190 200 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    label_b1 = uilabel('Parent', panel_regression, 'Text', 'b₁ : --', 'Position', [190 150 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    label_sigma = uilabel('Parent', panel_regression, 'Text', 'σ : --', 'Position', [190 100 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
   

    label_et_b0 = uilabel('Parent', panel_regression, 'Text', 'σ(b₀) : --', 'Position', [310 200 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    label_et_b1 = uilabel('Parent', panel_regression, 'Text', 'σ(b₁) : --', 'Position', [310 150 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    label_et_sigma = uilabel('Parent', panel_regression, 'Text', 'σ(σ) : --', 'Position', [310 100 200 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    

    label_best = uilabel('Parent', panel_regression, 'Text', 'Meilleure régression : --', 'Position', [310 250 300 30], 'FontSize', 14, 'FontWeight', 'bold', 'FontColor', [0 0 0]);
    


% panel_affichage:

    choix = uibuttongroup('Parent', panel_affichage, 'Units', 'pixels', 'Position', [50 100 200 150], 'BackgroundColor', panel_affichage.BackgroundColor, 'SelectionChangedFcn', @choix_affichage, 'BorderColor', panel_affichage.BackgroundColor)

    c1 = uicontrol(choix,'Style','radiobutton', 'String','Système','Position',[20 100 150 25],'BackgroundColor',panel_affichage.BackgroundColor, 'ForegroundColor', [0 0 0], 'FontSize', 12);
    c2 = uicontrol(choix,'Style','radiobutton','String','Bruit','Position',[20 70 150 25], 'BackgroundColor',panel_affichage.BackgroundColor, 'ForegroundColor', [0 0 0], 'FontSize', 12);
    c3 = uicontrol(choix,'Style','radiobutton', 'String','Système bruité','Position',[20 40 150 25],'BackgroundColor',panel_affichage.BackgroundColor, 'ForegroundColor', [0 0 0], 'FontSize', 12);


    graphe = axes('Parent', panel_affichage,'Units', 'normalized', 'Position', [0.25 0.1 0.5 0.8], 'Box', 'on', 'Color', [255 250 200]/255, 'XColor', [0 0 0], 'YColor', [0 0 0] );
    btn_afficher = uicontrol('Parent', panel_affichage, 'Style', 'pushbutton', 'String', 'Générer', 'Units', 'normalized', 'Position', [0.85 0.35 0.1 0.1], 'Callback', @generer_graphe, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);

    btn_courbe_uniforme = uicontrol('Parent', panel_affichage, 'Enable', 'off', 'Style', 'pushbutton', 'String', 'Courbe uniforme', 'Units', 'normalized', 'Position', [0.85 0.50 0.1 0.1], 'Callback', @generer_courbe_uniforme, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);
    btn_courbe_gaussienne = uicontrol('Parent', panel_affichage, 'Enable', 'off', 'Style', 'pushbutton', 'String', 'Courbe gaussienne', 'Units', 'normalized', 'Position', [0.85 0.65 0.1 0.1], 'Callback', @generer_courbe_gaussienne, 'BackgroundColor', [7 209 102]/255, 'ForegroundColor', [0 0 0]);


    tips = [
    "Astuce: le bruit gaussien adore sigma = 1."
    "Astuce: log(x) ne marche pas si x ≤ 0."
    "Astuce: plus il y a de bruit, plus R² pleure."
    "Astuce: la régression puissance aime le positif."
    "On met du bruit, mais jamais au hasard."
    "Astuce: avant de partir, dites-nous bisous !"
    ];

    uilabel('Parent', panel_affichage, 'Text', tips(randi(numel(tips))),'Position',[990 315 700 50], 'FontSize',15,'FontColor',[0.1 0.1 0.1], 'FontAngle', 'italic');


    theme_menu = uidropdown(f,'Items', {'Yuzu', 'Orange', 'Pamplemousse'}, 'Value', 'Yuzu', 'Position', [35 80 150 30], 'ValueChangedFcn', @changer_theme);

% Callbacks

    function valider_nb_pts(src, event)
        nb_pts = round(nb_pts_field.Value);
        disp(nb_pts)
    end


    function afficher_page1(src, event)
        panel_page1.Visible = 'on';
        panel_page2.Visible = 'off';
    end


    function afficher_page2(src, event)
        panel_page1.Visible = 'off';
        panel_page2.Visible = 'on';
    end


    function popup_bruit_callback(src, event)
        val = src.Value; 
    
        switch val
            case 1   % gaussien
                m_field.Enable = 'on';
                sigma_field.Enable = 'on';
    
            case 2   % uniforme
                m_field.Enable = 'off';
                sigma_field.Enable = 'off';
        end
    end


    function afficher_panel_page11(src, event)
        type_f = 1;
        panel_page12.Visible = 'off';
        panel_page13.Visible = 'off';
        panel_page14.Visible = 'off';
        panel_page11.Visible = 'on';

        btn_page11.BackgroundColor = [168 245 226]/255;
        btn_page11.ForegroundColor = [0 0 0];

        btn_page12.BackgroundColor = [7 209 102]/255;
        btn_page13.BackgroundColor = [7 209 102]/255;
        btn_page14.BackgroundColor = [7 209 102]/255;
    end

    function afficher_panel_page12(src, event)
        type_f = 2;
        panel_page11.Visible = 'off';
        panel_page13.Visible = 'off';
        panel_page14.Visible = 'off';
        panel_page12.Visible = 'on';

        btn_page12.BackgroundColor = [168 245 226]/255;
        btn_page12.ForegroundColor = [0 0 0];

        btn_page11.BackgroundColor = [7 209 102]/255;
        btn_page13.BackgroundColor = [7 209 102]/255;
        btn_page14.BackgroundColor = [7 209 102]/255;

    end

    function afficher_panel_page13(src, event)
        type_f = 3;
        panel_page11.Visible = 'off';
        panel_page12.Visible = 'off';
        panel_page14.Visible = 'off';
        panel_page13.Visible = 'on';

        
        btn_page13.BackgroundColor = [168 245 226]/255;
        btn_page13.ForegroundColor = [0 0 0]

        btn_page12.BackgroundColor = [7 209 102]/255;
        btn_page11.BackgroundColor = [7 209 102]/255;
        btn_page14.BackgroundColor = [7 209 102]/255;
    end

    function afficher_panel_page14(src, event)
        type_f = 4;
        panel_page11.Visible = 'off';
        panel_page12.Visible = 'off';
        panel_page13.Visible = 'off';
        panel_page14.Visible = 'on';
        btn_page14.BackgroundColor = [168 245 226]/255;
        btn_page14.ForegroundColor = [0 0 0]

        btn_page12.BackgroundColor = [7 209 102]/255;
        btn_page13.BackgroundColor = [7 209 102]/255;
        btn_page11.BackgroundColor = [7 209 102]/255;
    end

    function valider_lineaire(src, event)
        a = a_field_li.Value;
        b = b_field_li.Value;
        xmin = xmin_field_li.Value;
        xmax = xmax_field_li.Value;

        if isnan(a) || isnan(b) || isnan(xmin) || isnan(xmax)
            disp("Erreur: certaines valeurs ne sont pas numériques !")
            return
        end

        if xmin >= xmax
            disp("Erreur: xmin doit être inférieur à xmax !");
            uialert(f, "xmin doit être inférieur à xmax !", 'YUZU a détecté une erreur !', 'Icon','error')
            return
        end

        disp("Paramètres du système linéaire: ")
        disp("a = " + a)
        disp("b = " + b)
        disp("xmin = " + xmin)
        disp("xmax = " + xmax)

    end


    function valider_logarithme(src, event)
        a = a_field_lo.Value;
        b = b_field_lo.Value;
        xmin = xmin_field_lo.Value;
        xmax = xmax_field_lo.Value;

        if isnan(a) || isnan(b) || isnan(xmin) || isnan(xmax)
            disp("Erreur: certaines valeurs ne sont pas numériques !")
            return
        end


        if xmin >= xmax
            disp("Erreur: xmin doit être inférieur à xmax !");
            uialert(f, "xmin doit être inférieur à xmax !", 'YUZU a détecté une erreur !', 'Icon','error')
            return
        end

        disp("Paramètres du système logarithmique: ")
        disp("a = " + a)
        disp("b = " + b)
        disp("xmin = " + xmin)
        disp("xmax = " + xmax)

    end


    function valider_puissance(src, event)
        a = a_field_pu.Value;
        b = b_field_pu.Value;
        xmin = xmin_field_pu.Value;
        xmax = xmax_field_pu.Value;

        if isnan(a) || isnan(b) || isnan(xmin) || isnan(xmax)
            disp("Erreur: certaines valeurs ne sont pas numériques !")
            return
        end


        if xmin >= xmax
            disp("Erreur: xmin doit être inférieur à xmax !");
            uialert(f, "xmin doit être inférieur à xmax !", 'YUZU a détecté une erreur !', 'Icon','error')
            return
        end

        disp("Paramètres du système puissance: ")
        disp("a = " + a)
        disp("b = " + b)
        disp("xmin = " + xmin)
        disp("xmax = " + xmax)

    end


    function valider_exponentielle(src, event)
        a = a_field_ex.Value;
        b = b_field_ex.Value;
        xmin = xmin_field_ex.Value;
        xmax = xmax_field_ex.Value;

        if isnan(a) || isnan(b) || isnan(xmin) || isnan(xmax)
            disp("Erreur: certaines valeurs ne sont pas numériques !")
            return
        end

        if xmin >= xmax
            disp("Erreur: xmin doit être inférieur à xmax !");
            uialert(f, "xmin doit être inférieur à xmax !", 'YUZU a détecté une erreur !', 'Icon','error')
            return
        end

        disp("Paramètres du système exponentiel: ")
        disp("a = " + a)
        disp("b = " + b)
        disp("xmin = " + xmin)
        disp("xmax = " + xmax)

    end



    function valider_bruit(~,~)

        type_b = popup_bruit.Value; 
    
        switch type_b
    
            case 1   % gaussien
                m = m_field.Value;
                sigma = sigma_field.Value;
    
                if isnan(m) || isnan(sigma)
                    disp("Erreur : m ou sigma non numérique !");
                    return
                end
    
                disp("Paramètres du bruit gaussien :")
                disp("m = " + m)
                disp("sigma = " + sigma)
    
            case 2   % uniforme
                disp("Bruit uniforme validé.")
                
        end
    end


    function choix_affichage(src, event)
        choix_ul = event.NewValue.String;
        disp(choix_ul)
    end

    function generer_graphe(~,~)
         choix_u = choix.SelectedObject.String;
         N = round(nb_pts_field.Value);

         if strcmp(choix_u, 'Bruit')

            type_b = popup_bruit.Value;
            m = m_field.Value;
            sigma = sigma_field.Value;
    
            if type_b == 1
                btn_courbe_gaussienne.Enable = 'on';
                bruit = simu_bruit(type_b, N, m, sigma);

            elseif type_b == 2
                btn_courbe_uniforme.Enable = 'on';
                z = 0
                bruit = simu_bruit(type_b, N, z, z);
            
            donnees_pretes = false;

            end
    
            t = 1:N;
    
            cla(graphe)

            plot(graphe, t, bruit, 'LineWidth', 2, 'MarkerFaceColor',[168 245 226]/255);
            bruit_fruite();
           
            switch theme_actuel
                case 'Yuzu'
                    graphe.Color = [1 0.98 0.85];
                    graphe.XColor = [0.4 0.3 0];
                    graphe.YColor = [0.4 0.3 0];
            
                case 'Orange'
                    graphe.Color = [1 0.9 0.75];
                    graphe.XColor = [0.4 0.2 0];
                    graphe.YColor = [0.4 0.2 0];
            
                case 'Pamplemousse'
                    graphe.Color = [1 0.88 0.94];
                    graphe.XColor = [0.5 0 0.3];
                    graphe.YColor = [0.5 0 0.3];
            end
            return
        end


        switch type_f
            case 1   % linéaire
                a = a_field_li.Value;
                b = b_field_li.Value;
                xmin = xmin_field_li.Value;
                xmax = xmax_field_li.Value;
        
            case 2   % logarithmique
                a = a_field_lo.Value;
                b = b_field_lo.Value;
                xmin = xmin_field_lo.Value;
                xmax = xmax_field_lo.Value;
        
            case 3   % puissance
                a = a_field_pu.Value;
                b = b_field_pu.Value;
                xmin = xmin_field_pu.Value;
                xmax = xmax_field_pu.Value;
        
            case 4   % exponentielle
                a = a_field_ex.Value;
                b = b_field_ex.Value;
                xmin = xmin_field_ex.Value;
                xmax = xmax_field_ex.Value;
        end
    
        [t, systeme] = simu_syst(type_f, a, b, xmin, xmax, N);

        type_b = popup_bruit.Value;

        m = m_field.Value;
        sigma = sigma_field.Value;

        bruit = simu_bruit(type_b, N, m, sigma);

        systeme_bruite = systeme + bruit

        x_global = t;
        y_global = systeme_bruite;

        cla(graphe)

        switch choix_u
            case 'Système'
                plot(graphe, t, systeme, 'LineWidth', 2, 'MarkerFaceColor',[168 245 226]/255)
                bruit_fruite();
                switch theme_actuel
                    case 'Yuzu'
                        graphe.Color = [1 0.98 0.85];
                        graphe.XColor = [0.4 0.3 0];
                        graphe.YColor = [0.4 0.3 0];
                
                    case 'Orange'
                        graphe.Color = [1 0.9 0.75];
                        graphe.XColor = [0.4 0.2 0];
                        graphe.YColor = [0.4 0.2 0];
                
                    case 'Pamplemousse'
                        graphe.Color = [1 0.88 0.94];
                        graphe.XColor = [0.5 0 0.3];
                        graphe.YColor = [0.5 0 0.3];
                end
                donnees_pretes = false;
        
            case 'Système bruité'
               c = [49 122 193]/255;

               graphe.NextPlot = 'add';
               switch theme_actuel
                case 'Yuzu'
                    graphe.Color = [1 0.98 0.85];
                    graphe.XColor = [0.4 0.3 0];
                    graphe.YColor = [0.4 0.3 0];
            
                case 'Orange'
                    graphe.Color = [1 0.9 0.75];
                    graphe.XColor = [0.4 0.2 0];
                    graphe.YColor = [0.4 0.2 0];
            
                case 'Pamplemousse'
                    graphe.Color = [1 0.88 0.94];
                    graphe.XColor = [0.5 0 0.3];
                    graphe.YColor = [0.5 0 0.3];
            end

               scatter(graphe, t, systeme_bruite, 5, c, 'filled');
               donnees_pretes = true;

            end

    end


    function generer_courbe_gaussienne(~,~)
        m = m_field.Value;
        sigma = sigma_field.Value;
        N = round(nb_pts_field.Value);
        
        bruit = simu_bruit(1, N, m, sigma);
        cla(graphe);
        histogram(graphe, bruit, 20, 'Normalization','pdf');
        hold(graphe, 'on');

        x = linspace(min(bruit), max(bruit), 200);
        gauss_courbe = (1/(sigma*sqrt(2*pi))) * exp(-((x - m).^2) / (2*sigma^2));
        plot(graphe, x, gauss_courbe, 'r-', 'LineWidth', 2, 'MarkerFaceColor',[168 245 226]/255);
        bruit_fruite();
      
        graphe.XColor = [0 0 0]; 
        graphe.YColor = [0 0 0];
        graphe.Color = [255 250 200]/255;

        title(graphe, 'Histogramme du bruit gaussien', 'Color', [0 0 0]);
        xlabel(graphe, 'Valeurs', 'Color', [0 0 0]);
        ylabel(graphe, 'Fréquence', 'Color', [0 0 0]);

        hold(graphe,'off');

    end 


    function generer_courbe_uniforme(~,~)
        N = round(nb_pts_field.Value);
        
        bruit = simu_bruit(2, N, 0, 0);
        cla(graphe)
        histogram(graphe, bruit, 20, 'Normalization','pdf');

        title(graphe, 'Histogramme du bruit uniforme', 'Color', [0 0 0])
        xlabel(graphe, 'Valeurs', 'Color', [0 0 0])
        ylabel(graphe, 'Fréquence', 'Color', [0 0 0])

        hold(graphe, 'on');

        a = -1;
        b = 1;
        y = 1 / (b - a);

        plot(graphe, [a b], [y y], 'r-', 'LineWidth', 2, 'MarkerFaceColor',[168 245 226]/255);
        bruit_fruite();
      
        graphe.Color = [255 250 200]/255;
        graphe.XLabel.Color = [0 0 0];
        graphe.YLabel.Color = [0 0 0];
        graphe.Title.Color  = [0 0 0];
        graphe.XColor = [0 0 0];
        graphe.YColor = [0 0 0];
        
        title(graphe, 'Histogramme du bruit uniforme', 'Color', [0 0 0]);
        xlabel(graphe, 'Valeurs', 'Color', [0 0 0]);
        ylabel(graphe, 'Fréquence', 'Color', [0 0 0]);

        hold(graphe,'off');
    end 


    function update_m_value(src, ~)
        m_label.Text = sprintf('m = %.2f', src.Value);
    end

    function update_sigma_value(src, ~)
        sigma_label.Text = sprintf('σ = %.2f', src.Value);
    end

    function update_nb_pts_value(src, ~)
        nb_pts_label.Text = sprintf('Nombre de points = %d', round(src.Value));
    end


    function update_slider(src, ~)
        switch src
            case xmin_field_li
                xmin_field_li_label.Text = sprintf('xmin = %.0f', src.Value);
            case xmax_field_li
                xmax_field_li_label.Text = sprintf('xmax = %.0f', src.Value);
            case a_field_li
                a_field_li_label.Text = sprintf('a = %.0f', src.Value);
            case b_field_li
                b_field_li_label.Text = sprintf('b = %.0f', src.Value);
    
            case xmin_field_lo
                xmin_field_lo_label.Text = sprintf('xmin = %.0f', src.Value);
            case xmax_field_lo
                xmax_field_lo_label.Text = sprintf('xmax = %.0f', src.Value);
            case a_field_lo
                a_field_lo_label.Text = sprintf('λ = %.0f', src.Value);
            case b_field_lo
                b_field_lo_label.Text = sprintf('μ = %.0f', src.Value);

            case xmin_field_pu
                xmin_field_pu_label.Text = sprintf('xmin = %.0f', src.Value);
            case xmax_field_pu
                xmax_field_pu_label.Text = sprintf('xmax = %.0f', src.Value);
            case a_field_pu
                a_field_pu_label.Text = sprintf('λ = %.0f', src.Value);
            case b_field_pu
                b_field_pu_label.Text = sprintf('μ = %.0f', src.Value);

            case xmin_field_ex
                xmin_field_ex_label.Text = sprintf('xmin = %.0f', src.Value);
            case xmax_field_ex
                xmax_field_ex_label.Text = sprintf('xmax = %.0f', src.Value);
            case a_field_ex
                a_field_ex_label.Text = sprintf('λ = %.0f', src.Value);
            case b_field_ex
                b_field_ex_label.Text = sprintf('μ = %.0f', src.Value);

        end
    end

    x_global = [];
    y_global = [];


    function valider_regression_lineaire(src, event)
        if ~donnees_pretes
            return;
        end
    
        persistent plot_li;
    
        if ~isempty(plot_li) && isvalid(plot_li)
            delete(plot_li);
            plot_li = [];
    
            btn_regression_lo.Enable = 'on';
            btn_regression_pu.Enable = 'on';
            btn_regression_ex.Enable = 'on';
            return;
        end
    
        [a, b, y_pred, R2, b0, b1, sigma, et_b0, et_b1, et_sigma] = extract_p(x_global, y_global, 'LIN');
        hold(graphe, 'on');
        plot_li = plot(graphe, x_global, y_pred, 'r-', 'LineWidth', 2);
        bruit_fruite();
    
        graphe.Color = [255 250 200]/255;
        graphe.XLabel.Color = [0 0 0];
        graphe.YLabel.Color = [0 0 0];
        graphe.Title.Color  = [0 0 0];
        graphe.XColor = [0 0 0];
        graphe.YColor = [0 0 0];
    
        btn_regression_lo.Enable = 'off';
        btn_regression_pu.Enable = 'off';
        btn_regression_ex.Enable = 'off';
    
        label_R2.Text = sprintf('R² : %.2f', floor(R2*100)/100);
        label_b0.Text = sprintf('b₀ : %.2f', b0);
        label_b1.Text = sprintf('b₁ : %.2f', b1);
        label_sigma.Text = sprintf('σ : %.2f', sigma);
        label_et_b0.Text = sprintf('σ(b₀) : %.2f', et_b0);
        label_et_b1.Text = sprintf('σ(b₁) : %.2f', et_b1);
        label_et_sigma.Text = sprintf('σ(σ) : %.2f', et_sigma);

        [best_model, best_R2] = find_best_regression(x_global, y_global);
        label_best.Text = sprintf('Meilleure régression : %s (R² = %.4f)', best_model, best_R2);
    
    
    end

    function valider_regression_logarithme(src,event)
        if ~donnees_pretes
            return;
        end
        persistent plot_lo;
    
        if ~isempty(plot_lo) && isvalid(plot_lo)
            delete(plot_lo);
            plot_lo = [];
    
            btn_regression_li.Enable = 'on';
            btn_regression_pu.Enable = 'on';
            btn_regression_ex.Enable = 'on';
            return;
        end
    
        [a, b, y_pred, R2, b0,b1,sigma,et_b0,et_b1,et_sigma] = extract_p(x_global, y_global, 'LN');
        hold(graphe, 'on');
        plot_lo = plot(graphe, x_global, y_pred, 'r-', 'LineWidth', 2);
        bruit_fruite();
 
        graphe.Color = [255 250 200]/255;
        graphe.XLabel.Color = [0 0 0];
        graphe.YLabel.Color = [0 0 0];
        graphe.Title.Color  = [0 0 0];
        graphe.XColor = [0 0 0];
        graphe.YColor = [0 0 0];
    
        btn_regression_li.Enable = 'off';
        btn_regression_pu.Enable = 'off';
        btn_regression_ex.Enable = 'off';

        label_R2.Text = sprintf('R² : %.2f', floor(R2*100)/100);
        label_b0.Text = sprintf('b₀ : %.2f', b0);
        label_b1.Text = sprintf('b₁ : %.2f', b1);
        label_sigma.Text = sprintf('σ : %.2f', sigma);
        label_et_b0.Text = sprintf('σ(b₀) : %.2f', et_b0);
        label_et_b1.Text = sprintf('σ(b₁) : %.2f', et_b1);
        label_et_sigma.Text = sprintf('σ(σ) : %.2f', et_sigma);

        [best_model, best_R2] = find_best_regression(x_global, y_global);
        label_best.Text = sprintf('Meilleure régression : %s (R² = %.4f)', best_model, best_R2);
    

    end

    function valider_regression_puissance(src,event)

        if ~donnees_pretes
            return;
        end
        persistent plot_pu;
    
        if ~isempty(plot_pu) && isvalid(plot_pu)
            delete(plot_pu);
            plot_pu = [];
    
            btn_regression_lo.Enable = 'on';
            btn_regression_li.Enable = 'on';
            btn_regression_ex.Enable = 'on';
            return;
        end
    
        [a, b, y_pred, R2, b0,b1, sigma,et_b0,et_b1,et_sigma] = extract_p(x_global, y_global, 'PUI');
        hold(graphe, 'on');
        plot_pu = plot(graphe, x_global, y_pred, 'r-', 'LineWidth', 2);
        bruit_fruite();

        graphe.Color = [255 250 200]/255;
        graphe.XLabel.Color = [0 0 0];
        graphe.YLabel.Color = [0 0 0];
        graphe.Title.Color  = [0 0 0];
        graphe.XColor = [0 0 0];
        graphe.YColor = [0 0 0];
    
        btn_regression_lo.Enable = 'off';
        btn_regression_li.Enable = 'off';
        btn_regression_ex.Enable = 'off';

        label_R2.Text = sprintf('R² : %.2f', floor(R2*100)/100);
        label_b0.Text = sprintf('b₀ : %.2f', b0);
        label_b1.Text = sprintf('b₁ : %.2f', b1);
        label_sigma.Text = sprintf('σ : %.2f', sigma);
        label_et_b0.Text = sprintf('σ(b₀) : %.2f', et_b0);
        label_et_b1.Text = sprintf('σ(b₁) : %.2f', et_b1);
        label_et_sigma.Text = sprintf('σ(σ) : %.2f', et_sigma);

        [best_model, best_R2] = find_best_regression(x_global, y_global);
        label_best.Text = sprintf('Meilleure régression : %s (R² = %.4f)', best_model, best_R2);
       
    end

    function valider_regression_exponentielle(src,event)      
        if ~donnees_pretes
            return;
        end
        persistent plot_ex;
    
        if ~isempty(plot_ex) && isvalid(plot_ex)
            delete(plot_ex);
            plot_ex = [];
    
            btn_regression_lo.Enable = 'on';
            btn_regression_pu.Enable = 'on';
            btn_regression_li.Enable = 'on';
            return;
        end
    
        [a, b, y_pred, R2, b0, b1 sigma, et_b0, et_b1, et_sigma] = extract_p(x_global, y_global, 'EXP');
        hold(graphe, 'on');
        plot_ex = plot(graphe, x_global, y_pred, 'r-', 'LineWidth', 2);
        bruit_fruite();
     
        graphe.Color = [255 250 200]/255;
        graphe.XLabel.Color = [0 0 0];
        graphe.YLabel.Color = [0 0 0];
        graphe.Title.Color  = [0 0 0];
        graphe.XColor = [0 0 0];
        graphe.YColor = [0 0 0];
    
        btn_regression_lo.Enable = 'off';
        btn_regression_pu.Enable = 'off';
        btn_regression_li.Enable = 'off';

        label_R2.Text = sprintf('R² : %.2f', floor(R2*100)/100);
        label_b0.Text = sprintf('b₀ : %.2f', b0);
        label_b1.Text = sprintf('b₁ : %.2f', b1);
        label_sigma.Text = sprintf('σ : %.2f', sigma);
        label_et_b0.Text = sprintf('σ(b₀) : %.2f', et_b0);
        label_et_b1.Text = sprintf('σ(b₁) : %.2f', et_b1);
        label_et_sigma.Text = sprintf('σ(σ) : %.2f', et_sigma);

        [best_model, best_R2] = find_best_regression(x_global, y_global);
        label_best.Text = sprintf('Meilleure régression : %s (R² = %.4f)', best_model, best_R2);
    
    end

    
    function [best_model, best_R2] = find_best_regression(x, y)
    
        [~, ~, ~, R2_lin] = extract_p(x, y, 'LIN');
        [~, ~, ~, R2_ln]  = extract_p(x, y, 'LN');
        [~, ~, ~, R2_exp] = extract_p(x, y, 'EXP');
        [~, ~, ~, R2_pui] = extract_p(x, y, 'PUI');
    
        R2_all = [R2_lin, R2_ln, R2_exp, R2_pui];
    
        [best_R2, idx] = max(R2_all);
    
        models = {'Lin', 'Log', 'Exp', 'Pui'};
        best_model = models{idx};
    
    end


    function reset_interface(src,event)
        donnees_pretes = false;
        x_global = [];
        y_global = [];
    
        cla(graphe);
        graphe.Title.String = 'Graphique réinitialisé';
    
        btn_regression_li.Enable = 'on';
        btn_regression_lo.Enable = 'on';
        btn_regression_ex.Enable = 'on';
        btn_regression_pu.Enable = 'on';
    end

    function export_pdf(~,~)
        if ~donnees_pretes
            uialert(f,'Veuillez afficher le système bruité avant d''exporter.', 'Export impossible');
            return;
        end
    
        [file, path] = uiputfile({'*.pdf','Fichier PDF'}, 'Exporter le graphique en PDF');
        if isequal(file,0)
            return;
        end
    
        [~, name, ext] = fileparts(file);
        if isempty(ext)
            file = [name '.pdf'];
        end
        fullpath = fullfile(path, file);
    
        graphe.Title.String = sprintf('Système bruité – Export du %s', datetime("now"));
    
        text(graphe, 0.02, 0.95, sprintf('Graphique généré automatiquement\nInterface MATLAB – Projet régression'), 'Units','normalized', 'FontSize', 10, 'BackgroundColor', [0 0 0 0.7], 'EdgeColor', [0 0 0]);
    
        text(graphe, 0.5, -0.12, 'Export PDF – Interface MATLAB', 'Units','normalized', 'HorizontalAlignment','center', 'FontAngle','italic');
    
        exportgraphics(graphe, fullpath, 'ContentType', 'vector');
    
        uialert(f, 'PDF exporté avec succès !', 'Succès');
    end

    function changer_theme(src, ~)
        theme_actuel = string(src.Value);

        switch theme_actuel
    
            case 'Yuzu' 
                panel_fct.BackgroundColor = [255 250 200]/255;
                panel_affichage.BackgroundColor = [255 250 200]/255;
                panel_regression.BackgroundColor = [255 250 200]/255;
                panel_pres.BackgroundColor = [223 248 6]/255;
                panel_page1.BackgroundColor = [255 250 200]/255;
                panel_page11.BackgroundColor = [255 250 200]/255;
                panel_page12.BackgroundColor = [255 250 200]/255;
                panel_page13.BackgroundColor = [255 250 200]/255;
                panel_page14.BackgroundColor = [255 250 200]/255;
                panel_page2.BackgroundColor = [255 250 200]/255;
                c1.BackgroundColor = [255 250 200]/255;
                c2.BackgroundColor = [255 250 200]/255;
                c3.BackgroundColor = [255 250 200]/255;
                choix.BackgroundColor = [255 250 200]/255;
                choix.BorderColor = [255 250 200]/255;
                graphe.Color = [1 0.98 0.85];
                graphe.XColor = [0.4 0.3 0];
                graphe.YColor = [0.4 0.3 0];
    
            case 'Orange'
                f.Color = [1 0.85 0.6];
                panel_fct.BackgroundColor = [1 0.85 0.6];
                panel_affichage.BackgroundColor = [1 0.85 0.6];
                panel_regression.BackgroundColor = [1 0.85 0.6];
                panel_pres.BackgroundColor = [1 0.65 0.2];
                panel_page1.BackgroundColor = [1 0.85 0.6];
                panel_page11.BackgroundColor = [1 0.85 0.6];
                panel_page12.BackgroundColor = [1 0.85 0.6];
                panel_page13.BackgroundColor = [1 0.85 0.6];
                panel_page14.BackgroundColor = [1 0.85 0.6];
                panel_page2.BackgroundColor = [1 0.85 0.6];
                c1.BackgroundColor = [1 0.85 0.6];
                c2.BackgroundColor = [1 0.85 0.6];
                c3.BackgroundColor = [1 0.85 0.6];
                choix.BackgroundColor = [1 0.85 0.6];
                choix.BorderColor = [1 0.85 0.6];
                graphe.Color = [1 0.9 0.75];
                graphe.XColor = [0.4 0.2 0];
                graphe.YColor = [0.4 0.2 0];
    
            case 'Pamplemousse'
                f.Color = [1 0.8 0.9];
                panel_fct.BackgroundColor = [1 0.8 0.9];
                panel_affichage.BackgroundColor = [1 0.8 0.9];
                panel_regression.BackgroundColor = [1 0.8 0.9];
                panel_pres.BackgroundColor = [1 0.55 0.7];
                panel_page1.BackgroundColor = [1 0.8 0.9];
                panel_page11.BackgroundColor = [1 0.8 0.9];
                panel_page12.BackgroundColor = [1 0.8 0.9];
                panel_page13.BackgroundColor = [1 0.8 0.9];
                panel_page14.BackgroundColor = [1 0.8 0.9];
                panel_page2.BackgroundColor = [1 0.8 0.9];
                c1.BackgroundColor = [1 0.8 0.9];
                c2.BackgroundColor = [1 0.8 0.9];
                c3.BackgroundColor = [1 0.8 0.9];
                choix.BackgroundColor = [1 0.8 0.9];
                choix.BorderColor = [1 0.8 0.9];
                graphe.Color = [1 0.88 0.94];
                graphe.XColor = [0.5 0 0.3];
                graphe.YColor = [0.5 0 0.3];
        end
    end

    
    function bruit_fruite()
        [y, Fs] = audioread('pop.wav');
        y = y / max(abs(y));             % normalisation (évite saturation)
        sound(y, Fs);   

    end
    
        function mode_debug(~, ~)
    
        switch type_f
            case 1
                type = "Linéaire";
                a_val = a_field_li.Value;
                b_val = b_field_li.Value;
                xmin_val = xmin_field_li.Value;
                xmax_val = xmax_field_li.Value;
    
            case 2
                type = "Logarithmique";
                a_val = a_field_lo.Value;
                b_val = b_field_lo.Value;
                xmin_val = xmin_field_lo.Value;
                xmax_val = xmax_field_lo.Value;

            case 3
                type = "Puissance";
                a_val = a_field_pu.Value;
                b_val = b_field_pu.Value;
                xmin_val = xmin_field_pu.Value;
                xmax_val = xmax_field_pu.Value;

            case 4
                type = "Exponentiel";
                a_val = a_field_ex.Value;
                b_val = b_field_ex.Value;
                xmin_val = xmin_field_ex.Value;
                xmax_val = xmax_field_ex.Value;
    
        end


        switch popup_bruit.Value
            case 1
                type_bruit = "Gaussien"

            case 2
                type_bruit = "Uniforme"

        end
    
        debug = figure('Name','Debug Info','Position',[100 100 350 420]);
    
        texte = [
            "=== DEBUG INFO ==="
            ""
            "Thème actuel : " + theme_actuel
            ""
            "=== Paramètres système ==="
            "Type : " + type
            "a = " + a_val
            "b = " + b_val
            "xmin = " + xmin_val
            "xmax = " + xmax_val
            "n = " + nb_pts_field.Value
            ""
            "=== Paramètres bruit ==="
            "Type : " + type_bruit
            "m = " + m_field.Value
            "sigma = " + sigma_field.Value
        ];
    
        uicontrol('Style','text', 'Parent', debug, 'Position', [10 10 330 400], 'HorizontalAlignment','left', 'FontName','Consolas', 'FontSize',10, 'String', texte);
    end
           
end