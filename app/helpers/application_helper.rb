# Helper principal de l'application - disponible dans TOUTES les vues
# Contient les méthodes utilitaires génériques non liées à un domaine spécifique
module ApplicationHelper

  # Génère le titre complet de la page pour la balise <title>
  # Si un titre spécifique est fourni, il est préfixé au nom de l'application
  # Exemples :
  #   full_title("")           → "GossipBook"
  #   full_title("Connexion")  → "Connexion | GossipBook"
  def full_title(page_title = "")
    # Nom de l'application affiché dans l'onglet du navigateur
    base_title = "GossipBook"
    # Si un titre de page est fourni, on le combine avec le nom de l'app
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

end
