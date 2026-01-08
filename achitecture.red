lib/
  main.dart                          # Point d'entrée de l'application
  core/                              # Code partagé (thème, widgets, services)
    theme/
      app_colors.dart                # Palette de couleurs centralisée
      app_theme.dart                 # Thème Material global
    widgets/
      bottom_nav_bar.dart            # Barre de navigation réutilisable
  features/                          # Fonctionnalités métier
    main/
      pages/
        main_screen.dart             # Écran principal avec navigation
    home/
      presentation/
        pages/
          home_page.dart             # Contenu page d'accueil
        widgets/
          home_header.dart           # En-tête personnalisé
          welcome_card.dart          # Carte de bienvenue
          stats_card.dart            # Widget statistiques
          quick_actions.dart         # Actions rapides
    packages/
      pages/
        packages_page.dart           # Contenu page forfaits
      widgets/
        package_card.dart            # Carte d'un forfait
        packages_header.dart         # En-tête section forfaits
      package_entity.dart            # Modèle de données
      packages_repository.dart       # Données des forfaits